package dashlink.structures;

import dashlink.structures.hl.HlConstant;
import dashlink.structures.hl.HlFunction;
import dashlink.structures.hl.HlNative;
import dashlink.structures.hl.HlTypeRef;
import dashlink.structures.hl.HlType;

/**
 * Represents the content in the main structure body.
 * 
 * Data `ints` through `constants` of https://github.com/Gui-Yom/hlbc/wiki/Bytecode-file-format#main-structure.
 */
typedef ContentStructure = {
	// TODO: Summaries for all these.
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
