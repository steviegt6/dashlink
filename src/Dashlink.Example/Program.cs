using System;
using System.IO;
using Dashlink.IO;

if (args.Length == 0)
    throw new Exception("No arguments specified");

Console.WriteLine("Reading HashLink file from path:" + args[0]);

using var stream = File.Open(
    args[0],
    FileMode.Open,
    FileAccess.Read,
    FileShare.Read
);
using var reader = new HashLinkReader(stream);
var code = reader.ReadHashLinkFile();
Console.WriteLine("HashLink file read successfully: " + code);
