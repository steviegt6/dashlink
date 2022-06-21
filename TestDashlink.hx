import dashlink.impl.BytecodeDeserializer;
import dashlink.api.IBytecodeDeserializer;
import sys.io.File;
import dashlink.Utils;

class TestDashlink {
	public static function main():Void {
		var deserializer:IBytecodeDeserializer = new BytecodeDeserializer();
		var bytes = File.getBytes("hello.hl");
		var buffer = Utils.makeByteBuffer(bytes);
		buffer.bigEndian = false; // We want little endian for deserialization..
		var code = deserializer.readMainStructure(buffer);
		trace(code);
	}
}
