"use strict";
const split = require('split');
const solution = require('../src/');
const countCharsAfterStringLiteralDecode = solution.countCharsAfterStringLiteralDecode;
const countCharsAfterStringLiteralEncode = solution.countCharsAfterStringLiteralEncode;


var totalDecodeCharsSaved = 0;
var totalEncodeCharsGained = 0;

process.stdin.pipe(split()).on('data', (line) => {
  totalDecodeCharsSaved += line.length;
  totalDecodeCharsSaved -= countCharsAfterStringLiteralDecode(line);
  
  totalEncodeCharsGained += countCharsAfterStringLiteralEncode(line);
  totalEncodeCharsGained -= line.length;
}).on('end', () => {
  console.log('chars saved after decode:', totalDecodeCharsSaved);
  console.log('chars gained after encode:', totalEncodeCharsGained);
});
