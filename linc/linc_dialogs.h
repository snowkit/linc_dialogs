#pragma once

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

namespace linc {

    namespace dialogs {

        extern ::String open(::String title, ::Array<Dynamic> filters);
        extern ::String save(::String title, Dynamic filter);
        extern ::String folder(::String title);

        //helpers

            struct lincDialogsFilter {
                ::String ext;       //txt
                ::String desc;      //in desc "text file"
                ::String pattern;   //display pattern "*.txt"
                ::String display;   //display desc "text files (*.txt)"

                    //construct from typedef, doesn't check for null
                lincDialogsFilter(Dynamic from) {
                    ext = from->__Field(HX_CSTRING("ext"), hx::paccDynamic);
                    desc = from->__Field(HX_CSTRING("desc"), hx::paccDynamic);
                    pattern = ::String(HX_CSTRING("*.") + ext);
                    display = ::String(desc + HX_CSTRING(" (") + pattern + HX_CSTRING(")"));
                }
            };

    } //dialogs namespace

} //linc namespace
