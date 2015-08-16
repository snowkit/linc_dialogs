package dialogs;


@:keep
@:include('linc_dialogs.h')
@:build(linc.Touch.apply())
extern class Dialogs {

    @:native('linc::dialogs::open')
    static function open(title:String, ?filters:Array<FileFilter>) : String;

    @:native('linc::dialogs::save')
    static function save(title:String, ?filter:FileFilter) : String;

    @:native('linc::dialogs::folder')
    static function folder(title:String) : String;

} //Dialogs


typedef FileFilter = {

        /** An extension for the filter. i.e `md`, `txt`, `png` or a special `*` for any file type.  */
    var extension:String;
        /** An optional description for this filter i.e `markdown files`, `text files`, `all files` */
    @:optional var desc:String;

} //FileFilter