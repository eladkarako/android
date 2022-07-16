"use strict";

console.log(
  require("crypto").randomBytes(256).readUInt32BE();
);

process.exitCode = 0;
process.exit();