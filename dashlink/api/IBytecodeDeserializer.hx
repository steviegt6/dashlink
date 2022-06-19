package dashlink.api;

import dashlink.structures.ContentStructure;
import dashlink.structures.DataStructure;
import dashlink.structures.MainStructure;
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
	 * 
	 * https://github.com/Gui-Yom/hlbc/wiki/Bytecode-file-format#main-structure
	 * @param buffer The buffer to read from.
	 * @return MainStructure The file represented as a collection of objects.
	 */
	function readMainStructure(buffer:Input):MainStructure;

    /**
     * Reads the header of a file.
     * @param buffer The buffer to read from.
     * @return Array<Int> A byte array containing the values of the read bytes.
     */
    function readHeader(buffer:Input):Array<Int>;

    /**
     * Reads the version of a file.
     * @param buffer The buffer to read from.
     * @return Int A byte representing the version.
     */
    function readVersion(buffer:Input):Int;

    /**
     * Reads the data portion of the main structure.
     * @param buffer The buffer to read from.
     * @return DataStructure The read data.
     */
    function readDataStructure(buffer:Input):DataStructure;

    /**
     * Reads the content portion of the main structure.
     * @param buffer The buffer to read from.
     * @param data The data to use when reading the content.
     * @return ContentStructure The read content.
     */
    function readContentStructure(buffer:Input, data:DataStructure):ContentStructure;

	/**
	 * Reads a strings block
	 * 
	 * https://github.com/Gui-Yom/hlbc/wiki/Bytecode-file-format#strings-block
	 * @param buffer The buffer to read from.
	 * @param nstrings The amount of strings to read.
	 * @return Array<String>
	 */
	function readStringsBlock(buffer:Input, nstrings:Int):Array<String>;

	// endregion
}
