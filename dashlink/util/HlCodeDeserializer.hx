package dashlink.util;

class HlCodeDeserializer {
	/**
	 * The magic header of all HashLink bytecode (.hl) files.
	 * Reads as "HLB".
	 */
	public static var magicHeader(default, null) = [0x48, 0x4C, 0x42];

	/**
	 * The minimum bytecode version that may be read.
	 */
	public static var minVersion(default, null) = 1;

	/**
	 * The maximum bytecode version that may be read.
	 */
	public static var maxVersion(default, null) = 5;

	// TODO: Figure out how to use UnicodeString here.
	public static function stringFromBytes(bytes:Array<Int>):String {
		Assert.argumentNotNull(bytes, "bytes");

		var str = "";

		// Using String.fromCharCode normally does't work because of black magic.
		for (i in 0...bytes.length) {
			var charCode = bytes[i];

			// Ensure that the character is not a null terminator.
			if (charCode != 0)
				str += String.fromCharCode(charCode);
		}

		return str;
	}
}
