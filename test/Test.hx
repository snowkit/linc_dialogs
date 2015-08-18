
import dialogs.Dialogs;

    #if (!mac && !android && !ios && !linux && !windows)
        #error "You should define a target, please read and modify build.hxml"
    #end


class Test {

    static function main() {

      var result = Dialogs.open('Load trace history', [{ extension:'hxt', desc:'HXTelemetry Dump' }, { extension:'flm', desc:'Flash Telemetry Dump' }]);
      trace("Got result: "+result);

    } //main

} //Test
