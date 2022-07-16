if you don't have association to APK files,  
`file type apk only.reg` will add it to your registry,  
along with default icon, mimetype, always showing extension and safe to open after download.

I do not include an "uninstall" for this.

<hr/>

`context-menu items only.reg` will install two actions in the context-menu,  
when right-clicking APK-file in explorer. it will also change the default action to opening the apk with 7zip.

`context-menu items only - uninstall.reg` will remove the two context menu items and reset the default action,  
it will keep the apk definition as is.

<hr/>

instructions and notes I've wrote before:

you don't have an associated application with APK files,  
this might be helpful.

it does uses some explicit paths you need to fix:  

`D:\\Software\\7zip\\7zFM.exe`  
and  
`D:\\DOS\android\\bin\\icon_android.ico`  
and  
`D:\\DOS\android\\bin\\--_aapt2_dump_packagename_badging_permissions.cmd`  

(double forward slash is important in registry, so when updating it to your path, also use double forward-slash).

<hr/>

it adds default icon (7zip),  
and two actions, one to dump the data,  
and one to open the apk with 7zip.  

note 1:  
`--_aapt2_dump_packagename_badging_permissions.cmd`  
calls for `notepad2.exe` which in my case is in my system's `PATH` environment variable.  
you can use any of your favorite editors.  

note 2:  
`--_aapt2_dump_packagename_badging_permissions.cmd`  
uses explicit path  
`D:\DOS\android\bin\--_aapt2.cmd`  
because it used to be in another (`sendto`) folder.  
but it is probably better to fix that to be relative to current folder.  


<hr/>

resources:  
https://github.com/mcmilk/7-Zip-zstd/releases/latest  
https://github.com/XhmikosR/notepad2-mod/releases/latest  
https://github.com/rizonesoft/Notepad3/releases/latest  
https://github.com/notepad-plus-plus/notepad-plus-plus/releases/latest  