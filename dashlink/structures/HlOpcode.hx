package dashlink.structures;

import dashlink.Op;

typedef HlOpcode = {
    var op:Op;
    var p1:Int;
    var p2:Int;
    var p3:Int;
    var extra:Array<Int>;
}