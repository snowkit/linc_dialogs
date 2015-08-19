package dialogs;

import cpp.vm.Thread;


@:keep
@:build(linc.Touch.apply())
@:buildXml("<include name='${haxelib:linc_dialogs}/linc/linc_dialogs.xml'/>")
class Dialogs {

    public static function open(title:String, ?filters:Array<FileFilter>) : String {

        #if mac
            return DialogsLinc.open(title, filters);
        #else

            var primary = Thread.current();
                //make a copy
            var tf = (filters != null) ? filters.copy() : null;
            var of = ''+title;

            Thread.create(function(){
                primary.sendMessage(DialogsLinc.open(of, tf));
            });

            return Thread.readMessage(true);

        #end

    } //open

    public static function save(title:String, ?filter:FileFilter) : String {
        return DialogsLinc.save(title, filter);
    } //save

    public static function folder(title:String) : String {
        return DialogsLinc.folder(title);
    } //folder

} //Dialogs

@:include('linc_dialogs.h')
private extern class DialogsLinc {
    
    @:native('linc::dialogs::open')
    static function open(title:String, ?filters:Array<FileFilter>) : String;

    @:native('linc::dialogs::save')
    static function save(title:String, ?filter:FileFilter) : String;

    @:native('linc::dialogs::folder')
    static function folder(title:String) : String;

} //DialogsLinc


typedef FileFilter = {

        /** An extension for the filter. i.e `md`, `txt`, `png` or a special `*` for any file type.  */
    var ext:String;
        /** An optional description for this filter i.e `markdown files`, `text files`, `all files` */
    @:optional var desc:String;

} //FileFilter
