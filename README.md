<h3>

```diff
! NO SUPPORT.  
+ designed for research purposes only, I.E. inspecting APK for malicous content.
```

</h3>

```txt

¯\_(ツ)_/¯

```

<h4>how to use, and how to work-around APKTool quirks and Windows quirks.</h4>

1. drag and drop `foo.apk` on `01__decode_[apk].cmd` .  
2. a folder `project_foo` will be created (same folder as your apk is).  
a `log_last_decode.log` file will help you locate any errors if there were any.  

<hr/>

optional changes to `AndroidManifest.xml`:  
`android:allowBackup="false"` to prevent old junk.  

optional various attributes for requesting storage access are also available,  
but it differ considering what SDK you are using:  

```txt
SDK 29  (Android 10) android:requestLegacyExternalStorage="true"
SDK 30  (Android 11) android:preserveLegacyExternalStorage="true"
SDK 31  (Android 12) android:requestRawExternalStorageAccess="true"
```

if the application requires a lot of RAM,  
such as editing graphics, gaming or loading a lot of data,  
you can improve its allocation be adding `android:largeHeap="true"`.  

you can force "NO DEBUG" to reduce the junk the app writes to the system log with `android:debuggable="false"`  
you can also set it `true` for debugging the app.  

you can force GPU usage for most of the app presentable components by adding `android:hardwareAccelerated="true"`.

if you see something like `android:usesCleartextTraffic="true"` you can remove it or set it to false,  
to forbid the application from making connections to unsecure servers.  
the original attribute might be added by other apk-modder as a workaround to sticky-pinned-certificate,  
but it also might be a back-door for added malware. if you see it, you better make the application offline (using this and the instructions below),  
especially if it does not have any functionality that requires online access such as text-editor.  

make sure there are no duplicated values,  
the build will fail if there were.  

<hr/>

3. unzip `foo.apk` using whatever program you want, to a `foo` folder.  
use BeyondCompare to compare both `project_foo/res` and  `foo/res` folder.  
make `project_foo/res` sub-tree match to `foo/res`.  
ignore language related folders that exists only in `project_foo/res`.  
ignore actual file's-content, since `project_foo` includes plain text,  
and `foo` includes binary form text-files (xml and such).  
feel free to create new folders in `project_foo/res` and rename existing ones.  
move files around the `project_foo/res` so they will match the location at `foo/res`.  
4. once the sub-tree is ~about matching, you don't need `foo/` folder anymore, you can delete it.  
5. you need locate32. once you've got it index your drives.  
6. using locate32, look for xml-files under `project_foo/res` having `$` in their name. rename them, removing the `$`.  
for example `project_foo/res/drawable/$avd_hide_password__0` .  

7. you will need notepad++.  
8. using locate32, look for text INSIDE xml files under `project_foo/res`, with the text `$`.  
you will find a lot of files,  
select about 40 files, and drag and drop over an opened notepad++.  
they will be opened in tabs.  
look for `$`, and click "search in all files".  
you are looking for usage of the old file names (the onces with `$` in their name),  
once you've found such usage, edit that file, updating the usage of the file-name, to not having `$`.  
for example `project_foo/res/values/public.xml` has `type="drawable" name="$avd_hide_password__0" id="` .  
and so does `project_foo/res/drawable/avd_hide_password.xml` having `le="@drawable/$avd_hide_password__0"` .  

save the file.  
continue through the results.  
close all files, select the next ~40 files and repeat the process of using notepad++.  
9. open `apktool.yml`, look for `stamp-cert-sha256`, remove that line.  
10. open `unknown` folder, look for `stamp-cert-sha256`, delete that file.  

11. optional - remove all languages - drag and drop the `project_foo` over `03__delete_languages_[project_folder].cmd`  
visit `project_foo/res/` and look for `value-` folders with language code in them. you should not find any. the default `English` language is still kept under `values` folder. if you do please update `03__delete_languages_[project_folder].cmd` .  
this way if you have RTL language such as Arabic or Hebrew, the application will be still shown in English, and the UI will not be messed-up.  

optional changes to `AndroidManifest.xml`:  
`android:supportsRtl="false"`, to make sure the UI will be display left-to-right.  

12. optional - remove `.source` notes from smali files - drag and drop `project_foo` folder over `04__smali_source_notification_cleanup_[any_folder].cmd` .  
process will be done automatically. you can reduce the time by only dragging the smali folder over that `.cmd` file,  
so the recursive search will be done faster.  
if you've got several smali folders you can drag each of them over the `.cmd`, this will do the same stuff but in parallel.  
the log file `log_last_smali_source_notification_cleanup.log` will have more information.  

13. optional - make the apk offline by modifying the result of various variations of `->isConnect` method to zero.  
drag and drop the project or smali folder over `05__smali_isconnect_to_zero_offliner_[any_folder].cmd` .  
the log file `log_last_smali_offliner__make_apk_offline__isconnect_to_zero.log` will have more information.  

14. optional - change the application "name".  
say `for.apk` has a "package name" of `com.foo`,  
if it is also published in Google Play, or Samsung Store (etc..)  
it might get uninstalled.  
it is prefered if you'll change the package name, and even the smali folder tree.  
go to `smali/com/foo` and change `foo` folder name to something else, it is best to add a little prefix,  
in my case, I've made the apk offline, so I've renamed the `foo` folder to `offlinefoo`.  
you are not done yet,  
you need to change references in a lot of text files to the new package name and folder name!  
using `locate32`, search all the files and folders under `project_foo/`, for any file with the text `com.foo` ,  
drag all the files you'll find over an opened notepad++ so they will be opened in tabs.  
press `CTRL`+`H` for search and replace. replace `com.foo` with `com.offlinefoo` - click "replace in all files",  
save all files.  
this is the reason you are adding a prefix to "foo",  
next searches will not find `com.foo` anymore!  
close notepad++.  
using `locate32` again, search again for all files under the `project_foo`, but this time for the text `com/foo` ,  
open all those files with notepad++ in tabs,  
search and replace in all files - replace `com/foo` with `com/offlinefoo` , and save all files .  
close notepad++ and `locate32`.  
you should be done this whole thing in ~2 minutes.  
if your package name is something like `com.bar.foo` you can choose to rename it to either `com.bar.offlinefoo`  
or `com.offlinebar.foo` ,  
it does not matter.  

14. build - drag and drop the project folder over `06__build_[project_folder].cmd` ,  
under `project_foo/dist` you'll find an apk file if all went fine. a `log_last_build.log` file will help you navigate through the errors if there were any.

15. you CAN NOT use this APK!  
you have to first unzip `project_foo/dist/foo.apk` (use any program), you'll have `project_foo/dist/foo/` folder.  
open `project_foo/original/META-INF/` and copy all the files from there to under `project_foo/dist/foo/META-INF/` ,  
delete `RSA`, `SF` and `MF` files under `project_foo/dist/foo/META-INF/`, those would be recreated (in the signing process).  

16. you need to SPECIAL ZIP now!  
drag and drop just the newly unzipped `foo` folder (`project_foo/dist/foo/`) over `07__zip_[any_folder].cmd` ,  
it is a SPECIAL ZIP! it has NO compression, and only store file names.  
it is the most compatible way. please use it,  
don't use 7zip! don't use jar, don't use WinZip, don't use newer versions of GNU zip.  
I went through A LOT until I've figured that this is the cause of MANY installation errors!!!  
the process will create an archive with a similar name to `foo_repack_20220717T1318.apk` but with your current timestamp,  
`yyyymmddThhmm.apk` .  
the log file `log_last_zip.log` will have more information.  

17. sign your apk - drag and drop your `foo_repack_20220717T1318.apk` over `08__align_and_sign_with_uber_apk_signer_using_random_keystore_[apk_only].cmd` .   
you MUST to use `uber-apk-signer`!!!  
not `jarsigner`, and not `apksigner` worked for me on newer smartphones.  
this is another long testing a went through until I've figured it out.  
still not 100% sure what the cause is.  
the CMD will create a new random password that will be used just for this signing-action,  
and a new certificate-store with random details, just for this signing-action.  
the next time you'll drag ANY apk, a new password and certificate-store with random details will be generated and used.  
this makes upgrading impossible!, a user will HAVE to first UNINSTALL the old apk, before installing the newer version.  
for a company launching a product it is not idle, but for you it is strongly advised!  
it will (ALSO) help you make sure junk from older versions will not mess-up with newer versions.  
a log `log_last_align_and_sign_with_uber_apk_signer.log`, and `log_last_keytool_generator.log` will have some more information.  
the file `foo_repack_20220717T1318-aligned-signed.apk` will be present.

18. you can try installing `foo_repack_20220717T1318-aligned-signed.apk` on your smartphone.  




100. consider supporting the development.  


<hr/>
<br/>
<br/>
<br/>
<br/>
  
  
  
  
  