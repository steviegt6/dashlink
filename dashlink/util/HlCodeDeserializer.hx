package dashlink.util;

import haxe.io.Bytes;
import dashlink.impl.BytecodeDeserializer;
import sys.io.File;
import dashlink.structures.MainStructure;
import haxe.io.Input;
import dashlink.api.IBytecodeDeserializer;

class HlCodeDeserializer {
	/**
	 * The magic header of all HashLink bytecode (.hl) files.
	 * Reads as "HLB".
	 */
	public static var magicHeader(default, null) = [0x48, 0x4C, 0x42];

	/**
	 * The minimum bytecode version that may be read.
	 */
	public static var minVersion(default, null) = 1;

	/**
	 * The maximum bytecode version that may be read.
	 */
	public static var maxVersion(default, null) = 5;

	/**
	 * Deserializes a bytecode file given a path.
	 * @param path The path to the bytecode file.
	 * @param deserializer The deserializer to use. If use, uses `dashlink.impl.BytecodeDeserializer`.
	 * @return MainStructure The deserialized structure.
	 */
	public static function deserializeFromPath(path:String, deserializer:Null<IBytecodeDeserializer> = null):MainStructure {
		Assert.argumentNotNull(path, "path");
		return deserializeFromBytes(File.getBytes(path), getDeserializer(deserializer));
	}

	/**
	 * Deserializes a bytecode file given a path.
	 * @param bytes The bytes to deserialize.
	 * @param deserializer The deserializer to use. If use, uses `dashlink.impl.BytecodeDeserializer`.
	 * @return MainStructure The deserialized structure.
	 */
	public static function deserializeFromBytes(bytes:Bytes, deserializer:Null<IBytecodeDeserializer> = null):MainStructure {
		Assert.argumentNotNull(bytes, "bytes");
		return deserializeFromBuffer(Utils.makeByteBuffer(bytes), getDeserializer(deserializer));
	}

	/**
	 * Deserializes a bytecode file given a path. The passed buffer is set to little enian when reading. Its original endianness is restored after.
	 * @param buffer The buffer to read from.
	 * @param deserializer The deserializer to use. If use, uses `dashlink.impl.BytecodeDeserializer`.
	 * @return MainStructure The deserialized structure.
	 */
	public static function deserializeFromBuffer(buffer:Input, deserializer:Null<IBytecodeDeserializer> = null):MainStructure {
		Assert.argumentNotNull(buffer, "buffer");

		var endianness = buffer.bigEndian;
		buffer.bigEndian = false;
		var structure = getDeserializer(deserializer).readMainStructure(buffer);
		buffer.bigEndian = endianness;
		return structure;
	}

	private static function getDeserializer(deserializer:Null<IBytecodeDeserializer>):IBytecodeDeserializer {
		return deserializer == null ? new BytecodeDeserializer() : deserializer;
	}

	// TODO: Figure out how to use UnicodeString here.
	public static function stringFromBytes(bytes:Array<Int>):String {
		Assert.argumentNotNull(bytes, "bytes");

		var str = "";

		// Using String.fromCharCode normally does't work because of black magic.
		for (i in 0...bytes.length) {
			var charCode = bytes[i];

			// Ensure that the character is not a null terminator.
			if (charCode != 0)
				str += String.fromCharCode(charCode);
		}

		return str;
	}
}
