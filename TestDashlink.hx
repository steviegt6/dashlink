import dashlink.util.HlCodeDeserializer;
import dashlink.impl.BytecodeDeserializer;

class TestDashlink {
	public static function main():Void {
		var code = HlCodeDeserializer.deserializeFromPath("hello.hl", new BytecodeDeserializer());
		trace(code);
	}
}
