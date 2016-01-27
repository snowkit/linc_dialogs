
#include <string>
#include <vector>

#include <windows.h>
#include <shlobj.h>

#include "./linc_dialogs.h"

namespace linc {

    namespace dialogs {

        //forward declare common helper
      std::string open_select_path(int type, const std::string &title, const std::vector<lincDialogsFilter> &filters);
      std::string dialog_folder(const std::string &title);
      void show_message(const std::string &message, const std::string &caption);

//Haxe facing calls

      ::String open(::String title, ::Array<Dynamic> filters) {

        std::vector<lincDialogsFilter> filter_list;
        if (filters!=null()) {
          int size = filters->size();
          for(int i=0; i<size; ++i) {
            filter_list.push_back(lincDialogsFilter(filters[i]));
          }
        }
        std::string result = open_select_path(0, std::string(title.c_str()), filter_list);

        return ::String(result.c_str());

      } //open

      ::String save(::String title, Dynamic filter) {
        std::vector<lincDialogsFilter> filter_list;
        if (filter!=null()) filter_list.push_back(lincDialogsFilter(filter));
        std::string result = open_select_path(1, std::string(title.c_str()), filter_list);

        return ::String(result.c_str());
      } //save

      ::String folder(::String title) {
        std::string result = dialog_folder(std::string(title.c_str()));

        return ::String(result.c_str());
      } //folder
      
      ::Bool message(::String message, ::String caption)
      {
          ::Bool result = false;
          const std::string c_message = std::string(message.c_str());
          const std::string c_caption = std::string(caption.c_str());
          
          show_message(c_message, c_caption);
          result = true;
          
          return result;
      }

      std::string lpw_to_stdstring(const LPWSTR str, UINT page = CP_ACP) {

        std::string result; char* cstr = 0;
        int len;

        len = WideCharToMultiByte(page, 0, str, -1, 0,  0, 0, 0);
        if (len > 0) {
          cstr = new char[len];
          int res = WideCharToMultiByte(page, 0, str, -1, cstr, len, 0, 0);
          if (res != 0) {
            cstr[len-1] = 0;
            result = std::string(cstr);
          }
          delete [] cstr;
        }

        return result;

      } //lpw_to_stdstring

      std::string dialog_folder(const std::string &title) {

        std::string path;

        HRESULT hr = CoInitializeEx(NULL, COINIT_APARTMENTTHREADED | COINIT_DISABLE_OLE1DDE);

        if(SUCCEEDED(hr)) {

          IFileDialog *folder_dialog;

          hr = CoCreateInstance(CLSID_FileOpenDialog, NULL, CLSCTX_ALL, IID_IFileOpenDialog, reinterpret_cast<void**>(&folder_dialog));

          if(SUCCEEDED(hr)) {

            DWORD folder_options;
            if (SUCCEEDED(folder_dialog->GetOptions(&folder_options))) {
              folder_dialog->SetOptions(folder_options | FOS_PICKFOLDERS);
            }

            hr = folder_dialog->Show(NULL);

            if(SUCCEEDED(hr)) {

              IShellItem *_item;
              hr = folder_dialog->GetResult(&_item);

              if(SUCCEEDED(hr)) {

                LPWSTR selected_path = NULL;
                hr = _item->GetDisplayName(SIGDN_DESKTOPABSOLUTEPARSING, &selected_path);

                if(SUCCEEDED(hr)) {
                  path = lpw_to_stdstring(selected_path);
                  CoTaskMemFree(selected_path);
                }

                _item->Release();

              } //get result

            } //show

            folder_dialog->Release();

          } //create folder dialog

          CoUninitialize();

        } //coinitialize

        return path;

      } //dialog_folder

      //common helper
      //type 0 == file open
      //type 1 == file save
      std::string open_select_path(int type, const std::string &title, const std::vector<lincDialogsFilter> &filters) {

        OPENFILENAME ofn;
        char path[MAX_PATH] = "";
        std::string final;

        ZeroMemory(&ofn, sizeof(ofn));

        ofn.lStructSize = sizeof(ofn);

        ofn.lpstrFile = path;
        ofn.lpstrTitle = title.c_str();
        ofn.nMaxFile = MAX_PATH;
        ofn.Flags = 0;

        //:todo:
        // ofn.lpstrDefExt = "*";
        if(filters.size()) {

          std::vector<lincDialogsFilter>::const_iterator it = filters.begin();
          for( ; it != filters.end(); ++it) {

            lincDialogsFilter filter = (*it);

            std::string _desc(filter.desc.c_str());
            std::string _ext(filter.ext.c_str());
            final += _desc + " (*." + _ext + ")";
            final.push_back('\0');
            final += "*." + _ext;
            final.push_back('\0');

          } //each filter

          final.push_back('\0');
          ofn.lpstrFilter = final.c_str();

        } else {
          ofn.lpstrFilter = "All Files (*.*)\0*.*\0";
        }


        if(type == 0) {

          ofn.Flags |= OFN_HIDEREADONLY;
          ofn.Flags |= OFN_FILEMUSTEXIST;

          if(GetOpenFileName(&ofn)) {
            return std::string( ofn.lpstrFile );
          }

        } else if(type == 1) {

          ofn.Flags |= OFN_OVERWRITEPROMPT;

          if(GetSaveFileName(&ofn)) {
            return std::string( ofn.lpstrFile );
          }

        }

        return std::string();

      } //open_select_file
      
      void show_message(const std::string &message, const std::string &caption)
      {
          MessageBox(NULL, message.c_str(), caption.c_str(), NULL);
      }
      
    } //dialogs namespace

} //linc namespace
