"use strict";
const split = require('split');


class EscapedStringContentsCharCounter {
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

exports.countCharsAfterStringLiteralDecode = function countCharsAfterStringLiteralDecode(stringLiteral) {
  const contents = stringLiteral.slice(1, -1); // cut out surrounding quotes
  const contentsCounter = new EscapedStringContentsCharCounter(contents);
  return contentsCounter.count();
}


exports.countCharsAfterStringLiteralEncode = function countCharsAfterStringLiteralEncode(string) {
  let charCount = 2; // for the two double-quotes at either end
  string.split('').forEach((char) => {
    if (char === '\\' || char === '"') {
      charCount += 2;
    } else {
      charCount++;
    }
  });
  return charCount;
}
