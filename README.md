**A majority** of the deserialization/disassembly code is adapted from [**@Gui-Yom's**](https://github.com/Gui-Yom) [wonderful Rust dissassembler](https://github.com/Gui-Yom/hlbc.git) under the MIT license.

---

# **_dashlink_**

<h6>A HashLink bytecode disassembler, inspector, and writer.</h6>

Dashlink, stylized as **dashlink**, is a disassembler for [HashLink](https://github.com/HaxeFoundation/hashlink) bytecode developed with the goal of allowing users to dump HL bytecode, rewrite compiled code, and create compiled bytecode from scratch -- all through the power of a Haxe library.

## Practical Uses

This may be used for reverse-engineer Haxe programs compiled to HashLink bytecode (for whatever reason that's needed), programmatically creating HashLink programs for various utility purposes, or for dynamically rewriting/otherwise modifying programs. One such example of the various latter is using a bootstrapper to weave together external assemblies at runtime.
