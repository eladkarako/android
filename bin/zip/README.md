http://gnuwin32.sourceforge.net/packages/zip.htm

<hr/>
I've previously used 7zip in various compressions rates,  
and even packed using the jar packing from java.

both were fine on older Android devices and custom firmwares (LineAge OS),  
but official new samsung firmware kept saying the package was corrupted...

eventually I've figured that the apk being compress needs two things:
1. do not add folder as entries to the zip. it is fine, the folder structure will be created anyway due to the path of the files (no empty folder though, but that's fine too).
2. no compression! use zero `0` for "store".

note:  
there were few other causes:
1. jarsigner and even apksigner were not suitable to sign the apk (weird). but `uber-apk-signer` which uses the java code for apksigner which also handles aligning the code page, which worked, for some reason.
2. the compatible certificate using SHA1 RSA JKS key store and 1024 key size for ~3 years were needed to be replaced with sha256rsa PKCS12 2048 for ~35 years.

<hr/>

the command running from within the folder you want to compress: `zip.exe -0Dr "..\file.zip" .`

<hr/>

older notes:

zip needs to be with minimal compression so `-0` is used.  
zip does not need folder entries. so `-D` is used.

both entries in the modified project (after build, binary files) and original project (binary files) should be pretty much the same, I.E. no folders entries. I've used java's `jar` command for that.. and a natural sort program https://github.com/eladkarako/sort to easily compare both outputs... 

```txt
jar --list --file=myfile.apk        >1.txt
jar --list --file=myfile_repacl.apk >2.txt
```

sort both, they should be the same.
