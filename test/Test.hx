

import dialogs.Dialogs;

class Test {

    static function main() {

      var result = Dialogs.open('Load trace history', [{ extension:'.hxscout', desc:'hxscout dump' }]);
      trace("Got result: "+result);

    } //main

} //Test
