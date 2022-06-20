package dashlink.structures;

/**
 * Represents the (mostly numerical) data of a main structure body.
 * 
 * Data `magic` through `entrypoint` of https://github.com/Gui-Yom/hlbc/wiki/Bytecode-file-format#main-structure.
 */
typedef DataStructure = {
	/**
	 * Three bytes representing the header, should be "HLB".
	 */
	var magic:Array<Int>;

	/**
	 * A byte-represented version identifier.
	 */
	var version:Int;

	// TODO: Summaries for all these.
	var flags:Int;
	var nints:Int;
	var nfloats:Int;
	var nstrings:Int;
	var nbytes:Int;
	var ntypes:Int;
	var nglobals:Int;
	var nnatives:Int;
	var nfunctions:Int;
	var nconstants:Int;
	var entrypoint:Int;
    var hasdebug:Bool;
}
