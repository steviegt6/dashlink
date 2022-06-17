package dashlink.structures;

enum HlType {
	Void;
	UI8;
	UI16;
	I32;
	I64;
	F32;
	F64;
	Bool;
	Bytes;
	Dyn;
	Fun(args:Array<HlTypeRef>, ret:HlTypeRef);
	Obj(name:String, super:HlTypeRef, fields:Array<HlObjField>, protos:Array<HlObjProto>, bindings:Array<Bindings>);
	Array;
	Type;
	Ref(ref:HlTypeRef);
	Virtual(fields:Array<HlObjField>);
	DynObj;
	Abstract(name:String);
	Enum(name:String, constructs:Array<HlEnumConstruct>);
	Null(ref:HlTypeRef);
	Method(args:Array<HlTypeRef>, ret:HlTypeRef);
	Struct(name:String, super:HlTypeRef, fields:Array<HlObjField>, protos:Array<HlObjProto>, bindings:Array<Bindings>);
}

typedef Bindings = {
	var one:UInt;
	var two:UInt;
}
