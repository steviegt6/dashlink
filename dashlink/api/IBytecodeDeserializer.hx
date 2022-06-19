package dashlink.api;

import haxe.io.Input;

/**
 * Describes an object capable of deserializer a HashLink bytecode file.
 * 
 * See also: https://github.com/Gui-Yom/hlbc/wiki/Bytecode-file-format
 */
interface IBytecodeDeserializer {
	// region variable integer reading

	/**
	 * Reads a variable sized signed integer.
	 * 
	 * https://github.com/Gui-Yom/hlbc/wiki/Bytecode-file-format#variable-sized-integers
	 * @param buffer The buffer to read from.
	 * @return Int The integer value.
	 */
	function readVarInt(buffer:Input):Int;

	/**
	 * Reads a variable sized signed integer.
	 * 
	 * https://github.com/Gui-Yom/hlbc/wiki/Bytecode-file-format#variable-sized-integers
	 * @param buffer The buffer to read from.
	 * @return Int The integer value. Unsigned but the returned value may be expected to have the same upper limit as an Int.
	 */
	function readVarUInt(buffer:Input):Int; // Easier to return an Int rather than a UInt.

	// endregion

	// region main structure reading

    /**
     * Deserializes the main structure of this bytecode file. Essentially reads the entire file.
     * @param buffer 
     * @return MainStructure The file represented as a collection of objects.
     */
    function readMainStructure(buffer:Input):MainStructure;

	// endregion
}
