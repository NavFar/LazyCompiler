%token RECORD
%token OPEN_BRACE
%token CLOSE_BRACE
%token SEMICOLON
%token COLON
%token COMMA
%token DOT
%token OPEN_BRACKET
%token CLOSE_BRACKET
%token STATIC
%token INT
%token REAL
%token BOOL
%token RECTYPE
%token <Eval> TRUE
%token <Eval> FALSE
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
%token <Eval> NUMCONST
%token <Eval> REALCONST
%token <Eval> CHARCONST1 /* backSlash based */
%token <Eval> CHARCONST2 /* quote based */
%token <Eval> ID
%token NULL
%token QUESTIONSIGN
%token COMMENT
%token WHITESPACE
%type <Eval> M
%type <Eval> mutable
%type <Eval> returnTypeSpecifier
%type <Eval> constant
%type <Eval> varDeclId
%type <Eval> varDeclaration
%type <Eval> varDeclList
%type <Eval> typeSpecifier
%type <Eval> varDeclInitialize
%type <Eval> simpleExpression
%type <Eval> relExpression
%type <Eval> mathlogicExpression
%type <Eval> relop
%type <Eval> unaryExpression
%type <Eval> factor
%type <Eval> immutable
%type <Eval> expression
%type <Eval> N
%type <Eval> statementList
%type <Eval> caseElement
%type <Eval> defaultElement
%type <Eval> compoundStmt
%type <Eval> statement
%type <Eval> iterationStmt
%type <Eval> breakStmt
%type <Eval> selectionStmt
%type <Eval> scopedTypeSpecifier
%type <Eval> funDeclaration
%type <Eval> expressionStmt

%left OR ORELSE
%left AND ANDTHEN
%left EQ NE
%left LT GT LE GE
%left MATHPLU MATHMIN
%left MATHMOD
%left MATHMUL MATHDIV
%right NOT
%nonassoc p
%nonassoc ELSE

%define public
%define package Parser
%{
import java.util.Vector;
import java.lang.*;
%}
%code {
	int tmpCounter = 0;
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
/*
 ____                  _           _ _____     _     _      
/ ___| _   _ _ __ ___ | |__   ___ | |_   _|_ _| |__ | | ___ 
\___ \| | | | '_ ` _ \| '_ \ / _ \| | | |/ _` | '_ \| |/ _ \
 ___) | |_| | | | | | | |_) | (_) | | | | (_| | |_) | |  __/
|____/ \__, |_| |_| |_|_.__/ \___/|_| |_|\__,_|_.__/|_|\___|
       |___/ 
*/

	Vector<SymbolTableRecord> symbolTable = new Vector<SymbolTableRecord>();
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
/*
  ___                  _                  _      
 / _ \ _   _  __ _  __| |_ __ _   _ _ __ | | ___ 
| | | | | | |/ _` |/ _` | '__| | | | '_ \| |/ _ \
| |_| | |_| | (_| | (_| | |  | |_| | |_) | |  __/
 \__\_\\__,_|\__,_|\__,_|_|   \__,_| .__/|_|\___|
                                   |_|  
*/
	Vector<QuadrupleRecord> quadruple = new Vector<QuadrupleRecord>();
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

Vector<SwitchCase> cases = new Vector<SwitchCase>();

/*
 _                _    ____       _       _     
| |__   __ _  ___| | _|  _ \ __ _| |_ ___| |__  
| '_ \ / _` |/ __| |/ / |_) / _` | __/ __| '_ \ 
| |_) | (_| | (__|   <|  __/ (_| | || (__| | | |
|_.__/ \__,_|\___|_|\_\_|   \__,_|\__\___|_| |_|
                                                
*/
	private void backpatch(Vector<Integer> list, int number){
		if(list == null) return;
		for(int i=0 ; i<list.size() ; i++){
			if(list.get(i) == -1) continue;
			//for prevent double backPatching
			if(quadruple.get(list.get(i)).result != null) continue;
			quadruple.get(list.get(i)).result = "" + number;
		}
	}
	
	private void backpatchForArg2(Vector<Integer> list, int number){
		if(list == null) return;
		for(int i=0 ; i<list.size() ; i++){
			if(list.get(i) == -1) continue;
			//for prevent double backPatching
			if(quadruple.get(list.get(i)).secondArg != null) continue;
			quadruple.get(list.get(i)).secondArg = "" + number;
		}
	}
	
	private void backpatchForArg2(Vector<Integer> list, String number){
		if(list == null) return;
		for(int i=0 ; i<list.size() ; i++){
			if(list.get(i) == -1) continue;
			//for prevent double backPatching
			if(quadruple.get(list.get(i)).secondArg != null) continue;
			quadruple.get(list.get(i)).secondArg = number;
		}
	}
	
	private void backpatch(Vector<Integer> list, String input){
		if(list == null) return;
		for(int i=0 ; i<list.size() ; i++){
			if(list.get(i) == -1) continue;
			//for prevent double backPatching
			if(quadruple.get(list.get(i)).result != null) continue;
			quadruple.get(list.get(i)).firstArg = input;
		}
	}
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
/*
                _ _   
  ___ _ __ ___ (_) |_ 
 / _ \ '_ ` _ \| | __|
|  __/ | | | | | | |_ 
 \___|_| |_| |_|_|\__|
 
*/
	
	private void emit(String instruction, String arg1, String arg2, String result){
		QuadrupleRecord record = new QuadrupleRecord(instruction, arg1, arg2, result);
		quadruple.add(record);
	}
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
/*
                     _____                
 _ __   _____      _|_   _| __ ___  _ __  
| '_ \ / _ \ \ /\ / / | || '_ ` _ \| '_ \ 
| | | |  __/\ V  V /  | || | | | | | |_) |
|_| |_|\___| \_/\_/   |_||_| |_| |_| .__/ 
                                   |_| 
*/
	private String newTmp(String type){
		String tmpName = "tmp" + tmpCounter;
		symbolTable.add(new SymbolTableRecord(type, tmpName, "\0"));
		emit("def", type, tmpName, null);
		tmpCounter++;
		return tmpName;
	}
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
/*
            _       _    ___                  _                  _      
 _ __  _ __(_)_ __ | |_ / _ \ _   _  __ _  __| |_ __ _   _ _ __ | | ___ 
| '_ \| '__| | '_ \| __| | | | | | |/ _` |/ _` | '__| | | | '_ \| |/ _ \
| |_) | |  | | | | | |_| |_| | |_| | (_| | (_| | |  | |_| | |_) | |  __/
| .__/|_|  |_|_| |_|\__|\__\_\\__,_|\__,_|\__,_|_|   \__,_| .__/|_|\___|
|_|                                                       |_| 

*/
	
	private void printQuadruple(){
		for(int i=0 ; i<quadruple.size() ; i++){
			QuadrupleRecord r = quadruple.get(i);
			System.out.println("" + i + "\t" + r.instruction + "\t" + r.firstArg + "\t" + r.secondArg + "\t" + r.result);
		}
	}

	public static String last_type = "";
	public static String current_ID = "";
	public static String current_record = "";

////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
/*
 _                     _   ___       _       ____ _____ 
(_)_ __  ___  ___ _ __| |_|_ _|_ __ | |_ ___/ ___|_   _|
| | '_ \/ __|/ _ \ '__| __|| || '_ \| __/ _ \___ \ | |  
| | | | \__ \  __/ |  | |_ | || | | | || (_) |__) || |  
|_|_| |_|___/\___|_|   \__|___|_| |_|\__\___/____/ |_|

*/
	void insertIntoST(String varID){
		System.out.println("INSERTING:  "+ varID);
		System.out.println("Type:  "+ last_type);
		for(int i=0 ; i<symbolTable.size() ; i++){
			/*if(symbolTable.elementAt(i).name.equals(varID)){
				yyerror("duplicate var declaration\n");
				return;
			}*/
		}
		//no occurance found, so we insert
		symbolTable.add(new SymbolTableRecord(last_type, varID, "\0"));
	}
	
	void insertIntoST(String funcName, String quadLine){
		for(int i=0 ; i<symbolTable.size() ; i++){
			if(symbolTable.elementAt(i).name.equals(varID)){
				yyerror("duplicate function declaration\n");
				return;
			}
		}
		symbolTable.add(new SymbolTableRecord("func", funcName, quadLine));
	}
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
/*
                         _     ___       ____ _____ 
 ___  ___  __ _ _ __ ___| |__ |_ _|_ __ / ___|_   _|
/ __|/ _ \/ _` | '__/ __| '_ \ | || '_ \\___ \ | |  
\__ \  __/ (_| | | | (__| | | || || | | |___) || |  
|___/\___|\__,_|_|  \___|_| |_|___|_| |_|____/ |_|

*/
	boolean searchInST(String varID){
		System.out.println("SEARCHING:  "+ varID);
		for(int i=0 ; i<symbolTable.size() ; i++){
			if(symbolTable.elementAt(i).name.equals(varID)){
				return true;
			}
		}
		return false;
	}
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
/*
            _   ___           _           
  __ _  ___| |_|_ _|_ __   __| | _____  __
 / _` |/ _ \ __|| || '_ \ / _` |/ _ \ \/ /
| (_| |  __/ |_ | || | | | (_| |  __/>  < 
 \__, |\___|\__|___|_| |_|\__,_|\___/_/\_\
 |___/
 
*/
	
	int getIndex(String varID){
		System.out.println("SEARCHING:  "+ varID);
		for(int i=0 ; i<symbolTable.size() ; i++){
			if(symbolTable.elementAt(i).name.equals(varID)){
				return i;
			}
		}
		return -1;
	}
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
/*
 _                     _   ____                        _ ___       _       ____ _____ 
(_)_ __  ___  ___ _ __| |_|  _ \ ___  ___ ___  _ __ __| |_ _|_ __ | |_ ___/ ___|_   _|
| | '_ \/ __|/ _ \ '__| __| |_) / _ \/ __/ _ \| '__/ _` || || '_ \| __/ _ \___ \ | |  
| | | | \__ \  __/ |  | |_|  _ <  __/ (_| (_) | | | (_| || || | | | || (_) |__) || |  
|_|_| |_|___/\___|_|   \__|_| \_\___|\___\___/|_|  \__,_|___|_| |_|\__\___/____/ |_|

*/

	void insertRecordIntoST(){
		System.out.println("INSERTING:  "+ current_record);
		System.out.println("Type:  record");
		for(int i=0 ; i<symbolTable.size() ; i++){
			/*if(symbolTable.elementAt(i).name == varID){
				yyerror("duplicate var declaration\n");
				return;
			}*/
		}
		//no occurance found, so we insert
		symbolTable.add(new SymbolTableRecord("record", current_record, "\0"));
	}

	
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
/*
              ____          _   
 _   _ _ __  / ___|__ _ ___| |_ 
| | | | '_ \| |   / _` / __| __|
| |_| | |_) | |__| (_| \__ \ |_ 
 \__,_| .__/ \____\__,_|___/\__|
      |_|                       

*/
private String upCast(Eval firstArg, Eval secondArg){
	if(firstArg.type.equals(secondArg.type)){
		return firstArg.type;
	}else if(firstArg.type.equals("int") && secondArg.type.equals("real")){
		return "real";
	}else if(firstArg.type.equals("real") && secondArg.type.equals("int")){
		return "real";
	}else if(firstArg.type.equals("int") && secondArg.type.equals("real")){
		return "real";
	}else if(firstArg.type.equals("int") && secondArg.type.equals("real")){
		return "real";
	}
	return "";
}
}

%%
program : declarationList {System.out.println("Rule 1 program : declarationList"); printQuadruple();};
 declarationList : declarationList declaration {System.out.println("Rule 2 declarationList : declarationList declaration");};
 | declaration {System.out.println("Rule 3 declarationList : declaration");};
 declaration : varDeclaration {System.out.println("Rule 4 declaration : varDeclaration");};
 | funDeclaration {System.out.println("Rule 5 declaration : funDeclaration");};
 | recDeclaration {System.out.println("Rule 6 declaration : recDeclaration");};
 recDeclaration : RECORD ID OPEN_BRACE localDeclarations CLOSE_BRACE {System.out.println("Rule 7 recDeclaration : record ID { localDeclarations }"); insertRecordIntoST();};
 varDeclaration : typeSpecifier varDeclList SEMICOLON {System.out.println("Rule 8 varDeclaration : typeSpecifier varDeclList ;");
  														//////////////////////////////////////////////////////
														backpatch($2.typeList, $1.type);
 														//////////////////////////////////////////////////////														
 };
 scopedVarDeclaration : scopedTypeSpecifier varDeclList SEMICOLON {System.out.println("Rule 9 scopedVarDeclaration : scopedTypeSpecifier varDeclList ;");
   														//////////////////////////////////////////////////////
														backpatch($2.typeList, $1.type);
 														//////////////////////////////////////////////////////
 };
 varDeclList : varDeclList COMMA varDeclInitialize {System.out.println("Rule 10 varDeclList : varDeclList , varDeclInitialize");
 														//////////////////////////////////////////////////////
														$$ = new Eval();
														((Eval)$$).typeList = Eval.merge($1.typeList,$3.typeList);
														//////////////////////////////////////////////////////														
														};
 | varDeclInitialize {System.out.println("Rule 11 varDeclList : varDeclInitialize");
 														//////////////////////////////////////////////////////
														$$ = new Eval();
														((Eval)$$).typeList = $1.typeList;
														//////////////////////////////////////////////////////														
};
 varDeclInitialize : varDeclId {System.out.println("Rule 12 varDeclInitialize : varDeclId");};
 | varDeclId COLON simpleExpression {System.out.println("Rule 13 varDeclInitialize : varDeclId : simpleExpression");
  														//////////////////////////////////////////////////////
														if($3.type.equals("bool")){
														backpatch($3.trueList, quadruple.size());
														backpatch($3.falseList, quadruple.size()+2);
														emit("ass","true",null,$1.place);
														emit("goto",null,null,"" + (quadruple.size()+2));
														emit("ass","false",null,$1.place);
														}
														else{
														emit("ass",$3.place,null,$1.place);
														}
 														//////////////////////////////////////////////////////														
														};
 varDeclId : ID {System.out.println("Rule 14 varDeclId : ID");
 														//////////////////////////////////////////////////////
														insertIntoST(current_ID);
														$$ = new Eval();
														((Eval)$$).place = $1.place;
														((Eval)$$).typeList = Eval.makeList(quadruple.size());
														emit("def",null,$1.place,null);
														//////////////////////////////////////////////////////														
														};
 | ID OPEN_BRACKET NUMCONST CLOSE_BRACKET {System.out.println("Rule 15 varDeclId : ID [ NUMCONST ]"); insertIntoST(current_ID);};
 scopedTypeSpecifier : STATIC typeSpecifier {System.out.println("Rule 16 scopedTypeSpecifier : STATIC typeSpecifier");};
 | typeSpecifier {System.out.println("Rule 17 scopedTypeSpecifier : typeSpecifier");};
 typeSpecifier : returnTypeSpecifier {System.out.println("Rule 18 typeSpecifier : returnTypeSpecifier");
 														//////////////////////////////////////////////////////
														last_type = yylexer.getLVal().toString();
														$$ = new Eval();
														((Eval)$$).type = $1.type;
 														//////////////////////////////////////////////////////														
														};
 | RECTYPE {System.out.println("Rule 19 typeSpecifier : RECTYPE"); last_type = yylexer.getLVal().toString();};
 returnTypeSpecifier : INT {System.out.println("Rule 20 returnTypeSpecifier : int");
  														//////////////////////////////////////////////////////
														$$ = new Eval();
														((Eval)$$).type = "int";
 														//////////////////////////////////////////////////////														
 };
 | REAL {System.out.println("Rule 21 returnTypeSpecifier : real");
   														//////////////////////////////////////////////////////
														$$ = new Eval();
														((Eval)$$).type = "real";
 														//////////////////////////////////////////////////////	
 };
 | BOOL {System.out.println("Rule 22 returnTypeSpecifier : bool");
   														//////////////////////////////////////////////////////
														$$ = new Eval();
														((Eval)$$).type = "bool";
 														//////////////////////////////////////////////////////	
 };
 | CHAR {System.out.println("Rule 23 returnTypeSpecifier : char");
   														//////////////////////////////////////////////////////
														$$ = new Eval();
														((Eval)$$).type = "char";
 														//////////////////////////////////////////////////////	
 };
 funDeclaration : typeSpecifier ID OPEN_PARANTHESIS params CLOSE_PARANTHESIS statement {System.out.println("Rule 24 funDeclaration : typeSpecifier ID ( params ) statement");
          												//////////////////////////////////////////////////////
														($$) = new Eval();
														backpatch($6.nextList, quadruple.size());
														insertIntoST();
       													//////////////////////////////////////////////////////
 };
 | ID OPEN_PARANTHESIS params CLOSE_PARANTHESIS M T statement {System.out.println("Rule 25 funDeclaration : ID ( params ) statement");
         												//////////////////////////////////////////////////////
														($$) = new Eval();
														backpatch($6.nextList, quadruple.size());
														insertIntoST($1.place, $5.quad);
														
       													//////////////////////////////////////////////////////
 };
 
 T : {}
 
 params : paramList {System.out.println("Rule 26 params : paramList");};
 | {System.out.println("Rule 27 params : lamda");};
 paramList : paramList SEMICOLON paramTypeList {System.out.println("Rule 28 paramList : paramList ; paramTypeList");};
 | paramTypeList {System.out.println("Rule 29 paramList : paramTypeList");};
 paramTypeList : typeSpecifier paramIdList {System.out.println("Rule 30 paramTypeList : typeSpecifier paramIdList");};
 paramIdList : paramIdList COMMA paramId {System.out.println("Rule 31 paramIdList : paramIdList , paramId");};
 | paramId {System.out.println("Rule 32 paramIdList : paramId");};
 paramId : ID {System.out.println("Rule 33 paramId : ID");};
 | ID OPEN_BRACKET CLOSE_BRACKET {System.out.println("Rule 34 paramId : ID[]");};
 statement : expressionStmt {System.out.println("Rule 35 statement : expressionStmt");
         												//////////////////////////////////////////////////////
														($$) = new Eval();
														((Eval)$$).nextList = $1.nextList;
       													//////////////////////////////////////////////////////
 };
 | compoundStmt {System.out.println("Rule 36 statement : compoundStmt");
        												//////////////////////////////////////////////////////
														($$) = new Eval();
														((Eval)$$).breakList = $1.breakList;
														((Eval)$$).nextList = $1.nextList;
       													//////////////////////////////////////////////////////														
 };
 | selectionStmt {System.out.println("Rule 37 statement : selectionStmt");
       													//////////////////////////////////////////////////////
														($$) = new Eval();
														((Eval)$$).breakList = $1.breakList;
														((Eval)$$).nextList = $1.nextList;
     													//////////////////////////////////////////////////////	
 };
 | iterationStmt {System.out.println("Rule 38 statement : iterationStmt");
       													//////////////////////////////////////////////////////
														($$) = new Eval();
														((Eval)$$).breakList = $1.breakList;
														((Eval)$$).nextList = $1.nextList;
     													//////////////////////////////////////////////////////	
 };
 | returnStmt {System.out.println("Rule 39 statement : returnStmt");};
 | breakStmt {System.out.println("Rule 40 statement : breakStmt");
      													//////////////////////////////////////////////////////
														($$) = new Eval();
														((Eval)$$).breakList = $1.breakList;
     													//////////////////////////////////////////////////////														
 };
 compoundStmt : OPEN_BRACE localDeclarations statementList CLOSE_BRACE {System.out.println("Rule 41 compoundStmt : { localDeclarations statementList }");
        												//////////////////////////////////////////////////////
														($$) = new Eval();
														((Eval)$$).breakList = $3.breakList;
       													//////////////////////////////////////////////////////															
 };
 localDeclarations : localDeclarations scopedVarDeclaration {System.out.println("Rule 42 localDeclarations : localDeclarations scopedVarDeclaration");};
 | {System.out.println("Rule 43 localDeclarations : lamda");};
 statementList : statementList statement {System.out.println("Rule 44 statementList : statementList statement");
       													//////////////////////////////////////////////////////
														($$) = new Eval();
														((Eval)$$).breakList = Eval.merge($1.breakList,$2.breakList);
														
      													//////////////////////////////////////////////////////														
 };
 | {System.out.println("Rule 45 statementList : lamda");};
 expressionStmt : expression SEMICOLON {System.out.println("Rule 46 expressionStmt : expression ;");};
 | SEMICOLON {System.out.println("Rule 47 expressionStmt : ;");};
 selectionStmt : IF OPEN_PARANTHESIS simpleExpression CLOSE_PARANTHESIS statement ELSE statement   {System.out.println("Rule 49 selectionStmt : IF ( simpleExpression ) statement ELSE statement");};
 |IF OPEN_PARANTHESIS simpleExpression CLOSE_PARANTHESIS statement %prec p {System.out.println("Rule 48 selectionStmt : IF ( simpleExpression ) statement");};
 | SWITCH OPEN_PARANTHESIS simpleExpression CLOSE_PARANTHESIS M caseElement defaultElement END {System.out.println("Rule 50 selectionStmt : SWITCH ( simpleExpression ) caseElement defaultElement END");
           												//////////////////////////////////////////////////////
														$$ = new Eval();
														//backpatchForArg2($5.switchList, $3.place);
														QuadrupleRecord sc = quadruple.elementAt($5.quad - 1);
														sc.result = "" + (quadruple.size()+1);
														quadruple.set($5.quad - 1, sc);
														backpatch($6.breakList, (quadruple.size()+1)+3*cases.size());
														emit("goto", null, null, (quadruple.size()+1)+3*cases.size() + "");
														
														for(int i=0 ; i<cases.size() ; i++){
															String tmp = newTmp("int");
															emit("EQ", cases.elementAt(i).value + "", $3.place, tmp);
															emit("if", tmp, null, cases.elementAt(i).quadLine + "");
														}
														
														cases.clear();
          												//////////////////////////////////////////////////////														
 };
 caseElement : CASE NUMCONST COLON M statement SEMICOLON {System.out.println("Rule 51 caseElement : CASE NUMCONST : statement ;");
          												//////////////////////////////////////////////////////
														$$ = new Eval();
														//((Eval)$$).place = newTmp("int");
														((Eval)$$).breakList = $5.breakList;
														//((Eval)$$).switchList = Eval.makeList(quadruple.size());
														//emit("EQ", $2.place, null, ((Eval)$$).place); //will be backpatch
														//emit("if", ((Eval)$$).place, null, $4.quad + "");
														//emit("goto", null, null, quadruple.size() + "");
														emit("goto", null, null, null); //will be backpatch
														SwitchCase sc = new SwitchCase($4.quad, $2.place);
														cases.add(sc);
         												//////////////////////////////////////////////////////														
 };
 | caseElement CASE NUMCONST COLON M statement SEMICOLON {System.out.println("Rule 52 caseElement : caseElement CASE NUMCONST : statement ;");
         												//////////////////////////////////////////////////////
														($$) = new Eval();
														((Eval)$$).breakList = Eval.merge($1.breakList, $6.breakList);
														//((Eval)$$).place = newTmp("int");
														//Vector<Integer> newItem = new Vector<Integer>();
														//newItem.add(quadruple.size());
														//((Eval)$$).switchList = Eval.merge($1.switchList, newItem);
														//emit("EQ", $3.place, null, ((Eval)$$).place); //will be backpatch
														//emit("if", ((Eval)$$).place, null, $5.quad + "");
														//emit("goto", null, null, quadruple.size() + "");
														SwitchCase sc = new SwitchCase($5.quad, $3.place);
														cases.add(sc);
       													//////////////////////////////////////////////////////
 };
 defaultElement : DEFAULT COLON statement SEMICOLON {System.out.println("Rule 53 defaultElement : DEFAULT : statement ;");
         												//////////////////////////////////////////////////////
														($$) = new Eval();
														((Eval)$$).breakList = $3.breakList;
       													//////////////////////////////////////////////////////
 };
 | {System.out.println("Rule 54 defaultElement : lamda");};
 iterationStmt : WHILE OPEN_PARANTHESIS M simpleExpression CLOSE_PARANTHESIS N statement {System.out.println("Rule 55 iterationStmt : while ( simpleExpression ) statement");
     													//////////////////////////////////////////////////////
														($$) = new Eval();
														backpatch($7.breakList, quadruple.size() + 1);
														backpatch($7.nextList, $3.quad);
														backpatch($4.trueList, $6.quad);
														((Eval)$$).nextList = $4.falseList;
														emit("goto", null,null,$3.quad + "");
														backpatch(((Eval)$$).nextList, quadruple.size());
     													//////////////////////////////////////////////////////												
 };
 returnStmt : RETURN SEMICOLON {System.out.println("Rule 56 returnStmt : return ;");};
 | RETURN expression SEMICOLON {System.out.println("Rule 57 returnStmt : return expression ;");};
 breakStmt : BREAK SEMICOLON {System.out.println("Rule 58 breakStmt : break ;");
      													//////////////////////////////////////////////////////
														($$) = new Eval();
														((Eval)$$).breakList = Eval.makeList(quadruple.size());
														emit("goto",null,null,null);
     													//////////////////////////////////////////////////////														
 };
 expression : mutable EQUAL M expression {System.out.println("Rule 59 expression : mutable = expression");
  														//////////////////////////////////////////////////////
														($$) = new Eval();
														((Eval)$$).place = $1.place;
														backpatch($4.trueList, quadruple.size());
														backpatch($4.falseList, quadruple.size());
														backpatch($1.nextList, $3.quad);
														((Eval)$$).trueList = $4.trueList;
														((Eval)$$).falseList = $4.falseList;
														emit("ass", $4.place, null, $1.place);
														((Eval)$$).type = $1.type;
														//////////////////////////////////////////////////////	
 };
 | mutable PLUSEQUAL M expression {System.out.println("Rule 60 expression : mutable += expression");
   														//////////////////////////////////////////////////////
														($$) = new Eval();
														((Eval)$$).place = $1.place;
														backpatch($4.trueList, quadruple.size());
														backpatch($4.falseList, quadruple.size());
														backpatch($1.nextList, $3.quad);
														((Eval)$$).trueList = $4.trueList;
														((Eval)$$).falseList = $4.falseList;
														//if(symbolTable.get(getIndex($4.place)).type.equals("bool"))
														emit("plus", $4.place, $1.place, $1.place);
														((Eval)$$).type = $1.type;
														//////////////////////////////////////////////////////	
 };
 | mutable MINUSEQUAL M expression {System.out.println("Rule 61 expression : mutable -= expression");
    													//////////////////////////////////////////////////////
														($$) = new Eval();
														((Eval)$$).place = $1.place;
														backpatch($4.trueList, quadruple.size());
														backpatch($4.falseList, quadruple.size());
														backpatch($1.nextList, $3.quad);
														((Eval)$$).trueList = $4.trueList;
														((Eval)$$).falseList = $4.falseList;
														//if(symbolTable.get(getIndex($4.place)).type.equals("bool"))
														emit("minus", $1.place, $4.place, $1.place);
														((Eval)$$).type = $1.type;
														//////////////////////////////////////////////////////	
 };
 | mutable MULTIPLYEQUAL M expression {System.out.println("Rule 62 expression : mutable *= expression");
     													//////////////////////////////////////////////////////
														($$) = new Eval();
														((Eval)$$).place = $1.place;
														backpatch($4.trueList, quadruple.size());
														backpatch($4.falseList, quadruple.size());
														backpatch($1.nextList, $3.quad);
														((Eval)$$).trueList = $4.trueList;
														((Eval)$$).falseList = $4.falseList;
														//if(symbolTable.get(getIndex($4.place)).type.equals("bool"))
														emit("mult", $4.place, $1.place, $1.place);
														((Eval)$$).type = $1.type;
														//////////////////////////////////////////////////////
};
 | mutable DIVIDEQUAL M expression {System.out.println("Rule 63 expression : mutable /= expression");
      													//////////////////////////////////////////////////////
														($$) = new Eval();
														((Eval)$$).place = $1.place;
														backpatch($4.trueList, quadruple.size());
														backpatch($4.falseList, quadruple.size());
														backpatch($1.nextList, $3.quad);
														((Eval)$$).trueList = $4.trueList;
														((Eval)$$).falseList = $4.falseList;
														//if(symbolTable.get(getIndex($4.place)).type.equals("bool"))
														emit("div", $1.place, $4.place, $1.place);
														((Eval)$$).type = $1.type;
														//////////////////////////////////////////////////////
 };
 | mutable PLUSPLUS {System.out.println("Rule 64 expression : mutable ++");
       													//////////////////////////////////////////////////////
														($$) = new Eval();
														((Eval)$$).place = $1.place;
														backpatch($1.nextList, quadruple.size());
														//((Eval)$$).trueList = $4.trueList;
														//((Eval)$$).falseList = $4.falseList;
														//if(symbolTable.get(getIndex($4.place)).type.equals("bool"))
														emit("plus", $1.place, "1", $1.place);
														((Eval)$$).type = $1.type;
														//////////////////////////////////////////////////////
 };
 | mutable MINUSMINUS {System.out.println("Rule 65 expression : mutable--");
        												//////////////////////////////////////////////////////
														($$) = new Eval();
														((Eval)$$).place = $1.place;
														backpatch($1.nextList, quadruple.size());
														//((Eval)$$).trueList = $4.trueList;
														//((Eval)$$).falseList = $4.falseList;
														//if(symbolTable.get(getIndex($4.place)).type.equals("bool"))
														emit("minus", $1.place, "1", $1.place);
														((Eval)$$).type = $1.type;
														//////////////////////////////////////////////////////
 };
 | simpleExpression {System.out.println("Rule 66 expression : simpleExpression");
 														//////////////////////////////////////////////////////
														($$) = new Eval();
														((Eval)$$).trueList = $1.trueList;
														((Eval)$$).falseList = $1.falseList;
														((Eval)$$).place = $1.place;
														((Eval)$$).type = $1.type;
														//////////////////////////////////////////////////////														
 };
 simpleExpression : simpleExpression OR M simpleExpression {System.out.println("Rule 67 simpleExpression : simpleExpression OR simpleExpression");
														//////////////////////////////////////////////////////
														  ($$) = new Eval();
														  ((Eval)$$).place = newTmp("bool");
														  ((Eval)$$).type = "bool";
														  backpatch($1.trueList, quadruple.size()-1);
														  emit("ass", "true", null, ((Eval)$$).place);
														  emit("goto", null, null, $3.quad + "");
														  backpatch($1.falseList, quadruple.size()-1);														  
														  emit("ass", "false", null, ((Eval)$$).place);
														  emit("goto", null, null, $3.quad + "");
														  backpatch($4.trueList, quadruple.size());
														  backpatch($4.falseList, quadruple.size());
														  emit("+", $4.place,((Eval)$$).place,((Eval)$$).place);	 
														  ((Eval)$$).trueList = Eval.makeList(quadruple.size());
														  ((Eval)$$).falseList = Eval.makeList(quadruple.size()+1);
														  emit("if", ((Eval)$$).place, null, null);
														  emit("goto", null, null, null);
														//////////////////////////////////////////////////////														  
														  };
 | simpleExpression AND  M simpleExpression {System.out.println("Rule 68 simpleExpression : simpleExpression and simpleExpression");
 														//////////////////////////////////////////////////////
														  ($$) = new Eval();
														  ((Eval)$$).place = newTmp("bool");
														  ((Eval)$$).type = "bool";
														  backpatch($1.trueList, quadruple.size()-1);
														  emit("ass", "true", null, ((Eval)$$).place);
														  emit("goto", null, null, $3.quad + "");
														  backpatch($1.falseList, quadruple.size()-1);														  
														  emit("ass", "false", null, ((Eval)$$).place);
														  emit("goto", null, null, $3.quad + "");
														  backpatch($4.trueList, quadruple.size());
														  backpatch($4.falseList, quadruple.size());
														  emit("*", $4.place,((Eval)$$).place,((Eval)$$).place);
														  ((Eval)$$).trueList = Eval.makeList(quadruple.size());
														  ((Eval)$$).falseList = Eval.makeList(quadruple.size()+1);
														  emit("if", ((Eval)$$).place, null, null);
														  emit("goto", null, null, null);
														//////////////////////////////////////////////////////
														};
 | simpleExpression ORELSE M simpleExpression {System.out.println("Rule 69 simpleExpression : simpleExpression or else simpleExpression");
 														//////////////////////////////////////////////////////
														($$) = new Eval();
														  ((Eval)$$).place = newTmp("bool");
														  ((Eval)$$).type = "bool";
														  backpatch($1.falseList, $3.quad);
														  ((Eval)$$).trueList = Eval.merge($1.trueList, $4.trueList);
														  ((Eval)$$).falseList = $4.falseList;
														//////////////////////////////////////////////////////
 };
 | simpleExpression ANDTHEN M simpleExpression {System.out.println("Rule 70 simpleExpression : simpleExpression and then simpleExpression");
  														//////////////////////////////////////////////////////
														($$) = new Eval();
														  //((Eval)$$).place = newTmp("bool");
														  //boolean result = Boolean.parseBoolean($1.place) & Boolean.parseBoolean($4.place);
														  //emit("ass", ""+result, null, ((Eval)$$).place);
														  //((Eval)$$).place=""+result;
														  ((Eval)$$).type = "bool";
														  backpatch($1.trueList, $3.quad);
														  ((Eval)$$).trueList = $4.trueList;
														  ((Eval)$$).falseList = Eval.merge($1.falseList, $4.falseList);
														//////////////////////////////////////////////////////
 };
 | NOT simpleExpression {System.out.println("Rule 71 simpleExpression : not simpleExpression");
   														//////////////////////////////////////////////////////
														  ($$) = new Eval();
														  //((Eval)$$).place = newTmp("bool");
														  //boolean result = Boolean.parseBoolean($1.place) & Boolean.parseBoolean($4.place);
														  //emit("ass", ""+result, null, ((Eval)$$).place);
														  //((Eval)$$).place=""+result;
														  ((Eval)$$).type = "bool";
														  //backpatch($1.falseList, $3.quad);
														  //backpatch($1.trueList, $3.quad);
														  ((Eval)$$).trueList = $2.falseList;
														  ((Eval)$$).falseList = $2.trueList;
														//////////////////////////////////////////////////////
 };
 | relExpression {System.out.println("Rule 72 simpleExpression : relExpression");
     													//////////////////////////////////////////////////////
														$$ = new Eval();
														((Eval)$$).trueList = $1.trueList;
														((Eval)$$).falseList = $1.falseList;
														((Eval)$$).place = $1.place;
														((Eval)$$).type = $1.type;
   														//////////////////////////////////////////////////////	
 };
 relExpression : mathlogicExpression relop mathlogicExpression {System.out.println("Rule 73 relExpression : mathlogicExpression relop mathlogicExpression");
      													//////////////////////////////////////////////////////
														$$ = new Eval();
														((Eval)$$).place=newTmp("bool");
														((Eval)$$).type="bool";
														emit($2.type,$1.place,$3.place,((Eval)$$).place);
														((Eval)$$).trueList=Eval.makeList(quadruple.size());
														emit("if",((Eval)$$).place, null, null);
														((Eval)$$).falseList=Eval.makeList(quadruple.size());
														emit("goto",null,null,null);
														((Eval)$$).nextList=Eval.merge(((Eval)$$).trueList, ((Eval)$$).falseList);
     													//////////////////////////////////////////////////////														
														};
 | mathlogicExpression {System.out.println("Rule 74 relExpression : mathlogicExpression");
     													//////////////////////////////////////////////////////
														$$ = new Eval();
														((Eval)$$).trueList = $1.trueList;
														((Eval)$$).falseList = $1.falseList;
														((Eval)$$).place = $1.place;
														((Eval)$$).type = $1.type;
   														//////////////////////////////////////////////////////	
														};
 relop : LE {System.out.println("Rule 75 relop : LE");
    													//////////////////////////////////////////////////////
														$$ = new Eval();
														((Eval)$$).type="LE";
   														//////////////////////////////////////////////////////	
														};
 | LT {System.out.println("Rule 76 relop : LT");
     													//////////////////////////////////////////////////////
														$$ = new Eval();
														((Eval)$$).type="LT";
   														//////////////////////////////////////////////////////	
														};
 | GT {System.out.println("Rule 77 relop : GT");
     													//////////////////////////////////////////////////////
														$$ = new Eval();
														((Eval)$$).type="GT";
   														//////////////////////////////////////////////////////	
														};
 | GE {System.out.println("Rule 78 relop : GE");
     													//////////////////////////////////////////////////////
														$$ = new Eval();
														((Eval)$$).type="GE";
   														//////////////////////////////////////////////////////	
														};
 | EQ {System.out.println("Rule 79 relop : EQ");
     													//////////////////////////////////////////////////////
														$$ = new Eval();
														((Eval)$$).type="EQ";
   														//////////////////////////////////////////////////////	
														};
 | NE {System.out.println("Rule 80 relop : NE");
     													//////////////////////////////////////////////////////
														$$ = new Eval();
														((Eval)$$).type="NE";
   														//////////////////////////////////////////////////////	
														};
 mathlogicExpression : mathlogicExpression MATHMIN mathlogicExpression {System.out.println("Rule 81 mathlogicExpression : mathlogicExpression MATHMIN mathlogicExpression");
      													//////////////////////////////////////////////////////
														$$ = new Eval();
														//!!!TODO:Casting!!!
														((Eval)$$).place = newTmp($1.type);
														((Eval)$$).type = $1.type;
														emit("minus", $1.place, $3.place, ((Eval)$$).place);
   														//////////////////////////////////////////////////////
 };
 | mathlogicExpression MATHMUL mathlogicExpression {System.out.println("Rule 82 mathlogicExpression : mathlogicExpression MATHMUL mathlogicExpression");
       													//////////////////////////////////////////////////////
														$$ = new Eval();
														//!!!TODO:Casting!!!
														((Eval)$$).place = newTmp($1.type);
														((Eval)$$).type = $1.type;
														emit("mult", $1.place, $3.place, ((Eval)$$).place);
   														//////////////////////////////////////////////////////
};
 | mathlogicExpression MATHDIV mathlogicExpression {System.out.println("Rule 83 mathlogicExpression : mathlogicExpression MATHDIV mathlogicExpression");
        												//////////////////////////////////////////////////////
														$$ = new Eval();
														//!!!TODO:Casting!!!
														((Eval)$$).place = newTmp($1.type);
														((Eval)$$).type = $1.type;
														emit("div", $1.place, $3.place, ((Eval)$$).place);
   														//////////////////////////////////////////////////////
 };
 | mathlogicExpression MATHPLU mathlogicExpression {System.out.println("Rule 84 mathlogicExpression : mathlogicExpression MATHPLU mathlogicExpression");
        												//////////////////////////////////////////////////////
														$$ = new Eval();
														//!!!TODO:Casting!!!
														((Eval)$$).place = newTmp($1.type);
														((Eval)$$).type = $1.type;
														emit("plus", $1.place, $3.place, ((Eval)$$).place);
   														//////////////////////////////////////////////////////
 };
 | mathlogicExpression MATHMOD mathlogicExpression {System.out.println("Rule 85 mathlogicExpression : mathlogicExpression MATHMOD mathlogicExpression");
        												//////////////////////////////////////////////////////
														$$ = new Eval();
														//!!!TODO:Casting!!!
														((Eval)$$).place = newTmp($1.type);
														((Eval)$$).type = $1.type;
														emit("mod", $1.place, $3.place, ((Eval)$$).place);
   														//////////////////////////////////////////////////////
 };
 | unaryExpression {System.out.println("Rule 86 mathlogicExpression : unaryExpression");
     													//////////////////////////////////////////////////////
														$$ = new Eval();
														((Eval)$$).trueList = $1.trueList;
														((Eval)$$).falseList = $1.falseList;
														((Eval)$$).place = $1.place;
														((Eval)$$).type = $1.type;
   														//////////////////////////////////////////////////////	
 };
 unaryExpression : unaryop unaryExpression {System.out.println("Rule 87 unaryExpression : unaryop unaryExpression");};
 | factor {System.out.println("Rule 88 unaryExpression : factor");
     													//////////////////////////////////////////////////////
														$$ = new Eval();
														((Eval)$$).trueList = $1.trueList;
														((Eval)$$).falseList = $1.falseList;
														((Eval)$$).place = $1.place;
														((Eval)$$).type = $1.type;
   														//////////////////////////////////////////////////////	
 };
 unaryop : MATHMIN {System.out.println("Rule 89 unaryop : MATHMIN");};
 | MATHMUL {System.out.println("Rule 90 unaryop : MATHMUL");};
 | QUESTIONSIGN {System.out.println("Rule 91 unaryop : QUESTIONSIGN");};
 factor : immutable {System.out.println("Rule 92 factor : immutable");
     													//////////////////////////////////////////////////////
														$$ = new Eval();
														((Eval)$$).trueList = $1.trueList;
														((Eval)$$).falseList = $1.falseList;
														((Eval)$$).place = $1.place;
														((Eval)$$).type = $1.type;
   														//////////////////////////////////////////////////////	
 };
 | mutable {System.out.println("Rule 93 factor : mutable");};
 mutable : ID {System.out.println("Rule 94 mutable : ID");
  														//////////////////////////////////////////////////////
														($$) = new Eval();
														int index = getIndex($1.place);
														//Implement existance checking in symbolTable
														
														((Eval)$$).place = $1.place;
														((Eval)$$).type = symbolTable.get(index).type;
														((Eval)$$).trueList = Eval.makeList(quadruple.size());
														((Eval)$$).falseList = Eval.makeList(quadruple.size()+1);
														((Eval)$$).nextList = Eval.merge(((Eval)$$).trueList, ((Eval)$$).falseList);
														emit("if", ((Eval)$$).place, null, null);
														emit("goto", null,null,null);
														//////////////////////////////////////////////////////
 };
 | mutable OPEN_BRACKET expression CLOSE_BRACKET {System.out.println("Rule 95 mutable : mutable [ expression ]");};
 | mutable DOT ID {System.out.println("Rule 96 mutable : mutable DOT ID");};
 immutable : OPEN_PARANTHESIS expression CLOSE_PARANTHESIS {System.out.println("Rule 97 immutable : ( expression )");
  														//////////////////////////////////////////////////////
														($$) = new Eval();
														((Eval)$$).trueList = $2.trueList;
														((Eval)$$).falseList = $2.falseList;
														((Eval)$$).place = $2.place;
														((Eval)$$).type = $2.type;
														//////////////////////////////////////////////////////	
};
 | call {System.out.println("Rule 98 immutable : call");};
 | constant {System.out.println("Rule 99 immutable : constant");
    													//////////////////////////////////////////////////////
														$$ = new Eval();
														((Eval)$$).trueList = $1.trueList;
														((Eval)$$).falseList = $1.falseList;
														((Eval)$$).place = $1.place;
														((Eval)$$).type = $1.type;
   														//////////////////////////////////////////////////////															
 };
 call : ID OPEN_PARANTHESIS args CLOSE_PARANTHESIS {System.out.println("Rule 100 call : ID ( args )");
     													//////////////////////////////////////////////////////
														
														
    													//////////////////////////////////////////////////////														
 };
 args : argList {System.out.println("Rule 101 args : argList");};
 | {System.out.println("Rule 102 args : lamda");};
 argList : argList COMMA expression {System.out.println("Rule 103 argList : argList , expression");};
 | expression {System.out.println("Rule 104 argList : expression");
      													//////////////////////////////////////////////////////
														
     													//////////////////////////////////////////////////////														
 };
 constant : NUMCONST {System.out.println("Rule 105 constant : NUMCONST");
   														//////////////////////////////////////////////////////
														($$) = new Eval();
														((Eval)$$).place = newTmp("int");
														((Eval)$$).type = "int";
														emit("ass",$1.place,null,((Eval)$$).place);
  														//////////////////////////////////////////////////////
														};
 | REALCONST {System.out.println("Rule 106 constant : REALCONST");
    													//////////////////////////////////////////////////////
														($$) = new Eval();
														((Eval)$$).place = newTmp("real");
														((Eval)$$).type = "real";
														emit("ass",$1.place,null,((Eval)$$).place);
  														//////////////////////////////////////////////////////
														};
 | CHARCONST1 {System.out.println("Rule 107 constant : CHARCONST1");
    													//////////////////////////////////////////////////////
														($$) = new Eval();
														((Eval)$$).place = newTmp("char");
														((Eval)$$).type = "char";
														emit("ass",$1.place,null,((Eval)$$).place);
  														//////////////////////////////////////////////////////
														};
 | CHARCONST2 {System.out.println("Rule 108 constant : CHARCONST2");
    													//////////////////////////////////////////////////////
														($$) = new Eval();
														((Eval)$$).place = newTmp("char");
														((Eval)$$).type = "char";
														emit("ass",$1.place,null,((Eval)$$).place);
  														//////////////////////////////////////////////////////
														};
 | TRUE {System.out.println("Rule 109 constant : TRUE");
   														//////////////////////////////////////////////////////
														($$) = new Eval();
														((Eval)$$).place = newTmp("bool");
														emit("ass","true",null,((Eval)$$).place);
														((Eval)$$).type = "bool";
														//emit("ass","true",null,((Eval)$$).place);
														((Eval)$$).trueList = Eval.makeList(quadruple.size());
														((Eval)$$).falseList = Eval.makeList(-1);
														((Eval)$$).nextList = ((Eval)$$).trueList;
														emit("goto",null,null,null);
														
														
  														//////////////////////////////////////////////////////														
														};
 | FALSE {System.out.println("Rule 110 constant : FALSE");
														//////////////////////////////////////////////////////
														($$) = new Eval();
														((Eval)$$).place =  newTmp("bool");
														emit("ass","false",null,((Eval)$$).place);
														((Eval)$$).type = "bool";
														
														((Eval)$$).falseList = Eval.makeList(quadruple.size());
														((Eval)$$).trueList = Eval.makeList(-1);
														((Eval)$$).nextList = ((Eval)$$).falseList;														
														emit("goto",null,null,null);
														
  														//////////////////////////////////////////////////////
														};
 M : {((Eval)$$).quad = quadruple.size();}
  N : {((Eval)$$).quad = quadruple.size();}

%%
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
/*
 _   _                  ____          _
| | | |___  ___ _ __   / ___|___   __| | ___
| | | / __|/ _ \ '__| | |   / _ \ / _` |/ _ \
| |_| \__ \  __/ |    | |__| (_) | (_| |  __/
 \___/|___/\___|_|     \____\___/ \__,_|\___|
*/
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
/*
  ___                  _                  _
 / _ \ _   _  __ _  __| |_ __ _   _ _ __ | | ___
| | | | | | |/ _` |/ _` | '__| | | | '_ \| |/ _ \
| |_| | |_| | (_| | (_| | |  | |_| | |_) | |  __/
 \__\_\\__,_|\__,_|\__,_|_|   \__,_| .__/|_|\___|
							       |_|
 ____                        _
|  _ \ ___  ___ ___  _ __ __| |
| |_) / _ \/ __/ _ \| '__/ _` |
|  _ <  __/ (_| (_) | | | (_| |
|_| \_\___|\___\___/|_|  \__,_|
*/
class QuadrupleRecord{
  /////////////////////////////////////////Attributes/////////////////////////////////////////
	public String instruction;
	public String	firstArg;
	public String secondArg;
	public String result;
	/////////////////////////////////////////Methods/////////////////////////////////////////
	//Constructor
	public QuadrupleRecord(String instruction,String firstArg,String secondArg,String result)
	{
	this.instruction= instruction;
	this.firstArg= firstArg;
	this.secondArg= secondArg;
	this.result= result;
	}

}
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
/*
 ____                  _           _ _____     _     _      ____                        _ 
/ ___| _   _ _ __ ___ | |__   ___ | |_   _|_ _| |__ | | ___|  _ \ ___  ___ ___  _ __ __| |
\___ \| | | | '_ ` _ \| '_ \ / _ \| | | |/ _` | '_ \| |/ _ \ |_) / _ \/ __/ _ \| '__/ _` |
 ___) | |_| | | | | | | |_) | (_) | | | | (_| | |_) | |  __/  _ <  __/ (_| (_) | | | (_| |
|____/ \__, |_| |_| |_|_.__/ \___/|_| |_|\__,_|_.__/|_|\___|_| \_\___|\___\___/|_|  \__,_|
       |___/                                                                              

*/

//function : type=func		value=quadrupleAddress
//rect : type=rect			

class SymbolTableRecord{
		public String type;
		public String name;
		public String value;
		public SymbolTableRecord(String type, String name, String value) {
			this.type = type;
			this.name = name;
			this.value = value;
		}
	}

////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

class ActivationRecord{
	public String returnPlace;
	public Vector<String> params;
	public ActivationRecord(String returnPlace, Vector<String> params){
		this.returnPlace = returnPlace;
		this.params = params; //referenced to original parameter
	}
}

////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

class SwitchCase{
	public int quadLine;
	public int value;
	SwitchCase(int quadLine, String value){
		this.quadLine = quadLine;
		this.value = Integer.parseInt(value);
	}
	SwitchCase(int quadLine, int value){
		this.quadLine = quadLine;
		this.value = value;
	}
}