package dashlink;

import haxe.exceptions.ArgumentException;

class Assert {
    public static function argumentNotNull(argument:Null<Dynamic>, argumentName:String, message:Null<String> = null):Void {
        if (argument != null)
            return;

        // Rather ironic.
        var name = argumentName == null ? "<unknown argument>" : argumentName;

        throw new ArgumentException('Argument "$name" was null\n' + message);
    }
}