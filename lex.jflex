import Parser.YYParser;
import Parser.YYParser.*;
%%

%implements Lexer
%{

public Object getLVal() {
	// TODO Auto-generated method stub
	//System.out.println("curret word: " + yytext());
	return yytext();
}

public void yyerror(String s) {
	// TODO Auto-generated method stub
	System.err.println(s + " at line "+ yyline + " at " + yytext());
}
%}

LETTER = [a-zA-Z]
WDIGIT = [0-9]
NDIGIT = [1-9]
LETWDIGIT = (LETTER | WDIGIT)
QUESTIONSIGN = "?"
TRUE = "true"
FALSE = "false"
NULL = "\\"(0)
CHARCONST1 = "\\"(.)
CHARCONST2 = "'"(.)"'"
COMMENT = "//"(.)*
SHARP = "#"
WHITESPACE = [ \t\n\r]
INLINEWHITESPACE = [ \t]
RECORD = "record"
OPEN_BRACE = "{"
CLOSE_BRACE = "}"
SEMICOLON = ";"
COLON = ":"
COMMA = ","
DOT = "."
OPEN_BRACKET = "["
CLOSE_BRACKET = "]"
STATIC = "static"
INT = "int"
REAL = "real"
BOOL = "bool"
CHAR = "char"
RECTYPE = "RECTYPE"
OPEN_PARANTHESIS = "("
CLOSE_PARANTHESIS = ")"
IF = "if"
ELSE = "else"
SWITCH = "switch"
END = "end"
CASE = "case"
DEFAULT = "default"
WHILE = "while"
RETURN = "return"
BREAK = "break"
EQUAL = "="
PLUSEQUAL = "+="
MINUSEQUAL = "-="
MULTIPLYEQUAL = "*="
DIVIDEQUAL = "/="
PLUSPLUS = "++"
MINUSMINUS = "--"
OR = "or" /* abstraction or not? */
AND = "and"
ORELSE = "or else"
ANDTHEN = "and then"
NOT = "not"
LE = ".le"
LT = ".lt"
GT = ".gt"
GE = ".ge"
EQ = ".eq"
NE = ".ne"
MATHDIV = "/"
MATHMIN = "-"
MATHMUL = "*"
MATHMOD = "%"
MATHPLU = "+"

%%
{RECORD} {return YYParser.RECORD ;}
{OPEN_BRACE} {return YYParser.OPEN_BRACE ;}
{CLOSE_BRACE} {return YYParser.CLOSE_BRACE ;}
{SEMICOLON} {return YYParser.SEMICOLON ;}
{COLON} {return YYParser.COLON ;}
{COMMA} {return YYParser.COMMA ;}
"0" | {NDIGIT}{WDIGIT}*"."{WDIGIT}*{NDIGIT} {return YYParser.REALCONST ;}
{DOT} {return YYParser.DOT ;}
{OPEN_BRACKET} {return YYParser.OPEN_BRACKET ;}
{CLOSE_BRACKET} {return YYParser.CLOSE_BRACKET ;}
{STATIC} {return YYParser.STATIC ;}
{INT} {return YYParser.INT ;}
{REAL} {return YYParser.REAL ;}
{BOOL} {return YYParser.BOOL ;}
{RECTYPE} {return YYParser.RECTYPE ;}
{TRUE} {return YYParser.TRUE ;}
{FALSE} {return YYParser.FALSE ;}
{CHAR} {return YYParser.CHAR ;}
{OPEN_PARANTHESIS} {return YYParser.OPEN_PARANTHESIS ;}
{CLOSE_PARANTHESIS} {return YYParser.CLOSE_PARANTHESIS ;}
{IF} {return YYParser.IF ;}
{ELSE} {return YYParser.ELSE ;}
{SWITCH} {return YYParser.SWITCH ;}
{END} {return YYParser.END ;}
{CASE} {return YYParser.CASE ;}
{WHILE} {return YYParser.WHILE ;}
{DEFAULT} {return YYParser.DEFAULT ;}
{RETURN} {return YYParser.RETURN ;}
{BREAK} {return YYParser.BREAK ;}
{EQUAL} {return YYParser.EQUAL ;}
{PLUSEQUAL} {return YYParser.PLUSEQUAL ;}
{MINUSEQUAL} {return YYParser.MINUSEQUAL ;}
{MULTIPLYEQUAL} {return YYParser.MULTIPLYEQUAL ;}
{DIVIDEQUAL} {return YYParser.DIVIDEQUAL ;}
{PLUSPLUS} {return YYParser.PLUSPLUS ;}
{MINUSMINUS} {return YYParser.MINUSMINUS ;}
{OR} {return YYParser.OR ;}
{AND} {return YYParser.AND ;}
{ORELSE} {return YYParser.ORELSE ;}
{ANDTHEN} {return YYParser.ANDTHEN ;}
{NOT} {return YYParser.NOT ;}
{LE} {return YYParser.LE ;}
{LT} {return YYParser.LT ;}
{GT} {return YYParser.GT ;}
{GE} {return YYParser.GE ;}
{EQ} {return YYParser.EQ ;}
{NE} {return YYParser.NE ;}
{MATHDIV} {return YYParser.MATHDIV ;}
{MATHMOD} {return YYParser.MATHMOD ;}
{MATHMUL} {return YYParser.MATHMUL ;}
{MATHPLU} {return YYParser.MATHPLU ;}
{MATHMIN} {return YYParser.MATHMIN ;}
"0" | {NDIGIT}{WDIGIT}* {return YYParser.NUMCONST ;}
{SHARP}{LETTER}{LETTER}{WDIGIT}{WDIGIT}{INLINEWHITESPACE}*{SHARP}{LETTER}{LETTER}{WDIGIT}{WDIGIT} {yypushback(yylength()-5);retrun YYParser.RECTYPE}
{SHARP}{LETTER}{LETTER}{WDIGIT}{WDIGIT} {YYParser.current_ID = yytext(); return YYParser.ID ; }
{NULL} {return YYParser.NULL ;}
{CHARCONST1} {return YYParser.CHARCONST1 ;}
{CHARCONST2} {return YYParser.CHARCONST2 ;}
{COMMENT} { }
{WHITESPACE}+ { }
{QUESTIONSIGN} {return YYParser.QUESTIONSIGN ;}
//.+ {System.out.println("Unidentified lexem at: " + yytext()) ;}
