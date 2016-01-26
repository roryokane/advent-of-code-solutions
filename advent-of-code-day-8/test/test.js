"use strict";
const assert = require('chai').assert;
const solution = require('../src/');
const countCharsAfterStringLiteralDecode = solution.countCharsAfterStringLiteralDecode;
const countCharsAfterStringLiteralEncode = solution.countCharsAfterStringLiteralEncode;


// note that backslashes are double-escaped in test strings

describe('countCharsAfterStringLiteralDecode', () => {
  it('counts characters in a simple string', () => {
    let string = '"abc"';
    assert.equal(countCharsAfterStringLiteralDecode(string), 3);
  });
  
  it('counts 0 characters in an empty string literal', () => {
    let string = '""';
    assert.equal(countCharsAfterStringLiteralDecode(string), 0);
  });
  
  it('counts escaped backslashes as one character', () => {
    let string = '"a\\\\c"';
    assert.equal(countCharsAfterStringLiteralDecode(string), 3);
  });
  
  it('counts escaped double quotes as one character', () => {
    let string = '"a\\"c"';
    assert.equal(countCharsAfterStringLiteralDecode(string), 3);
  });
  
  it('counts two-digit hexadecimal escapes as one character', () => {
    let string = '"a\\xd4c"';
    assert.equal(countCharsAfterStringLiteralDecode(string), 3);
  });
  
  it('counts correctly with a combination of escapes', () => {
    let string = '"\\\\ \\x78\\x9a \\"yes\\" /"';
    assert.equal(countCharsAfterStringLiteralDecode(string), 12);
  });
});

describe('countCharsAfterStringLiteralEncode', () => {
  it('counts two quotes added around a simple string', () => {
    let string = 'abc';
    assert.equal(countCharsAfterStringLiteralEncode(string), 5);
  });
  
  it('counts quotes as double in a quoted string', () => {
    let string = '"abc"';
    assert.equal(countCharsAfterStringLiteralEncode(string), 9);
  });
  
  it('counts quotes as double in an empty quoted string', () => {
    let string = '""';
    assert.equal(countCharsAfterStringLiteralEncode(string), 6);
  });
  
  it('counts backslashes and inner quotes as double', () => {
    let string = '"aaa\\"aaa"';
    assert.equal(countCharsAfterStringLiteralEncode(string), 16);
  });

  it("doesn’t handle hex escape strings any differently", () => {
    let string = '"\\x27"';
    assert.equal(countCharsAfterStringLiteralEncode(string), 11);
  });
});
