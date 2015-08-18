
#import <Cocoa/Cocoa.h>
#import <string>
#import <vector>

#include "./linc_dialogs.h"

namespace linc {

    namespace dialogs {

        //forward declare common helper
      std::string open_select_path( int type, const std::string &title, const std::vector<lincDialogsFilter> &filters );
      std::string dialog_save(const std::string &title, const std::vector<lincDialogsFilter> &filters);

//Haxe facing calls

      ::String open(::String title, ::Array<Dynamic> filters) {

          std::vector<lincDialogsFilter> filter_list;
          int size = filters->size();
          for(int i=0; i<size; ++i) {
              filter_list.push_back(lincDialogsFilter(filters[i]));
          }

          std::string result = open_select_path(0, std::string(title.c_str()), filter_list);

          return ::String(result.c_str());

      } //open

      ::String save(::String title, Dynamic filter) {

          std::vector<lincDialogsFilter> filter_list;

            filter_list.push_back(lincDialogsFilter(filter));

          std::string result = dialog_save(std::string(title.c_str()), filter_list);

          return ::String(result.c_str());

      } //save

      ::String folder(::String title) {

              //dummy filter list, not used by folders
          std::vector<lincDialogsFilter> filter_list;
          std::string result = open_select_path(1, std::string(title.c_str()), filter_list);

          return ::String(result.c_str());

      } //folder

//cpp facing
//helpers

        std::string dialog_save(const std::string &title, const std::vector<lincDialogsFilter> &filters) {

            NSSavePanel *panel = [NSSavePanel savePanel];

            [panel setCanCreateDirectories:YES];
            [panel setAllowsOtherFileTypes:YES];
            [panel setExtensionHidden:YES];

                    //only if there are any filters, add them
                if(filters.size()) {

                    NSMutableArray *type_list = [[NSMutableArray alloc] init];

                        std::vector<lincDialogsFilter>::const_iterator it = filters.begin();

                            for( ; it != filters.end(); ++it ) {

                                [type_list addObject:[NSString stringWithUTF8String:(*it).ext.c_str()]];

                            } //each filter

                        [panel setAllowedFileTypes:type_list];

                    [type_list release];

                } //filters.size

            [panel setTitle: [NSString stringWithUTF8String:title.c_str()] ];

            NSInteger clicked = [panel runModal];

            if (clicked == NSOKButton) {

                NSString *chosen = [[panel URL] path];

                    std::string result = std::string( [chosen UTF8String] );

                [chosen release];

                return result;

            } //OK

            return std::string();

        } //dialog_save

            //common helper,
                //type 0 = open file
                //type 1 = open folder
        std::string open_select_path( int type, const std::string &title, const std::vector<lincDialogsFilter> &filters ) {

            NSOpenPanel * panel = [NSOpenPanel openPanel];

            [panel setAllowsMultipleSelection:NO];
            [panel setFloatingPanel:YES];

            if(type == 0) {
                [panel setCanChooseDirectories:NO];
                [panel setCanChooseFiles:YES];

                    //only if there are any filters, add them
                if(filters.size()) {

                    NSMutableArray *type_list = [[NSMutableArray alloc] init];

                        std::vector<lincDialogsFilter>::const_iterator it = filters.begin();

                            for( ; it != filters.end(); ++it ) {

                                [type_list addObject:[NSString stringWithUTF8String:(*it).ext.c_str()]];

                            } //each filter

                        [panel setAllowedFileTypes:type_list];

                    [type_list release];

                } //filters.size

            } else if(type == 1) {
                [panel setCanChooseDirectories:YES];
                [panel setCanChooseFiles:NO];
            }

            [panel setTitle: [NSString stringWithUTF8String:title.c_str()] ];

            NSInteger clicked = [panel runModal];

            if(clicked == NSOKButton) {

                NSString *chosen = [[panel URL] path];

                    std::string result = std::string( [chosen UTF8String] );

                [chosen release];

                return result;

            } //OK

            return std::string();

        } //open_select_path

    } //dialogs namespace

} //linc namespace
