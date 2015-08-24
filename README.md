# linc/dialogs

Haxe @:native bindings for Folder, Open and Save dialogs across Windows, Mac and Linux (GTK 3+)

This is a [linc](http://snowkit.github.io/linc/) library.

---

This library works with the Haxe cpp target only.

---

### Example usage

notes:
    - some platforms, when there is no Main Window, have focus issues with cli
    - cancelled or failed dialogs return a blank string, test for it
    
```haxe

import dialogs.Dialogs;

class Test {

    static function main() {

      var result =
        Dialogs.open('Load image',
            [
                { ext:'gif', desc:'GIF image' },
                { ext:'png', desc:'PNG image' }
            ]
        );

      trace("Open result: "+result);

      result = Dialogs.save('Save text file',
            { ext:'txt', desc:'Text file' }
      );

      trace("Save result: "+result);

      result = Dialogs.folder('Select a random folder');

      trace("Folder result: "+result);

    }
} 

```

