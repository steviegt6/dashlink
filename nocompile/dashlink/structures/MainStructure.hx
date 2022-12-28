package dashlink.structures;

import dashlink.structures.ContentStructure;
import dashlink.structures.DataStructure;

/**
 * The main structure of a HashLink bytecode file. This structure has been split into two smaller ones for convenience.
 * 
 * https://github.com/Gui-Yom/hlbc/wiki/Bytecode-file-format#main-structure
 */
typedef MainStructure = {
	var data:DataStructure;
	var content:ContentStructure;
}
