using System.IO;

namespace Dashlink.IO; 

public class HashLinkWriter : BinaryWriter {
    public const string VAR_INT_0x20000000_EXCEPTION =
        "Cannot write variable-length integer greater than 0x20000000";
    
    public const string VAR_UINT_0x20000000_EXCEPTION =
        "Cannot write variable-length unsigned integer greater than 0x20000000";
    
    // https://github.com/HaxeFoundation/haxe/blob/f97065a93548554c054d010d4ae28ea8b4dddcee/src/generators/genhl.ml#L3661
    public virtual void WriteVarInt32(int value) {
        if (value < 0) {
            value = -value;

            if (value < 0x2000) {
                Write((byte)((value >> 8) | 0xA0));
                Write((byte)(value & 0xFF));
            }
            else if (value >= 0x20000000) {
                throw new IOException(VAR_INT_0x20000000_EXCEPTION);
            }
            else {
                Write((byte)((value >> 24) | 0xE0));
                Write((byte)((value >> 16) | 0xFF));
                Write((byte)((value >> 8) | 0xFF));
                Write((byte)(value & 0xFF));
            }
        }
        else if (value < 0x80) {
            Write((byte) value);
        }
        else if (value < 0x200) {
            Write((byte)((value >> 8) | 0x80));
            Write((byte)(value & 0xFF));
        }
        else if (value >= 0x20000000) {
            throw new IOException(VAR_INT_0x20000000_EXCEPTION);
        }
        else {
            Write((byte)((value >> 24) | 0xC0));
            Write((byte)((value >> 16) | 0xFF));
            Write((byte)((value >> 8) | 0xFF));
            Write((byte)(value & 0xFF));
        }
    }

    public virtual void WriteVarUInt32(uint value) {
        if (value >= 0x20000000)
            throw new IOException(VAR_UINT_0x20000000_EXCEPTION);

        WriteVarInt32((int) value);
    }
}
