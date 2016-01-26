"use strict";
const split = require('split');
const countStringLiteralCharacters = require('./index');


var total = 0;
process.stdin.pipe(split()).on('data', (line) => {
  total += line.length;
  total -= countStringLiteralCharacters(line);
}).on('end', () => {
  console.log(total);
});
