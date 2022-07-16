"use strict";

const fs              = require("fs")
     ,read_dir        = fs.readdirSync.bind(fs)
     ,normalize       = function(path){return require("path").resolve(path).replace(/[\/\\]+/g,"/").replace(/\/+$/g,"");}
     ,is_file         = function(path){return (true === fs.lstatSync(path).isFile());}
     ,is_access       = function(path){  //normalizing try-catch to true false.
                          var result = false;
                          try{
                            fs.accessSync(path, fs.R_OK || fs.constants.R_OK);
                            result = true;
                          }catch(err){
                            result = false;
                          }
                          return result;
                        }
     ,path            = require("path")
     ,path_resolve    = function(path){
                          path = path.replace(/[\\\/]+/g,"/");
                          path = path.resolve(path);
                          path = path.replace(/[\\\/]+/g,"/");
                          path = path.replace(/\/+$/g,"");
                        }
     ,read_file       = function(path){
                          return fs.readFileSync(path,{encoding: "utf8"});
                        }
     ,write_file      = function(path, content){
                          fs.writeFileSync(path, content, {flag:"w", encoding:"utf8"});
                        }
     ,args            = process.argv.filter(function(s){return false === /node\.exe/i.test(s) && process.mainModule.filename !== s;})
     ,starting_point  = args[0] || ""
     ;

var file_pattern      = /\.smali$/i
   ,content_pattern   = /(\-\>isconnec.*)($\s*)move-result ([^\s].*)$/igm
   ;

function enumerate_match_edit(path){
  var content_original
     ,content
     ;

  path = normalize(path);

  //--------------------------------------------- is a folder.
  if(false === is_file(path)){
    console.error("[INFO] entering folder: " + path);
    read_dir(path, {encoding:"utf8"})
      .forEach(function(sub_path){
         sub_path = (path + "\/" + sub_path);
         enumerate_match_edit(sub_path);
      });
    return;
  }
  
  //--------------------------------------------- is a file.
  console.error("[INFO] a file. [" + path + "]");
  
  //--------------------------------------------- not a .smali file
  if(false === file_pattern.test(path)){
    console.error("[INFO] not a .smali file (skip). [" + path + "]");
    return;
  }

  if(false === is_access(path)){
    console.error("[INFO] no access [" + path + "]");
    return;
  }
  
  //--------------------------------------------- does not have pattern at a start of a line
  console.error("[INFO] reading .smali file. [" + path + "]");
  content_original = read_file(path);
  content          = content_original + "";
  
  
  var matches = Array.from(content.matchAll(content_pattern));
  if(0 === matches.length){
    console.error("[INFO] not including pattern, skipping", path);
    return;
  }


  //--------------------------------------------- remove line, (over)write file.
  console.error("[INFO] editing file. [" + path + "]");
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
    content = content.replace(whole_match, reconstructed_line);
    console.error("[INFO] one-time replace of: ", whole_match, " with: ", reconstructed_line);
  });

  //write_file(path + ".bak", content_original);
  write_file(path, content);
}


if(starting_point.length < 4){ 
  console.error("[ERROR] invalid starting-point: [" + starting_point + "]");
  process.exitCode = 111;
  process.exit();
}


console.error("[INFO] starting point: [" + starting_point + "]");
enumerate_match_edit(starting_point);


process.exitCode = 0;
process.exit();