package dashlink.impl;

import dashlink.util.Utils;
import dashlink.util.HlCodeDeserializer;
import dashlink.util.Assert;
import dashlink.structures.DebugData;
import dashlink.structures.ByteData;
import dashlink.structures.ContentStructure;
import dashlink.structures.DataStructure;
import dashlink.structures.MainStructure;
import dashlink.exceptions.BytecodeDeserializationException;
import haxe.exceptions.NotImplementedException;
import haxe.io.Input;
import dashlink.api.IBytecodeDeserializer;

class BytecodeDeserializer implements IBytecodeDeserializer {
	public function new() {}

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
		Assert.argumentNotNull(buffer, "buffer");

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
		Assert.argumentNotNull(buffer, "buffer");

		var header = readHeader(buffer);
		var version = readVersion(buffer);
		var flags = readVarUInt(buffer);
		var nints = readVarUInt(buffer);
		var nfloats = readVarUInt(buffer);
		var nstrings = readVarUInt(buffer);
		var nbytes = version >= 5 ? readVarUInt(buffer) : 0;
		var ntypes = readVarUInt(buffer);
		var nglobals = readVarUInt(buffer);
		var nnatives = readVarUInt(buffer);
		var nfunctions = readVarUInt(buffer);
		var nconstants = version >= 4 ? readVarUInt(buffer) : 0;
		var entrypoint = readVarUInt(buffer);
		var hasDebug = flags & 1 == 0 ? false : true;

		return {
			magic: header,
			version: version,
			flags: flags,
			nints: nints,
			nfloats: nfloats,
			nstrings: nstrings,
			nbytes: nbytes,
			ntypes: ntypes,
			nglobals: nglobals,
			nnatives: nnatives,
			nfunctions: nfunctions,
			nconstants: nconstants,
			entrypoint: entrypoint,
			hasdebug: hasDebug
		};
	}

	/**
	 * Reads the content portion of the main structure.
	 * @param buffer The buffer to read from.
	 * @param data The data to use when reading the content.
	 * @return ContentStructure The read content.
	 */
	public function readContentStructure(buffer:Input, data:DataStructure):ContentStructure {
		Assert.argumentNotNull(buffer, "buffer");
		Assert.argumentNotNull(data, "data");

		var ints = readInts(buffer, data.nints);
		var floats = readFloats(buffer, data.nfloats);
		var strings = readStrings(buffer, data.nstrings);
		var bytes = data.version >= 5 ? readBytes(buffer, data.nbytes) : {bytesData: [], bytesPos: []};
		var debugData = data.hasdebug ? readDebug(buffer) : {ndebugfiles: 0, debugfiles: []};
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
		Assert.argumentNotNull(buffer, "buffer");

		throw new haxe.exceptions.NotImplementedException();
	}

	// endregion
	// region utility readers

	/**
	 * Reads the header of a file.
	 * @param buffer The buffer to read from.
	 * @return Array<Int> A byte array containing the values of the read bytes.
	 */
	public function readHeader(buffer:Input):Array<Int> {
		Assert.argumentNotNull(buffer, "buffer");

		var header = [buffer.readByte(), buffer.readByte(), buffer.readByte()];

		if (!Utils.arraysEqual(header, HlCodeDeserializer.magicHeader))
			throw new BytecodeDeserializationException("Did not match magic header \"" + HlCodeDeserializer.magicHeader.toString() + "\", got \""
				+ header.toString());

		trace("Got magic header " + header.toString());
		return header;
	}

	/**
	 * Reads the version of a file.
	 * @param buffer The buffer to read from.
	 * @return Int A byte representing the version.
	 */
	public function readVersion(buffer:Input):Int {
		Assert.argumentNotNull(buffer, "buffer");

		var version = buffer.readByte();

		if (version < HlCodeDeserializer.minVersion)
			throw new BytecodeDeserializationException("Version " + version + " is too old, minimum is " + HlCodeDeserializer.minVersion);

		if (version > HlCodeDeserializer.maxVersion)
			throw new BytecodeDeserializationException("Version " + version + " is too new, maximum is " + HlCodeDeserializer.maxVersion);

		return version;
	}

	/**
	 * Reads a collection of int32s given a known count.
	 * @param buffer The buffer to read from.
	 * @param nints The amount of int32s to read.
	 * @return Array<Int> The collection of int32s.
	 */
	public function readInts(buffer:Input, nints:Int):Array<Int> {
		Assert.argumentNotNull(buffer, "buffer");

		var ints = [];

		for (_ in 0...nints)
			ints.push(buffer.readInt32()); // LITTLE ENDIAN

		return ints;
	}

	/**
	 * Reads a collection of float64s given a known count.
	 * @param buffer The buffer to read from.
	 * @param nfloats The amount of float64s to read.
	 * @return Array<Float> The collection of float64s.
	 */
	public function readFloats(buffer:Input, nfloats:Int):Array<Float> {
		Assert.argumentNotNull(buffer, "buffer");

		var floats = [];

		for (_ in 0...nfloats)
			floats.push(buffer.readDouble()); // LITTLE ENDIAN, this is a float64

		return floats;
	}

	/**
	 * Reads and decodes a collection of strings given a known count.
	 * @param buffer The buffer to read from.
	 * @param nstrings The amount of strings to read.
	 * @return Array<String> The collection of strings.
	 */
	public function readStrings(buffer:Input, nstrings:Int):Array<String> {
		Assert.argumentNotNull(buffer, "buffer");

		var strings = [];

		// Byte data representing every stored character.
		// The data after this describes the length of each string, which we use to get the saved strings.
		var stringData = [];

		// Actually read each string length.
		var count = buffer.readInt32(); // LITTLE ENDIAN
		for (_ in 0...count)
			stringData.push(buffer.readByte()); // LITTLE ENDIAN

		// We want to read every string, we know the amoutn from the passed parameter.
		// Represents the stringsData array offset.
		var arrayOffset = 0;
		for (_ in 0...nstrings) {
			// Get the size of the string we are reading.
			// The additional 1 is for the null terminator.
			var stringSize = readVarUInt(buffer) + 1;

			// Decode the string from a slice, starting at the array offset and ending at the array offset + string length.
			var str = HlCodeDeserializer.stringFromBytes(stringData.slice(arrayOffset, arrayOffset + stringSize));

			strings.push(str);
			arrayOffset += stringSize;
		}

		return strings;
	}

	// TODO: Actually test this implementation.

	/**
	 * Reads a collection of bytes given a known count.
	 * @param buffer The buffer to read from.
	 * @param nbytes The amount of bytes to read.
	 * @return Array<Int> The collection of bytes.
	 */
	public function readBytes(buffer:Input, nbytes:Int):ByteData {
		Assert.argumentNotNull(buffer, "buffer");

		// Fill bytes array with all the bytes, given a size specified at the start.
		var bytes = [];
		var bytesSize = buffer.readInt32(); // LITTLE ENDIAN

		for (_ in 0...bytesSize)
			bytes.push(buffer.readByte()); // LITTLE ENDIAN

		// guh
		var bytesPos = [];
		for (_ in 0...nbytes)
			bytesPos.push(readVarUInt(buffer)); // LITTLE ENDIAN

		return {
			bytesData: bytes,
			bytesPos: bytesPos
		};
	}

	/**
	 * Reads debug data from a file.
	 * @param buffer The buffer to read from.
	 * @return DebugData The read debug data.
	 */
	public function readDebug(buffer:Input):DebugData {
		Assert.argumentNotNull(buffer, "buffer");

		var ndebugfiles = readVarUInt(buffer);
		var debugfiles = readStrings(buffer, ndebugfiles);

		return {
			ndebugfiles: ndebugfiles,
			debugfiles: debugfiles
		};
	}

	// endregion
}
