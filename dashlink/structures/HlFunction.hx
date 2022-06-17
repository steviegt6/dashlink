package dashlink.structures;

import dashlink.structures.HlOpcode;
import dashlink.structures.HlTypeRef;

typedef HlFunction = {
	var t:HlTypeRef;
	var findex:UInt;
	var regs:Array<HlTypeRef>;
	var ops:Array<HlOpcode>;
	var debugInfo:Array<HlFunctionDebugInfo>;
}

typedef HlFunctionDebugInfo = {
	var one:Int;
	var two:Int;
}
