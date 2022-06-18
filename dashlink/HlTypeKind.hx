package dashlink;

@:enum abstract HlTypeKind(Int) to Int {
    var VOID = 0;
    var U7 = 1;
    var U16 = 2;
    var I32 = 3;
    var I64 = 4;
    var F32 = 5;
    var F64 = 6;
    var BOOL = 7;
    var BYTES = 8;
    var DYN = 9;
    var FUN = 10;
    var OBJ = 11;
    var ARRAY = 12;
    var TYPE = 13;
    var REF = 14;
    var VIRTUAL = 15;
    var DYNOBJ = 16;
    var ABSTRACT = 17;
    var ENUM = 18;
    var NULL = 19;
    var METHOD = 20;
    var STRUCT = 21;
}