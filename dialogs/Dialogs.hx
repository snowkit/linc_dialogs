package dialogs;


@:keep
@:include('linc_dialogs.h')
#if !display
@:build(linc.Linc.touch())
@:build(linc.Linc.xml('dialogs'))
#end
extern class Dialogs {

    @:native('linc::dialogs::open')
    private static function _open(title:String, ?filters:Array<FileFilter>) : String;
    static inline function open(title:String, ?filters:Array<FileFilter>, ?preserve_cwd:Bool=true) : String {

        var _pre_cwd = Sys.getCwd();
        var _result = _open(title, filters);

        if(preserve_cwd) {
            Sys.setCwd(_pre_cwd);
        }

        return _result;
    
    } //open

    @:native('linc::dialogs::save')
    private static function _save(title:String, ?filter:FileFilter) : String;
    static inline function save(title:String, ?filter:FileFilter, ?preserve_cwd:Bool=true) : String {

        var _pre_cwd = Sys.getCwd();
        var _result = _save(title, filter);

        if(preserve_cwd) {
            Sys.setCwd(_pre_cwd);
        }

        return _result;
    
    } //save

    @:native('linc::dialogs::folder')
    private static function _folder(title:String) : String;
    static inline function folder(title:String, ?preserve_cwd:Bool=true) : String {

        var _pre_cwd = Sys.getCwd();
        var _result = _folder(title);

        if(preserve_cwd) {
            Sys.setCwd(_pre_cwd);
        }

        return _result;

    } //folder
    
    @:native('linc::dialogs::message')
    private static function _message(message:String, caption:String) : Bool;
    static inline function message(message:String, caption:String) : Bool {
        var _result = _message(message, caption);
        
        return _result;
    }

} //Dialogs


typedef FileFilter = {

        /** An extension for the filter. i.e `md`, `txt`, `png` or a special `*` for any file type.  */
    var ext:String;
        /** An optional description for this filter i.e `markdown files`, `text files`, `all files` */
    @:optional var desc:String;

} //FileFilter
