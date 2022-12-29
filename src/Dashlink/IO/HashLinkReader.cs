using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace Dashlink.IO;

// IMPORTANT: BinaryReader is little endian, the same as HashLink's file format.
// It should be noted that implementations where this is not guaranteed need to
// keep this in mind while reading.
// This is especially important when reading variable length integers.
public class HashLinkReader : BinaryReader {
    public const int MIN_VERSION = 2;
    public const int MAX_VERSION = 5;

    public const string VAR_UINT_NEGATIVE_EXCEPTION =
        "Variable-length unsigned 32-bit integer cannot be negative!";

    public const string UNSUPPORTED_VERSION_EXCEPTION =
        "Unsupported version: {0}, only versions {1}-{2} are supported.";

    public HashLinkReader(Stream input)
        : base(input) { }

    public HashLinkReader(Stream input, Encoding encoding)
        : base(input, encoding) { }

    public HashLinkReader(Stream input, Encoding encoding, bool leaveOpen)
        : base(input, encoding, leaveOpen) { }

    // https://github.com/HaxeFoundation/hashlink/blob/ced5c152ed07f98e66c00fbac6ebf9d99d05915e/src/code.c#L89
    public virtual int ReadVarInt32() {
        var b = ReadByte();

        if ((b & 0x80) == 0)
            return b & 0x7F;

        if ((b & 0x40) == 0) {
            var v = ReadByte() | ((b & 31) << 8);
            return ((b & 0x20) == 0) ? v : -v;
        }

        var c = ReadByte();
        var d = ReadByte();
        var e = ReadByte();
        var f = ((b & 31) << 24) | (c << 16) | (d << 8) | e;
        return (b & 0x20) == 0 ? f : -f;
    }

    // https://github.com/HaxeFoundation/hashlink/blob/ced5c152ed07f98e66c00fbac6ebf9d99d05915e/src/code.c#L106
    public virtual uint ReadVarUInt32() {
        var i = ReadVarInt32();

        if (i < 0)
            throw new IOException(VAR_UINT_NEGATIVE_EXCEPTION);

        return (uint) i;
    }

    public virtual List<string> ReadStrings(uint nstrings) {
        // Collection of constructed strings to be returned at the end of this
        // method.
        var strings = new List<string>();
        
        // The number of bytes making up all strings.
        var byteCount = ReadInt32();
        
        // Bytes representing every stored character.
        var stringBytes = ReadBytes(byteCount);

        // We want to read every string, we know the the amount from the passed
        // parameter.
        
        // Represents the absolute stringBytes offset.
        var offset = 0;

        for (var i = 0; i < nstrings; i++) {
            // Get the size of the string we are reading, add one to account for
            // the null terminator.
            // Cast unsigned down to signed because we know that they can't actually be
            // greater than int.MaxValue.
            var size = (int) ReadVarUInt32() + 1;
            
            // Decode the string from a slice, starting at the array offset and
            // ending at the array offset + string length.
            var str = Encoding.UTF8.GetString(stringBytes, offset, size - 1);
            
            strings.Add(str);
            offset += size;
        }
        
        return strings;
    }

    public virtual HashLinkFile ReadHashLinkFile() {
        T[] ReadArray<T>(uint length, Func<T> readFunc) {
            var array = new T[length];
            for (var i = 0; i < length; i++)
                array[i] = readFunc();

            return array;
        }

        // Read and validate magic header "HLB".
        var magic = ReadBytes(3);
        if (magic[0] != 72 || magic[1] != 76 || magic[2] != 66)
            throw new IOException("Invalid magic header!");

        var code = new HashLinkFile();

        var version    = ReadByte();
        if (version is < MIN_VERSION or > MAX_VERSION)
            throw new IOException(
                string.Format(
                    UNSUPPORTED_VERSION_EXCEPTION,
                    version,
                    MIN_VERSION,
                    MAX_VERSION
                )
            );
        
        var flags      = ReadVarUInt32();
        var nints      = ReadVarUInt32();
        var nfloats    = ReadVarUInt32();
        var nstrings   = ReadVarUInt32();
        var nbytes     = version >= 5 ? ReadVarUInt32() : 0;
        var ntypes     = ReadVarUInt32();
        var nglobals   = ReadVarUInt32();
        var nnatives   = ReadVarUInt32();
        var nfunctions = ReadVarUInt32();
        var nconstants = version >= 4 ? ReadVarUInt32() : 0;
        var entrypoint = ReadVarUInt32();
        var hasDebug   = flags & 1;

        var ints    = ReadArray(nints, ReadInt32);
        var floats  = ReadArray(nfloats, ReadDouble);
        var strings = ReadStrings(nstrings);

        return code;
    }
}
