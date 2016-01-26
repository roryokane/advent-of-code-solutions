"use strict";
const assert = require('assert');
const countStringLiteralCharacters = require('../src/');


describe('countStringLiteralCharacters', () => {
  // note that backslashes are double-escaped in test strings
  
  it('counts characters in a simple string', () => {
    var string = '"abc"';
    assert.equal(countStringLiteralCharacters(string), 3);
  });
  
  it('counts 0 characters in an empty string literal', () => {
    var string = '""';
    assert.equal(countStringLiteralCharacters(string), 0);
  });
  
  it('counts escaped backslashes as one character', () => {
    var string = '"a\\\\c"';
    assert.equal(countStringLiteralCharacters(string), 3);
  });
  
  it('counts escaped double quotes as one character', () => {
    var string = '"a\\"c"';
    assert.equal(countStringLiteralCharacters(string), 3);
  });
  
  it('counts two-digit hexadecimal escapes as one character', () => {
    var string = '"a\\xd4c"';
    assert.equal(countStringLiteralCharacters(string), 3);
  });
  
  it('counts correctly with a combination of escapes', () => {
    var string = '"\\\\ \\x78\\x9a \\"yes\\" /"';
    assert.equal(countStringLiteralCharacters(string), 12);
  });
});
