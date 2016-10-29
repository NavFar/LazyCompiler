
%%
LETTER = [a-zA-Z]
WDIGIT = [0-9]
NDIGIT = [1-9]
LETWDIGIT = (LETTER | WDIGIT)
TRUE = "true"
FALSE = "false"
NULL = "\\"(0)
CHARCONST = "\\"(.)
COMMENT = "//"(.)*
SHARP = "#"
WHITESPACE = [ \t\n\r]
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
{RECORD} {System.out.println("' "+yytext()+" ' Seen and tagged as 'Record KW'");}
{OPEN_BRACE} {System.out.println("' "+yytext()+" ' Seen and tagged as 'Open Brace'");}
{CLOSE_BRACE} {System.out.println("' "+yytext()+" ' Seen and tagged as 'Close Brace'");}
{SEMICOLON} {System.out.println("' "+yytext()+" ' Seen and tagged as 'Semicolon'");}
{COLON} {System.out.println("' "+yytext()+" ' Seen and tagged as 'Colon'");}
{COMMA} {System.out.println("' "+yytext()+" ' Seen and tagged as 'Comma'");}
"0" | {NDIGIT}{WDIGIT}*"."{WDIGIT}*{NDIGIT} {System.out.println("' "+yytext()+" ' Seen and tagged as 'Realconst'");}
{DOT} {System.out.println("' "+yytext()+" ' Seen and tagged as 'Dot'");}
{OPEN_BRACKET} {System.out.println("' "+yytext()+" ' Seen and tagged as 'Open Bracket'");}
{CLOSE_BRACKET} {System.out.println("' "+yytext()+" ' Seen and tagged as 'Close Bracket'");}
{STATIC} {System.out.println("' "+yytext()+" ' Seen and tagged as 'Static KW'");}
{INT} {System.out.println("' "+yytext()+" ' Seen and tagged as 'Int KW'");}
{REAL} {System.out.println("' "+yytext()+" ' Seen and tagged as 'Real KW'");}
{BOOL} {System.out.println("' "+yytext()+" ' Seen and tagged as 'Bool KW'");}
{TRUE} {System.out.println("' "+yytext()+" ' Seen and tagged as 'True KW'");}
{FALSE} {System.out.println("' "+yytext()+" ' Seen and tagged as 'False KW'");}
{CHAR} {System.out.println("' "+yytext()+" ' Seen and tagged as 'Char KW'");}
{OPEN_PHARANTECE} {System.out.println("' "+yytext()+" ' Seen and tagged as 'Open Parenthesis'");}
{CLOSE_PHARANTECE} {System.out.println("' "+yytext()+" ' Seen and tagged as 'Close Parenthesis'");}
{IF} {System.out.println("' "+yytext()+" ' Seen and tagged as 'If KW'");}
{ELSE} {System.out.println("' "+yytext()+" ' Seen and tagged as 'Else KW'");}
{SWITCH} {System.out.println("' "+yytext()+" ' Seen and tagged as 'Switch KW'");}
{END} {System.out.println("' "+yytext()+" ' Seen and tagged as 'End KW'");}
{CASE} {System.out.println("' "+yytext()+" ' Seen and tagged as 'Case KW'");}
{WHILE} {System.out.println("' "+yytext()+" ' Seen and tagged as 'While KW'");}
{DEFAULT} {System.out.println("' "+yytext()+" ' Seen and tagged as 'Default KW'");}
{RETURN} {System.out.println("' "+yytext()+" ' Seen and tagged as 'Return KW'");}
{BREAK} {System.out.println("' "+yytext()+" ' Seen and tagged as 'Break KW'");}
{EQUAL} {System.out.println("' "+yytext()+" ' Seen and tagged as 'Equal KW'");}
{PLUSEQUAL} {System.out.println("' "+yytext()+" ' Seen and tagged as 'PlusEqual'");}
{MINUSEQUAL} {System.out.println("' "+yytext()+" ' Seen and tagged as 'MinusEqual'");}
{MULTIPLYEQUAL} {System.out.println("' "+yytext()+" ' Seen and tagged as 'MultiplyEqual'");}
{DIVIDEQUAL} {System.out.println("' "+yytext()+" ' Seen and tagged as 'DividEqual'");}
{PLUSPLUS} {System.out.println("' "+yytext()+" ' Seen and tagged as 'PlusPlus'");}
{MINUSMINUS} {System.out.println("' "+yytext()+" ' Seen and tagged as 'MinusMinus'");}
{OR} {System.out.println("' "+yytext()+" ' Seen and tagged as 'Or KW'");}
{AND} {System.out.println("' "+yytext()+" ' Seen and tagged as 'And KW'");}
{ORELSE} {System.out.println("' "+yytext()+" ' Seen and tagged as 'OrElse KW'");}
{ANDTHEN} {System.out.println("' "+yytext()+" ' Seen and tagged as 'AndThen KW'");}
{NOT} {System.out.println("' "+yytext()+" ' Seen and tagged as 'Not KW'");}
{LE} {System.out.println("' "+yytext()+" ' Seen and tagged as 'LE KW'");}
{LT} {System.out.println("' "+yytext()+" ' Seen and tagged as 'LT KW'");}
{GT} {System.out.println("' "+yytext()+" ' Seen and tagged as 'GT KW'");}
{GE} {System.out.println("' "+yytext()+" ' Seen and tagged as 'GE KW'");}
{EQ} {System.out.println("' "+yytext()+" ' Seen and tagged as 'EQ KW'");}
{NE} {System.out.println("' "+yytext()+" ' Seen and tagged as 'NE KW'");}
{MATHDIV} {System.out.println("' "+yytext()+" ' Seen and tagged as 'MathDiv'");}
{MATHMOD} {System.out.println("' "+yytext()+" ' Seen and tagged as 'MathMod'");}
{MATHMUL} {System.out.println("' "+yytext()+" ' Seen and tagged as 'MathMul'");}
{MATHPLU} {System.out.println("' "+yytext()+" ' Seen and tagged as 'MathPlu'");}
{MATHMIN} {System.out.println("' "+yytext()+" ' Seen and tagged as 'MathMin'");}
"0" | {NDIGIT}{WDIGIT}* {System.out.println("' "+yytext()+" ' Seen and tagged as 'NumConst'");}
{SHARP}{LETTER}{LETTER}{WDIGIT}{WDIGIT} {System.out.println("' "+yytext()+" ' Seen and tagged as 'ID'");}
{NULL} {System.out.println("' "+yytext()+" ' Seen and tagged as 'Null'");}
{CHARCONST} {System.out.println("' "+yytext()+" ' Seen and tagged as 'CharConst (\\based)'");}
"'"(.)"'" {System.out.println("' "+yytext()+" ' Seen and tagged as 'CharConst(quote based)'");}
{COMMENT} {System.out.println("' "+yytext()+" ' Seen and tagged as 'Comment'");}
{WHITESPACE}+ {System.out.println("' "+yytext()+" ' Seen and tagged as 'White Space'");}
//. {System.out.println("' "+yytext()+" ' Seen and tagged as 'Unknown'");}
