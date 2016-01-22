describe('countStringLiteralCharacters', function() {
  // note that backslashes are double-escaped in test strings
  
  it('counts characters in a simple string', function() {
    var string = '"abc"';
    expect(countStringLiteralCharacters(string)).toBe(3);
  });
  
  it('counts 0 characters in an empty string literal', function() {
    var string = '""';
    expect(countStringLiteralCharacters(string)).toBe(0);
  });
  
  it('counts escaped backslashes as one character', function() {
    var string = '"a\\\\c"';
    expect(countStringLiteralCharacters(string)).toBe(3);
  });
  
  it('counts escaped double quotes as one character', function() {
    var string = '"a\\"c"';
    expect(countStringLiteralCharacters(string)).toBe(3);
  });
  
  it('counts two-digit hexadecimal escapes as one character', function() {
    var string = '"a\\xd4c"';
    expect(countStringLiteralCharacters(string)).toBe(3);
  });
  
  it('counts correctly with a combination of escapes', function() {
    var string = '"\\\\ \\x78\\x9a \\"yes\\" /"';
    expect(countStringLiteralCharacters(string)).toBe(12);
  });
});
