note:
`generate_keystore.cmd` generate a new keystore each-time it runs (it runs once, before `uber-apk-signer` run).  
this prevents upgrading apks (even if they got same package name).  

the password is random and changes each time,  
the certificate time is about 34-46 years (random).

this is also more secure this way.
