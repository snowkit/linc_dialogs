
import dialogs.Dialogs;

    #if (!mac && !android && !ios && !linux && !windows)
        #error "You should define a target, please read and modify build.hxml"
    #end


class Test {

    static function main() {

        var message = Dialogs.message("This is a message.", "Title");
        
        trace(message);
        
      //trace('\t\tcwd ' + Sys.getCwd());
//
      //var result =
        //Dialogs.open('Load trace history',
            //[
                //{ ext:'hxt', desc:'HXTelemetry Dump' },
                //{ ext:'flm', desc:'Flash Telemetry Dump' },
                //{ ext:'gif', desc:'Testing files I have' }
            //]);
//
      //trace("Open result: "+result);
      //trace('\t\tcwd ' + Sys.getCwd());
//
      //result = Dialogs.save('Save trace history', { ext:'hxt', desc:'HXTelemetry Dump' });
//
      //trace("Save result: "+result);
      //trace('\t\tcwd ' + Sys.getCwd());
//
      //result = Dialogs.folder('Select a random folder');
//
      //trace("Folder result: "+result);
      //trace('\t\tcwd ' + Sys.getCwd());
//
      //var result =
        //Dialogs.open('Load trace history');
//
      //trace("Open min-args result: "+result);
//
      //result = Dialogs.save('Save trace history');
//
      //trace("Save min-args result: "+result);
//
      //trace('\t\tcwd ' + Sys.getCwd());

    } //main

} //Test
