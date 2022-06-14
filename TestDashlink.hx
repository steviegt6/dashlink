import dashlink.Test;
import dashlink.Utils;
import dashlink.Op;

class TestDashlink {
	public static function main():Void {
		trace("Hello, world!");
        trace("OMov nargs: " + Utils.OpNArgs[OMov]);

        var bytes = Test.getFileBytes("hello.hl");
        trace("Test program bytes:\n" + bytes);
	}
}
