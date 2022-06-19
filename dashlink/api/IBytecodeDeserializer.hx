package dashlink.api;

import haxe.io.Input;

/**
 * Describes an object capable of deserializer a HashLink bytecode file.
 * 
 * See also: https://github.com/Gui-Yom/hlbc/wiki/Bytecode-file-format
 */
interface IBytecodeDeserializer {
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
     * @return UInt The integer value. Unsigned but the returned value may be expected to have the same upper limit as an Int.
     */
    function readVarUInt(buffer:Input):UInt;
}