
import dialogs.Dialogs;

    #if (!mac && !android && !ios && !linux && !windows)
        #error "You should define a target, please read and modify build.hxml"
    #end


class Test {

    static function main() {

      var result =
        Dialogs.open('Load trace history',
            [
                { ext:'hxt', desc:'HXTelemetry Dump' },
                { ext:'flm', desc:'Flash Telemetry Dump' },
                { ext:'gif', desc:'Testing files I have' }
            ]);

      trace("Open result: "+result);

      result = Dialogs.save('Save trace history', { ext:'hxt', desc:'HXTelemetry Dump' });

      trace("Save result: "+result);

      result = Dialogs.folder('Select a random folder');

      trace("Folder result: "+result);

    } //main

} //Test
