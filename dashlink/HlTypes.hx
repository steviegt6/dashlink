/*package dashlink;

import hl.Ref;

typedef HlNative = {
	var lib:String;
	var name:String;
	var t:Ref<HlType>;
	var findex:Int;
}

typedef HlOpcode = {
	var op:HlOp;
	var p1:Int;
	var p2:Int;
	var p3:Int;
	var extra:Array<Int>;
}

typedef HlFunction = {
	var findex:Int;
	var nregs:Int;
	var nops:Int;
	var ref:Int;
	var type:Ref<HlType>;
	var regs:Array<Ref<HlType>>;
	var ops:Array<HlOpcode>;
	var debug:Array<Int>;
	var obj:Ref<HlTypeObj>;
	var field:HlFunctionField;
}

typedef HlFunctionField = {
	var name:String;
	var ref:Ref<HlFunction>;
}

typedef HlConstant = {
	var global:Int;
	var nfields:Int;
	var fields:Array<Int>;
}

typedef HlCode = {
	var version:Int;
	var nints:Int;
	var nFloats:Int;
	var nstrings:Int;
	var nbytes:Int;
	var nglobals:Int;
	var nnatives:Int;
	var nfunctions:Int;
	var nconstants:Int;
	var entrypoint:Int;
	var ndebugfiles:Int;
	var hasDebug:Bool;
	var ints:Array<Int>;
	var floats:Array<Float>; // probably a double
	var strings:Array<String>;
	var stringsLens:Array<Int>;
	var bytes:String;
	var bytesPos:Array<Int>;
	var debugFiles:Array<String>;
	var debugFilesLens:Array<Int>;
	var ustrings:Array<String>;
	var types:Array<HlType>;
	var globals:Array<Ref<HlType>>;
	var natives:Array<HlNative>;
	var functions:Array<HlFunction>;
	var constants:Array<HlConstant>;
	var alloc:HlAlloc;
	var falloc:HlAlloc;
}

typedef HlDebugInfos = {
	var offsets:Array<Dynamic>; // TODO: void pointer here, find a better alternative?: https://github.com/HaxeFoundation/hashlink/blob/master/src/hlmodule.h#L101
	var start:Int;
	var large:Bool;
}

typedef HlCodeHash = {
	var code:Ref<HlCode>;
	var typesHashes:Array<Int>;
	var globalsSigns:Array<Int>;
	var functionsSigns:Array<Int>;
	var functionsHashes:Array<Int>;
	var functionsIndexes:Array<Int>;
}*/
/*typedef HlModule = {
	var code: Ref<HlCode>;
	var codesize: Int;
	var globalsSize: Int;
	var globalsIndexes: Array<Int>;
	var globalsData: Bytes;
}*/

/*ypedef HlType = {
	var kind:HlTypeKind;
	var union:HlTypeUnion;
	var vobjProto:Array<Ref<Dynamic>>;
	var markBits:Array<UInt>;
}

typedef HlTypeUnion = {
	var absName:String;
	var fun:Ref<HlTypeFun>;
	var obj:Ref<HlTypeObj>;
	var tenum:Ref<HlTypeEnum>;
	var virt:Ref<HlTypeVirtual>;
}*/
