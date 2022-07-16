https://github.com/eladkarako/smali_isconnect_to_zero

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

makes something like this:  

```js
invoke-interface {v0}, Landroid/support/v4/foo/Bar$BarImpl;->isConnected()Z

move-result v0
```

into

```
invoke-interface {v0}, Landroid/support/v4/foo/Bar$BarImpl;->isConnected()Z

####move-result v0

const/4 v0, 0x0
 ```
 
<img width="970" alt="example" src="https://user-images.githubusercontent.com/415238/176906019-56b24728-9073-4c8e-9c3b-85e501b25c31.png">

0. drag and drop a folder or a `smali` file for processing.
1. locate line with `->isConnect.*` (regular expression).
2. locate next line with `move-result` (can be few whitespaces and new-lines).
3. locate the actual variable (it is not always `v0`). this can be extracted from the `->isConnect.*` line as well.
4. comment-out the line found (3). smali/baksmali process would remove it.
5. generate a new line afterwards (`const/4 ` then actual variable than `, 0x0`).
6. be able to skip (multi-)lines that were already modified (1-5).
7. (optional) make the process as efficient and fast as possible. possible to construct the file in multi-thread manner.
8. backup, debug, error handling, revert modifications.


<hr/>

note:  
I've commented-out (disabled) the line that creates a `.bak` backup file  
(`  //write_file(path + ".bak", content_original);`)  
if you wish to create a `.bak` file, uncomment it,  
but it might be annyoing for you since you'll have to delete them all before building with APKTool.  

the `####` commented line (inline the file) is perfectly fine though.  

<hr/>

note:  
this started from https://gist.github.com/eladkarako/6910526bf5d4986c7aa27ed97cdedb64#file-make-an-apk-offline-using-apktool-md  
where both the smali patch and (somewhat redundant) replacing all hostnames with `0.0.0.0` was done manually.  

note:  
here is an example (including APK) that also removes the `FLAG_SECURE` (and change the app name) to allow screenshots (for education purposes only).  
https://gist.github.com/eladkarako/5c398573318beb8981bc9f77fe958191#file-remove-flag_secure-from-an-apk-with-apktool-md  
it is especially effective when you try to avoid data-leaking from an app.  

note:  
the smali `->isConne`.. may break widgets (not related to network access), I'm not 100% sure, but widgets use kind of a bridge  
that only updates their content when they are in-view, it does not disrupts my examples, but it might.  

note:  
a lot of other engines might use middleman such as JavaScript based rendering,  
and engine that is based on the "native browser" to show or fetch content,  
so don't be sure you've actually made the app offline entirely.  

note:  
it will reduce amount of ads and statistics due to being "fake offline" (the app at least think it is offline),  
it is not the main reason for this, but still might be useful...  

<hr/>

<br/>
