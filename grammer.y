%token RECORD
%token OPEN_BRACE
%token CLOSE_BRACE
%token SEMICOLON
%token COLON
%token COMMA
%token REALCONST
%token DOT
%token OPEN_BRACKET
%token CLOSE_BRACKET
%token STATIC
%token INT
%token REAL
%token BOOL
%token TRUE
%token FALSE
%token CHAR
%token OPEN_PARANTHESIS
%token CLOSE_PARANTHESIS
%token IF
%token ELSE
%token SWITCH
%token END
%token CASE
%token WHILE
%token DEFAULT
%token RETURN
%token BREAK
%token EQUAL
%token PLUSEQUAL
%token MINUSEQUAL
%token MULTIPLYEQUAL
%token DIVIDEQUAL
%token PLUSPLUS
%token MINUSMINUS
%token OR
%token AND
%token ORELSE
%token ANDTHEN
%token NOT
%token LE
%token LT
%token GT
%token GE
%token EQ
%token NE
%token MATHDIV
%token MATHMOD
%token MATHMUL
%token MATHPLU
%token MATHMIN
%token NUMCONST
%token ID
%token NULL
%token CHARCONST1 /* backSlash based */
%token CHARCONST2 /* quote based */
%token QUESTIONSIGN
%token COMMENT
%token WHITESPACE

%%
program : declarationList {System.out.println("Rule 1 program : declarationList");};
 declarationList : declarationList declaration {System.out.println("Rule 2 declarationList : declarationList declaration");};
 | declaration {System.out.println("Rule 3 declarationList : declaration");};
 declaration : varDeclaration {System.out.println("Rule 4 declaration : varDeclaration");};
 | funDeclaration {System.out.println("Rule 5 declaration : funDeclaration");};
 | recDeclaration {System.out.println("Rule 6 declaration : recDeclaration");};
 recDeclaration : record ID OPEN_BRACE localDeclarations CLOSE_BRACE {System.out.println("Rule 7 recDeclaration : record ID { localDeclarations }");};
 varDeclaration : typeSpecifier varDeclList SEMICOLON {System.out.println("Rule 8 varDeclaration : typeSpecifier varDeclList ;");};
 scopedVarDeclaration : scopedTypeSpecifier varDeclList SEMICOLON {System.out.println("Rule 9 scopedVarDeclaration : scopedTypeSpecifier varDeclList ;");};
 varDeclList : varDeclList COMMA varDeclInitialize {System.out.println("Rule 10 varDeclList : varDeclList , varDeclInitialize");};
 | varDeclInitialize {System.out.println("Rule 11 varDeclList : varDeclInitialize");};
 varDeclInitialize : varDeclId {System.out.println("Rule 12 varDeclInitialize : varDeclId");};
 | varDeclId COLON simpleExpression {System.out.println("Rule 13 varDeclInitialize : varDeclId : simpleExpression");};
 varDeclId : ID {System.out.println("Rule 14 varDeclId : ID");};
 | ID OPEN_BRACKET NUMCONST CLOSE_BRACKET {System.out.println("Rule 15 varDeclId : ID [ NUMCONST ]");};
 scopedTypeSpecifier : STATIC typeSpecifier {System.out.println("Rule 16 scopedTypeSpecifier : STATIC typeSpecifier");};
 | typeSpecifier {System.out.println("Rule 17 scopedTypeSpecifier : typeSpecifier");};
 typeSpecifier : returnTypeSpecifier {System.out.println("Rule 18 typeSpecifier : returnTypeSpecifier");};
 | RECTYPE {System.out.println("Rule 19 typeSpecifier : RECTYPE");};
 returnTypeSpecifier : int {System.out.println("Rule 20 returnTypeSpecifier : int");};
 | real {System.out.println("Rule 21 returnTypeSpecifier : real");};
 | bool {System.out.println("Rule 22 returnTypeSpecifier : bool");};
 | char {System.out.println("Rule 23 returnTypeSpecifier : char");};
 funDeclaration : typeSpecifier ID OPEN_PARANTHESIS params CLOSE_PARANTHESIS statement {System.out.println("Rule 24 funDeclaration : typeSpecifier ID ( params ) statement");};
 | ID OPEN_PARANTHESIS params CLOSE_PARANTHESIS statement {System.out.println("Rule 25 funDeclaration : ID ( params ) statement");};
 params : paramList {System.out.println("Rule 26 params : paramList");};
 | {System.out.println("Rule 27 params : lamda");};
 paramList : paramList SEMICOLON paramTypeList {System.out.println("Rule 28 paramList : paramList ; paramTypeList");};
 | paramTypeList {System.out.println("Rule 29 paramList : paramTypeList");};
 paramTypeList : typeSpecifier paramIdList {System.out.println("Rule 30 paramTypeList : typeSpecifier paramIdList");};
 paramIdList : paramIdList COMMA paramId {System.out.println("Rule 31 paramIdList : paramIdList , paramId");};
 | paramId {System.out.println("Rule 32 paramIdList : paramId");};
 paramId : ID {System.out.println("Rule 33 paramId : ID");};
 | ID OPEN_BRACKET CLOSE_BRACKET {System.out.println("Rule 34 paramId : ID[]");};
 statement : expressionStmt {System.out.println("Rule 35 statement : expressionStmt");};
 | compoundStmt {System.out.println("Rule 36 statement : compoundStmt");};
 | selectionStmt {System.out.println("Rule 37 statement : selectionStmt");};
 | iterationStmt {System.out.println("Rule 38 statement : iterationStmt");};
 | returnStmt {System.out.println("Rule 39 statement : returnStmt");};
 | breakStmt {System.out.println("Rule 40 statement : breakStmt");};
 compoundStmt : OPEN_BRACE localDeclarations statementList CLOSE_BRACE {System.out.println("Rule 41 compoundStmt : { localDeclarations statementList }");};
 localDeclarations : localDeclarations scopedVarDeclaration {System.out.println("Rule 42 localDeclarations : localDeclarations scopedVarDeclaration");};
 | {System.out.println("Rule 43 localDeclarations : lamda");};
 statementList : statementList statement {System.out.println("Rule 44 statementList : statementList statement");};
 | {System.out.println("Rule 45 statementList : lamda");};
 expressionStmt : expression SEMICOLON {System.out.println("Rule 46 expressionStmt : expression ;");};
 | SEMICOLON {System.out.println("Rule 47 expressionStmt : ;");};
 selectionStmt : IF OPEN_PARANTHESIS simpleExpression CLOSE_PARANTHESIS statement {System.out.println("Rule 48 selectionStmt : IF ( simpleExpression ) statement");};
 | IF OPEN_PARANTHESIS simpleExpression CLOSE_PARANTHESIS statement ELSE statement {System.out.println("Rule 49 selectionStmt : IF ( simpleExpression ) statement ELSE statement");};
 | SWITCH OPEN_PARANTHESIS simpleExpression CLOSE_PARANTHESIS caseElement defaultElement END {System.out.println("Rule 50 selectionStmt : SWITCH ( simpleExpression ) caseElement defaultElement END");};
 caseElement : CASE NUMCONST COLON statement SEMICOLON {System.out.println("Rule 51 caseElement : CASE NUMCONST : statement ;");};
 | caseElement CASE NUMCONST COLON statement SEMICOLON {System.out.println("Rule 52 caseElement : caseElement CASE NUMCONST : statement ;");};
 defaultElement : DEFAULT COLON statement SEMICOLON {System.out.println("Rule 53 defaultElement : DEFAULT : statement ;");};
 | {System.out.println("Rule 54 defaultElement : lamda");};
 iterationStmt : while OPEN_PARANTHESIS simpleExpression CLOSE_PARANTHESIS statement {System.out.println("Rule 55 iterationStmt : while ( simpleExpression ) statement");};
 returnStmt : return SEMICOLON {System.out.println("Rule 56 returnStmt : return ;");};
 | return expression SEMICOLON {System.out.println("Rule 57 returnStmt : return expression ;");};
 breakStmt : BREAK SEMICOLON {System.out.println("Rule 58 breakStmt : break ;");};
 expression : mutable EQUAL expression {System.out.println("Rule 59 expression : mutable = expression");};
 | mutable PLUSEQUAL expression {System.out.println("Rule 60 expression : mutable += expression");};
 | mutable MINUSEQUAL expression {System.out.println("Rule 61 expression : mutable -= expression");};
 | mutable MULTIPLYEQUAL expression {System.out.println("Rule 62 expression : mutable *= expression");};
 | mutable DIVIDEQUAL expression {System.out.println("Rule 63 expression : mutable /= expression");};
 | mutable PLUSEQUAL {System.out.println("Rule 64 expression : mutable ++");};
 | mutable MINUSMINUS {System.out.println("Rule 65 expression : mutable--");};
 | simpleExpression {System.out.println("Rule 66 expression : simpleExpression");};
 simpleExpression : simpleExpression OR simpleExpression {System.out.println("Rule 67 simpleExpression : simpleExpression OR simpleExpression");};
 | simpleExpression and simpleExpression {System.out.println("Rule 68 simpleExpression : simpleExpression and simpleExpression");};
 | simpleExpression or else simpleExpression {System.out.println("Rule 69 simpleExpression : simpleExpression or else simpleExpression");};
 | simpleExpression and then simpleExpression {System.out.println("Rule 70 simpleExpression : simpleExpression and then simpleExpression");};
 | not simpleExpression {System.out.println("Rule 71 simpleExpression : not simpleExpression");};
 | relExpression {System.out.println("Rule 72 simpleExpression : relExpression");};
 relExpression : mathlogicExpression relop mathlogicExpression {System.out.println("Rule 73 relExpression : mathlogicExpression relop mathlogicExpression");};
 | mathlogicExpression {System.out.println("Rule 74 relExpression : mathlogicExpression");};
 relop : LE {System.out.println("Rule 75 relop : LE");};
 | LT {System.out.println("Rule 76 relop : LT");};
 | GT {System.out.println("Rule 77 relop : GT");};
 | GE {System.out.println("Rule 78 relop : GE");};
 | EQ {System.out.println("Rule 79 relop : EQ");};
 | NE {System.out.println("Rule 80 relop : NE");};
 mathlogicExpression : mathlogicExpression mathop mathlogicExpression {System.out.println("Rule 81 mathlogicExpression : mathlogicExpression mathop mathlogicExpression");};
 | unaryExpression {System.out.println("Rule 82 mathlogicExpression : unaryExpression");};
 mathop : MATHPLU {System.out.println("Rule 83 mathop : MATHPLU");};
 | MATHMIN {System.out.println("Rule 84 mathop : MATHMIN");};
 | MATHMUL {System.out.println("Rule 85 mathop : MATHMUL");};
 | MATHDIV {System.out.println("Rule 86 mathop : MATHDIV");};
 | MATHMOD {System.out.println("Rule 87 mathop : MATHMOD");};
 unaryExpression : unaryop unaryExpression {System.out.println("Rule 88 unaryExpression : unaryop unaryExpression");};
 | factor {System.out.println("Rule 89 unaryExpression : factor");};
 unaryop : MATHMIN {System.out.println("Rule 90 unaryop : MATHMIN");};
 | MATHMUL {System.out.println("Rule 91 unaryop : MATHMUL");};
 | QUESTIONSIGN {System.out.println("Rule 92 unaryop : QUESTIONSIGN");};
 factor : immutable {System.out.println("Rule 93 factor : immutable");};
 | mutable {System.out.println("Rule 94 factor : mutable");};
 mutable : ID {System.out.println("Rule 95 mutable : ID");};
 | mutable OPEN_BRACKET expression CLOSE_BRACKET {System.out.println("Rule 96 mutable : mutable [ expression ]");};
 | mutable DOT ID {System.out.println("Rule 97 mutable : mutable DOT ID");};
 immutable : OPEN_PARANTHESIS expression CLOSE_PARANTHESIS {System.out.println("Rule 98 immutable : ( expression )");};
 | call {System.out.println("Rule 99 immutable : call");};
 | constant {System.out.println("Rule 100 immutable : constant");};
 call : ID OPEN_PARANTHESIS args CLOSE_PARANTHESIS {System.out.println("Rule 101 call : ID ( args )");};
 args : argList {System.out.println("Rule 102 args : argList");};
 | {System.out.println("Rule 103 args : lamda");};
 argList : argList COMMA expression {System.out.println("Rule 104 argList : argList , expression");};
 | expression {System.out.println("Rule 105 argList : expression");};
 constant : NUMCONST {System.out.println("Rule 106 constant : NUMCONST");};
 | REALCONST {System.out.println("Rule 107 constant : REALCONST");};
 | CHARCONST1 {System.out.println("Rule 108 constant : CHARCONST1");};
 | CHARCONST2 {System.out.println("Rule 109 constant : CHARCONST2");};
 | TRUE {System.out.println("Rule 110 constant : TRUE");};
 | FALSE {System.out.println("Rule 111 constant : FALSE");};


%%
