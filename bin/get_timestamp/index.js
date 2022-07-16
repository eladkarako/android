"use strict";

/* --------------------------------------------------------------
 * ISO timestamp without seconds and milliseconds and timezone.
 * '2022-04-03T23:34:45.128Z' »»» '20220403T2334'
 * output to STDOUT.
 * --------------------------------------------------------------
 */

var arg = process.argv.filter(function(s){return false === /node\.exe/i.test(s) && process.mainModule.filename !== s;}).shift() || ""
   ,date = (arg.length > 5) ? (new Date(arg)) : (new Date())
   ;

date = date.toISOString()
           .replace(/[\:\-]/gm,"")
           .replace(/..\..*$/gm,"")
       ;

console.log(date);

process.exitCode = 0;
process.exit();
