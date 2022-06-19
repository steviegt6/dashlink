package dashlink;

import dashlink.structures.hl.HlConstant;
import dashlink.structures.hl.HlFunction;
import dashlink.structures.hl.HlNative;
import dashlink.structures.hl.HlTypeRef;
import dashlink.structures.hl.HlType;

/**
 * The main structure of a HashLink bytecode file.
 * 
 * https://github.com/Gui-Yom/hlbc/wiki/Bytecode-file-format#main-structure
 */
typedef MainStructure = {
	/**
	 * A string making up the first three bytes of a file, should be "HLB".
	 */
	var magic:String;

	/**
	 * A byte-represented version identifier.
	 */
	var version:Int;

    // TODO: Summaries for all these.
	var flags:Int;
	var nints:Int;
	var nfloats:Int;
	var nstrings:Int;
	var nbytes:Int;
	var ntypes:Int;
	var nglobals:Int;
	var nnatives:Int;
	var nfunctions:Int;
	var nconstants:Int;
	var entrypoint:Int;
    var ints:Array<Int>;
    var floats:Array<Float>;
    var strings:Array<String>;
    var bytesSize:Int;
    var bytesData:Array<Int>;
    var bytesPos:Array<Int>;
    var ndebugfiles:Int;
    var debugfiles:Array<String>;
    var types:Array<HlType>;
    var globals:Array<HlTypeRef>;
    var natives:Array<HlNative>;
    var functions:Array<HlFunction>;
    var constants:Array<HlConstant>;
}
