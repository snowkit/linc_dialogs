
#include "./linc_dialogs.h"

namespace linc {

    namespace dialogs {

      ::String open(::String title, ::Array<Dynamic> filters) {

        int size = filters->size();
        for(int i=0; i<size; ++i) {

          lincDialogsFilter filter(filters[i]);

          printf("filter\n\text:`%s`\n\tdesc:`%s`\n\tpattern:`%s`\n\tdisplay:`%s`\n",
              filter.ext.c_str(), filter.desc.c_str(), filter.pattern.c_str(), filter.display.c_str());

        }

        return ::String("result");

      } //open

//        ::String dialog_open(const ::String &title, const std::vector<file_filter> &filters) {
//        } //dialog_open
// 
//        ::String dialog_save(const ::String &title, const std::vector<file_filter> &filters) {
//        } //dialog_save
// 
//        ::String dialog_folder(const ::String &title) {
// 
//                std::vector<file_filter> filters;
//        } //dialog_folder

    } //dialogs namespace

} //linc namespace
