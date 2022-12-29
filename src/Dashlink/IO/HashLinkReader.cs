using System.IO;
using System.Text;

namespace Dashlink.IO;

// IMPORTANT: BinaryReader is little endian, the same as HashLink's file format.
// It should be noted that implementations where this is not guaranteed need to
// keep this in mind while reading.
// This is especially important when reading variable length integers.
public class HashLinkReader : BinaryReader {
    public const string VAR_UINT_NEGATIVE_EXCEPTION =
        "Variable-length unsigned 32-bit integer cannot be negative!";

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
}
