package dashlink;

import haxe.Utf8;
import haxe.io.Encoding;
import hl.UI8;
import dashlink.HlCodeDeserializer.HlCode;
import haxe.io.BytesInput;
import haxe.io.BufferInput;
import haxe.io.Bytes;

/**
 * Miscellaneous utilities for existing classes.
 */
class Utils {
	/**
	 * Maps opcodes to their associated argument number.
	 */
	public static var OpNArgs = [
		Op.OMov => 2,
		Op.OInt => 2,
		Op.OFloat => 2,
		Op.OBool => 2,
		Op.OBytes => 2,
		Op.OString => 2,
		Op.ONull => 1,
		//
		Op.OAdd => 3,
		Op.OSub => 3,
		Op.OMul => 3,
		Op.OSDiv => 3,
		Op.OUDiv => 3,
		Op.OSMod => 3,
		Op.OUMod => 3,
		Op.OShl => 3,
		Op.OSShr => 3,
		Op.OUShr => 3,
		Op.OAnd => 3,
		Op.OOr => 3,
		Op.OXor => 3,
		//
		Op.ONeg => 2,
		Op.ONot => 2,
		Op.OIncr => 1,
		Op.ODecr => 1,
		//
		Op.OCall0 => 2,
		Op.OCall1 => 3,
		Op.OCall2 => 4,
		Op.OCall3 => 5,
		Op.OCall4 => 6,
		Op.OCallN => -1,
		Op.OCalLMethod => -1,
		Op.OCallThis => -1,
		Op.OCallClosure => -1,
		//
		Op.OStaticClosure => 2,
		Op.OInstanceClosure => 3,
		Op.OVirtualClosure => 3,
		//
		Op.OGetGlobal => 2,
		Op.OSetGlobal => 2,
		Op.OField => 3,
		Op.OSetField => 3,
		Op.OGetThis => 2,
		Op.OSetThis => 2,
		Op.ODynGet => 3,
		Op.ODynSet => 3,
		//
		Op.OJTrue => 2,
		Op.OJFalse => 2,
		Op.OJNull => 2,
		Op.OJNotNull => 2,
		Op.OJSLt => 3,
		Op.OJSGte => 3,
		Op.OJSGt => 3,
		Op.OJSLte => 3,
		Op.OJULt => 3,
		Op.OJUGte => 3,
		Op.OJNotLt => 3,
		Op.OJNotGte => 3,
		Op.OJEq => 3,
		Op.OJNotEq => 3,
		Op.OJAlways => 1,
		//
		Op.OToDyn => 2,
		Op.OToSFloat => 2,
		Op.OToUFloat => 2,
		Op.OToInt => 2,
		Op.OSafeCast => 2,
		Op.OUnsafeCast => 2,
		Op.OToVirtual => 2,
		//
		Op.OLabel => 0,
		Op.ORet => 1,
		Op.OThrow => 1,
		Op.ORethrow => 1,
		Op.OSwitch => -1,
		Op.ONullCheck => 1,
		Op.OTrap => 2,
		Op.OEndTrap => 1,
		//
		Op.OGetI8 => 3,
		Op.OGetI16 => 3,
		Op.OGetMem => 3,
		Op.OGetArray => 3,
		Op.OSetI8 => 3,
		Op.OSetI16 => 3,
		Op.OSetMem => 3,
		Op.OSetArray => 3,
		//
		Op.ONew => 1,
		Op.OArraySize => 2,
		Op.OType => 2,
		Op.OGetType => 2,
		Op.OGetTID => 2,
		//
		Op.ORef => 2,
		Op.OUnref => 2,
		Op.OSetref => 2,
		//
		Op.OMakeEnum => -1,
		Op.OEnumAlloc => 2,
		Op.OEnumIndex => 2,
		Op.OEnumField => 4,
		Op.OSetEnumField => 3,
		//
		Op.OAssert => 0,
		Op.ORefData => 2,
		Op.ORefOffset => 3,
		Op.ONop => 0,
		//
		Op.OLast => 0,
	];

	/**
	 * Constructs a `BufferInput` from a `Bytes` instance using a `BytesInput`.
	 * @param bytes 
	 * @return BufferInput
	 */
	public static function makeByteBuffer(bytes:Bytes):BufferInput {
		return new BufferInput(new BytesInput(bytes), bytes);
	}

	public static function arraysEqual(array1:Array<Dynamic>, array2:Array<Dynamic>):Bool {
		if (array1.length != array2.length)
			return false;

		for (i in 0...array1.length) {
			if (array1[i] != array2[i])
				return false;
		}

		return true;
	}

	public static function bytesFromArray(array:Array<UI8>):Bytes {
		var bytes = Bytes.alloc(array.length);

		for (i in 0...array.length) {
			bytes.set(i, array[i]);
		}

		return bytes;
	}

	// TODO: Figure out how to use UnicodeString here.
	public static function stringFromBytes(bytes:Array<Int>):String {
		var str = "";

		// Using String.fromCharCode normally does't work because of black magic.
		for (i in 0...bytes.length)
			str += String.fromCharCode(bytes[i]);
		

		return str;
	}
}
