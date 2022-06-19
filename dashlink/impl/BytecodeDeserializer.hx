package dashlink.impl;

import dashlink.structures.ContentStructure;
import dashlink.structures.DataStructure;
import dashlink.structures.MainStructure;
import dashlink.exceptions.BytecodeDeserializationException;
import haxe.exceptions.NotImplementedException;
import haxe.io.Input;
import dashlink.api.IBytecodeDeserializer;

class BytecodeDeserializer implements IBytecodeDeserializer {
	// region variable interfer reading

	/**
	 * Reads a variable sized signed integer.
	 * 
	 * https://github.com/Gui-Yom/hlbc/wiki/Bytecode-file-format#variable-sized-integers
	 * @param buffer The buffer to read from.
	 * @return Int The integer value.
	 */
	public function readVarInt(buffer:Input):Int {
		var b1 = buffer.readByte();

		// If only one byte in size.
		if (b1 & 0x80 == 0)
			return b1 & 0x7F;

		var b2 = buffer.readByte();

		// If only two bytes in size.
		if (b1 & 0x40 == 0) {
			var value = b2 | ((b1 & 31) << 8);

			return b1 & 0x20 == 0 ? value : -value;
		}

		// If four bytes in size.

		var b3 = buffer.readByte();
		var b4 = buffer.readByte();
		var value = ((b1 & 31) << 24) | (b2 << 16) | (b3 << 8) | b4;

		return b1 & 0x20 == 0 ? value : -value;
	}

	/**
	 * Reads a variable sized signed integer.
	 * 
	 * https://github.com/Gui-Yom/hlbc/wiki/Bytecode-file-format#variable-sized-integers
	 * @param buffer The buffer to read from.
	 * @return Int The integer value. Unsigned but the returned value may be expected to have the same upper limit as an Int.
	 */
	public function readVarUInt(buffer:Input):Int {
		var value = readVarInt(buffer);

		if (value < 0)
			throw new BytecodeDeserializationException("Variable sized unsigned integer cannot be negative, got " + value);

		return value;
	}

	// endregion
	// region main structure reading

	public function readMainStructure(buffer:Input):MainStructure {
        // TODO: Just set to little endian ourselves?
        if (buffer.bigEndian)
            throw new BytecodeDeserializationException("Big endian deserialization is not supported, use little endian");

		var data = readDataStructure(buffer);
		var content = readContentStructure(buffer, data);

		return {
			data: data,
			content: content
		};
	}

	/**
	 * Reads the data portion of the main structure.
	 * @param buffer The buffer to read from.
	 * @return DataStructure The read data.
	 */
	public function readDataStructure(buffer:Input):DataStructure {
		throw new haxe.exceptions.NotImplementedException();
	}

	/**
	 * Reads the content portion of the main structure.
	 * @param buffer The buffer to read from.
	 * @param data The data to use when reading the content.
	 * @return ContentStructure The read content.
	 */
	public function readContentStructure(buffer:Input, data:DataStructure):ContentStructure {
		throw new haxe.exceptions.NotImplementedException();
	}

	/**
	 * Reads a strings block
	 * 
	 * https://github.com/Gui-Yom/hlbc/wiki/Bytecode-file-format#strings-block
	 * @param buffer The buffer to read from.
	 * @param nstrings The amount of strings to read.
	 * @return Array<String>
	 */
	public function readStringsBlock(buffer:Input, nstrings:Int):Array<String> {
		throw new haxe.exceptions.NotImplementedException();
	}

	// endregion
}
