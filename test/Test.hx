

import dialogs.Dialogs;

class Test {

    static function main() {

      var result = Dialogs.open('Load trace history', [{ extension:'hxt', desc:'HXTelemetry Dump' }, { extension:'flm', desc:'Flash Telemetry Dump' }]);
      trace("Got result: "+result);

    } //main

} //Test
