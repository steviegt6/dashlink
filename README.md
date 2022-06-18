**A majority** of the deserialization/disassembly code is adapted from [**@Gui-Yom's**](https://github.com/Gui-Yom) [wonderful Rust dissassembler](https://github.com/Gui-Yom/hlbc.git) under the MIT license.

---

# **_dashlink_**

<h6>A HashLink bytecode disassembler, inspector, and writer.</h6>

Dashlink, stylized as **dashlink**, is a disassembler for [HashLink](https://github.com/HaxeFoundation/hashlink) bytecode developed with the goal of allowing users to dump HL bytecode, rewrite compiled code, and create compiled bytecode from scratch -- all through the power of a Haxe library.

## Practical Uses

This may be used for reverse-engineering Haxe programs compiled to HashLink bytecode (for whatever reason that's needed), programmatically creating HashLink programs for various utility purposes, or for dynamically rewriting/otherwise modifying programs. One such example of the latter is using a bootstrapper to weave together external assemblies at runtime.

## Extra Resources

There are numerous additional resources you may indulge in for further studying or tooling, including:

- [Gui-Yom/hlbc](https://github.com/Gui-Yom/hlbc), a HashLink disassembler written in Rust.
  - Much of the deserialization/disassembly code featured in this repository is adapted from here.
  - The [reverse-engineered HashLink documentation](https://github.com/Gui-Yom/hlbc/wiki) featured on the repository's wiki is an extremely valuable resource as well.
- [HaxeFoundation/hashlink](https://github.com/HaxeFoundation/hashlink), the HashLink virtual machine's source code, containing lots of important information.
  - The [GitHub wiki](https://github.com/HaxeFoundation/hashlink/wiki) containing various pieces of information.
  - The actual HashLink virtual machine provides useful tools for reverse-engineering as well. Mostly notably, [dumping](https://github.com/HaxeFoundation/hashlink/wiki/Profiler).
- [The HashLink blog](https://haxe.org/blog/hashlink-indepth/), featured on the [haxe.org](https://haxe.org/) website. While slightly dated, it goes into detail about various aspects of development and the virtual machine.
