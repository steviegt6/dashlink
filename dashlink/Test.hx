package dashlink;

import sys.io.File;
import haxe.io.Bytes;

class Test {
    public static function getFileBytes(path:String): Bytes {
        return File.getBytes(path);
    }
}