//edit a single .smali file.
//
//not actually used,  
//since it is more efficient to do this along with the directory crawling instead of spawning a lot of sub-processes.
//still a useful (small scale) example.
//---------------------------------------------------------------

(function(){
"use strict";

const fs                = require("fs")
     ,state             = fs.lstatSync.bind(fs)
     ,is_access         = function(path){  //normalizing try-catch to true false.
                            var result = false;
                            try{
                              fs.accessSync(path, fs.R_OK || fs.constants.R_OK);
                              result = true;
                            }catch(err){
                              result = false;
                            }
                            return result;
                          }
     ,is_file           = function(path){return (true === state(path).isFile());}
     ,read_file         = function(path){
                            return fs.readFileSync.bind(fs)(path,{encoding: "utf8"});
                          }
     ,write_file        = function(path, content){
                            fs.writeFileSync.bind(fs)(path, content, {flag:"w", encoding:"utf8"});
                          }
     ,path              = require("path")
     ,path_resolve      = function(path){
                            path = path.replace(/[\\\/]+/g,"/");
                            path = path.resolve(path);
                            path = path.replace(/[\\\/]+/g,"/");
                            path = path.replace(/\/+$/g,"");
                          }
     ,regexp_file_name  = /\.smali$/i
     ,regexp_content    = /(\-\>isconnec.*)($\s*)move-result ([^\s].*)$/igm
     ,args              = process.argv.filter(function(arg){
                            const is_main_module = /node\.exe/i.test(arg) || /index\.js/i.test(arg) || /smali_edit\.js/i.test(arg) || arg.toLowerCase() === process.mainModule.filename.toLowerCase() ;
                            return (false === is_main_module);
                          })
     ,filename          = args[0]
     ;


if(false === regexp_file_name.test(filename)){
  console.error("[ERROR] provided input path is not ending with \'.smali\'",filename);
  process.exitCode = 111;
  process.exit();
}


if(false === is_access(filename)){
  console.error("[ERROR] no access to path",filename);
  process.exitCode = 222;
  process.exit();
}


if(false === is_file(filename)){
  console.error("[ERROR] this is not a file",filename);
  process.exitCode = 333;
  process.exit();
}


var  file_content_original = read_file(filename)
    ,file_content          = file_content_original + ""
    ,is_changed            = false
    ,matches               = Array.from(file_content.matchAll(regexp_content))
    ;


if(0 === matches.length){
  console.error("[INFO] no match in the textual content of the file.",filename);
  process.exitCode = 0;
  process.exit();
}


matches.forEach(function(match){
  var whole_match             = match[0]
     ,method_until_end        = match[1]
     ,whitespace_after_method = match[2]
     ,variable_only           = match[3]
     ,reconstructed_line
     ;
  if("undefined" === typeof whole_match){             console.error(match, "[ERROR] whole_match is undefined");             return; }
  if("undefined" === typeof method_until_end){        console.error(match, "[ERROR] method_until_end is undefined");        return; }
  if("undefined" === typeof whitespace_after_method){ console.error(match, "[ERROR] whitespace_after_method is undefined"); return; }
  if("undefined" === typeof variable_only){           console.error(match, "[ERROR] variable_only is undefined");           return; }
  
  reconstructed_line = method_until_end 
                     + whitespace_after_method + "####" + "move-result " + variable_only 
                     + whitespace_after_method + "const/4 " + variable_only + ", 0x0"
                     ;

  file_content = file_content.replace(whole_match, reconstructed_line);
  console.error("[INFO] one-time replace of: ", whole_match, " with: ", reconstructed_line);
  
  is_changed = true;
});


if(true === is_changed){
  write_file(filename + ".bak" , file_content_original);
  write_file(filename          , file_content);
  console.error("[INFO] file updated.",filename);
}else{
  console.error("[INFO] file has not changed.",filename);
}


process.exitCode = 0;
process.exit();


}());