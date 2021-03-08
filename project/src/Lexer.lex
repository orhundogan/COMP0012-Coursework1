import java_cup.runtime.*;

%%
%class Lexer
%unicode
%cup
%line
%column
%states IN_COMMENT
%{
  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }
%}

Letter = [a-zA-Z]
Digit = [0-9]
Punctuation = [!\"#\$%&\'()\*\+\,\-\.\/:;<=>\?@\[\]\\\^_`{}\~]

Character = '{Letter}' | '{Punctuation}' | '{Digit}'
Integer = (0|[1-9]{Digit}*)
Float = {Integer}(\.{Digit}*)?
Rational = [-]?[0-9]+[.]?[0-9]*([\/][0-9]+[,.]?[0-9]*)*
Number = {Integer} | {Rational} | {Float}
Boolean = T | F 
String = \"(\\.|[^\"])*\"

IdChar = {Letter} | {Digit} | "_"
Identifier = {Letter}{IdChar}*

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
Comment = {MultilineComment} | {SignleLineComment}
MultilineComment = "/#" [^#] ~"#/" | "/#" "#" + "/"
SignleLineComment = "#" {InputCharacter}* {LineTerminator}?

//WhiteSpace     = {LineTerminator} | [   \t\f]
WhiteSpace = " "|\t|\r\n|\r|\n

%%

<YYINITIAL> {

  // End 
  ";"                { return symbol(sym.SEMICOLON); }

  // Operators
  ":="               { return symbol(sym.ASSIGN); }
  "::"               { return symbol(sym.CONCAT); }
  ":"                { return symbol(sym.COLON); }
  "="                { return symbol(sym.EQUAL); }
  "!="               { return symbol(sym.NOTEQUAL); }
  "&&"               { return symbol(sym.AND); }
  "||"               { return symbol(sym.OR); }
  "!"                { return symbol(sym.NOT); }
  "+"                { return symbol(sym.PLUS); }
  "-"                { return symbol(sym.MINUS); }
  "*"                { return symbol(sym.TIMES); }
  "/"                { return symbol(sym.DIVIDE); }
  "("                { return symbol(sym.LPAREN); }
  ")"                { return symbol(sym.RPAREN); }
  "{"                { return symbol(sym.LBRACE); }
  "}"                { return symbol(sym.RBRACE); }
  "["                { return symbol(sym.LBRACK); }
  "]"                { return symbol(sym.RBRACK); }
  "=>"               { return symbol(sym.IMPLY); }
  "<="               { return symbol(sym.LESSEQUAL); }
  //">="               { return symbol(sym.GREATEREQUAL); }
  "<"                { return symbol(sym.LESS); }
  ">"                { return symbol(sym.GREATER); }
  ","                { return symbol(sym.COMMA); }
  "?"                { return symbol(sym.QUESTION); }
  "^"                { return symbol(sym.CARET); }
  "."                { return symbol(sym.DOT); }

//Types
"int"              { return symbol(sym.INTEGER); }
"char"             { return symbol(sym.CHARACTER); }
"rat"              { return symbol(sym.RATIONAL); }
"float"            { return symbol(sym.FLOAT); }
"dict"             { return symbol(sym.DICT); }
"seq"              { return symbol(sym.SEQ); }
"thread"            { return symbol(sym.THREAD); }

//Special words
"main"             { return symbol(sym.MAIN); }
"tdef"             { return symbol(sym.TDEF); }
"fdef"             { return symbol(sym.FDEF); }
"top"              { return symbol(sym.TOP); }
"in"               { return symbol(sym.IN); }
"alias"            { return symbol(sym.ALIAS); }
"if"               { return symbol(sym.IF); }
"fi"               { return symbol(sym.FI); }
"then"             { return symbol(sym.THEN); }
"else"             { return symbol(sym.ELSE); }
"read"             { return symbol(sym.READ); }
"print"            { return symbol(sym.PRINT); }
"return"           { return symbol(sym.RETURN); }
"break"            { return symbol(sym.BREAK); }
//"loop"             { return symbol(sym.LOOP); }
"while"             { return symbol(sym.LOOP); }
"pool"             { return symbol(sym.POOL); }
"upto"              { return symbol(sym.UPTO); }
"for"               { return symbol(sym.FOR); }
"of range"          { return symbol(sym.OFRANGE); }

//Literals
{Boolean}          { return symbol(sym.BOOLEAN); }
{String}           { return symbol(sym.STRING); }
{Number}           { return symbol(sym.NUMBER); }
{Character}        { return symbol(sym.CHARACTER); }
{Identifier}       { return symbol(sym.IDENTIFIER);}
{Comment}          { /* just skip what was found, do nothing */ }
{WhiteSpace}       { /* just skip what was found, do nothing */ }

}


/* Your code goes here */
/* Your code goes here */
/* Your code goes here */

/* error fallback */
[^]  {
    System.out.println("Error in line "
        + (yyline+1) +": Invalid input '" + yytext()+"'");
    return symbol(sym.ILLEGAL_CHARACTER);
}
