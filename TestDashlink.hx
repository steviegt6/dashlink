import sys.io.File;
import dashlink.HlCodeDeserializer;
import dashlink.Utils;
import dashlink.Op;

class TestDashlink {
	public static function main():Void {
		trace("Hello, world!");
        trace("OMov nargs: " + Utils.OpNArgs[OMov]);

        var bytes = File.getBytes("hello.hl");
        var code = HlCodeDeserializer.deserializeFromBytes(bytes);
	}
}
