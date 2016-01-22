"use strict";

const split = require('split');


class StringContentsCharCounter {
  constructor(stringContents) {
    this.stringContents = stringContents;
    this.index = 0;
    this.charCount = 0;
  }
  
  count() {
    while (this.indexIsValid()) {
      this.countAndAdvanceIndex();
    }
    return this.charCount;
  }
  
  indexIsValid() {
    return this.index < this.stringContents.length;
  }
  
  countAndAdvanceIndex() {
    const nextChar = this.stringContents[this.index];
    if (nextChar === '\\') {
      this.index++; // past the backslash
      this.countAndAdvanceForEscapeSequence();
    } else {
      this.index++;
      this.charCount++;
    }
  }
  
  countAndAdvanceForEscapeSequence() {
    const nextChar = this.stringContents[this.index];
    if (nextChar === 'x') {
      this.index++; // past 'x'
      this.countAndAdvanceForEscapedHexDigits();
    } else {
      this.index++; // past the escaped character
      this.charCount++;
    }
  }
  
  countAndAdvanceForEscapedHexDigits() {
    this.index += 2; // past the two hex digits
    this.charCount++;
  }
}

function countStringLiteralCharacters(stringLiteral) {
  const contents = stringLiteral.slice(1, -1); // cut out surrounding quotes
  const contentsCounter = new StringContentsCharCounter(contents);
  return contentsCounter.count();
}


function main() {
  var total = 0;
  process.stdin.pipe(split()).on('data', (line) => {
    total += line.length;
    total -= countStringLiteralCharacters(line);
  }).on('end', () => {
    console.log(total);
  });
}
main();
