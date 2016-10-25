
%%
LETTER = [a-zA-Z]
WDIGIT = [0-9]
NDIGIT = [1-9]
LETWDIGIT = (LETTER | WDIGIT)
CHARCONST = \\([A-Za-mo-z1-9\\])
COMMENT = "//"(.)*
SHARP = "#"
WHITESPACE = [ \t\n\r] 
RECORD = "record"
OPEN_BRACE = "{"
CLOSE_BRACE = "}"
SEMICOLON = ";"
COMMA = ","
DOT = "."
OPEN_BRACKET = "["
CLOSE_BRACKET = "]"
STATIC = "static"
INT = "int"
REAL = "real"
BOOL = "bool"
CHAR = "char"
OPEN_PHARANTECE = "("
CLOSE_PHARANTECE = ")"
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
{RECORD} {System.out.println("Record KW seen!  " + yytext());}
{OPEN_BRACE} {System.out.println("{ seen!  " + yytext());}
{CLOSE_BRACE} {System.out.println("} seen!  " + yytext());}
{SEMICOLON} {System.out.println("; seen!  " + yytext());}
{COMMA} {System.out.println(", seen!  " + yytext());}
{DOT} {System.out.println(". seen!  " + yytext());}
{OPEN_BRACKET} {System.out.println("[ seen!  " + yytext());}
{CLOSE_BRACKET} {System.out.println("] seen!  " + yytext());}
{STATIC} {System.out.println("static KW seen!  " + yytext());}
{INT} {System.out.println("int KW seen!  " + yytext());}
{REAL} {System.out.println("real KW seen!  " + yytext());}
{BOOL} {System.out.println("bool KW seen!  " + yytext());}
{CHAR} {System.out.println("CHAR KW seen!  " + yytext());}
{OPEN_PHARANTECE} {System.out.println("( seen!  " + yytext());}
{CLOSE_PHARANTECE} {System.out.println(") seen!  " + yytext());}
{IF} {System.out.println("IF KW seen!  " + yytext());}
{ELSE} {System.out.println("ELSE KW seen!  " + yytext());}
{SWITCH} {System.out.println("SWITCH KW seen!  " + yytext());}
{END} {System.out.println("END KW seen!  " + yytext());}
{CASE} {System.out.println("CASE KW seen!  " + yytext());}
{DEFAULT} {System.out.println("DEFAULT KW seen!  " + yytext());}
{WHILE} {System.out.println("WHILE KW seen!  " + yytext());}
{RETURN} {System.out.println("RETURN KW seen!  " + yytext());}
{BREAK} {System.out.println("BREAK KW seen!  " + yytext());}
{EQUAL} {System.out.println("= seen!  " + yytext());}
{PLUSEQUAL} {System.out.println("+= seen!  " + yytext());}
{MINUSEQUAL} {System.out.println("-= seen!  " + yytext());}
{MULTIPLYEQUAL} {System.out.println("*= seen!  " + yytext());}
{DIVIDEQUAL} {System.out.println("/= seen!  " + yytext());}
{PLUSPLUS} {System.out.println("++ seen!  " + yytext());}
{MINUSMINUS} {System.out.println("-- seen!  " + yytext());}
{OR} {System.out.println("OR seen!  " + yytext());}
{AND} {System.out.println("AND seen!  " + yytext());}
{ORELSE} {System.out.println("ORELSE seen!  " + yytext());}
{ANDTHEN} {System.out.println("ANDTHEN seen!  " + yytext());}
{NOT} {System.out.println("NOT seen!  " + yytext());}
{LE} {System.out.println(".le seen!  " + yytext());}
{LT} {System.out.println(".lt seen!  " + yytext());}
{GT} {System.out.println(".gt seen!  " + yytext());}
{GE} {System.out.println(".ge seen!  " + yytext());}
{EQ} {System.out.println(".eq seen!  " + yytext());}
{NE} {System.out.println(".ne seen!  " + yytext());}
{MATHDIV} {System.out.println("// seen!  " + yytext());}
{MATHMOD} {System.out.println("% seen!  " + yytext());}
{MATHMUL} {System.out.println("* seen!  " + yytext());}
{MATHPLU} {System.out.println("+ seen!  " + yytext());}
{MATHMIN} {System.out.println("- seen!  " + yytext());}
"0" | {NDIGIT}{WDIGIT}* {System.out.println("Numconst seen!  " + yytext());}
{SHARP}{LETTER}{LETTER}{WDIGIT}{WDIGIT} {System.out.println("ID seen!  " + yytext());}
{CHARCONST} {System.out.println("Charconst seen!  " + yytext());}
{COMMENT} {System.out.println("Comment seen!  " + yytext());}
{WHITESPACE}+ {System.out.println("Whitespace seen!  " + yytext());}
//. {System.out.println("Unknown!   " + yytext());}
