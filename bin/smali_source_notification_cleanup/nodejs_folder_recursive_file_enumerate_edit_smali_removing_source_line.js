"use strict";

const read_dir        = require("fs").readdirSync
     ,read_file       = function(path){
                          return require("fs").readFileSync(path,{encoding: "utf8"});
                        }
     ,write_file      = function(path, content){
                          require("fs").writeFileSync(path, content, {flag:"w", encoding:"utf8"});
                        }
     ,resolve         = require("path").resolve
     ,normalize       = function(path){return resolve(path).replace(/[\/\\]+/g,"/").replace(/\/+$/g,"");}
     ,state           = require("fs").lstatSync
     ,is_file         = function(path){return (true === state(path).isFile());}
     ,args            = process.argv.filter(function(s){return false === /node\.exe/i.test(s) && process.mainModule.filename !== s;})
     ,starting_point  = args[0] || ""
     ;

var file_pattern     = /\.smali$/i
   ,content_pattern  = /^\.source\ .*$\r{0,1}\n{0,1}/igm
   ;

function enumerate_match_edit(path){
  var content;
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
  
  //--------------------------------------------- does not have .source at a start of a line
  console.error("[INFO] reading .smali file. [" + path + "]");
  content = read_file(path);
  if(false === content_pattern.test(content)){
    console.error("[INFO] not containing .source line (skip). [" + path + "]");
    return;
  }
  
  //--------------------------------------------- remove line, (over)write file.
  console.error("[INFO] editing file. [" + path + "]");
  content = content.replace(content_pattern, "");
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