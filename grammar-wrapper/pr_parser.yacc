%{

PR_SYMBOL_OCC* CreateToken(const char* str,SYMBOL_COORDINATES coord) 
 {
  return new PR_SYMBOL_OCC(registerSym(str),coord);
 };
 
%}

      /* punctuation */       
%token DOT COMMA LEFT_PAR RIGHT_PAR LEFT_BR RIGHT_BR MINUS PLUS
%token COLON NEGATION EXCLAMATION QUESTION OR AND Equal Greater Less
 
      /* string constants */
      
%token STRING 
  
     /* errors */
    
%token SCAN_ERROR      
 
     /* identifiers */
   
%token NONNUMERIC_FUNCTOR NUMERIC_CONSTANT VAR_ID 
 

/**************************************************************************/
 
%start start_nonterminal

     
%%
 
/******************** Grammar: ******************************************/

start_nonterminal : /* empty */
                  | start_nonterminal input_item
                     {
                      FileParsResult->AddLiteral($2.literal);

                      //$2.literal->Output(); cout << "\n"; // debug
  
                     }
                  | error { FileParsResult->ErrorAt("Syntax error.",lineNum,charNum); return 1; }
                  ; 
     
input_item : fact 
              {
               //$$.literal->Output(); cout << "\n"; 
              } ;

fact : predicate DOT { $$.literal = new PR_LITERAL($1.token,(PR_TERM_LIST*)0); }
     | predicate LEFT_PAR nonempty_term_list RIGHT_PAR DOT
        {         
         $$.literal = new PR_LITERAL($1.token,$3.term_list); 
        }
     ;

nonempty_term_list : term { $$.term_list = new PR_TERM_LIST($1.term,(PR_TERM_LIST*)0); }
                   | nonempty_term_list COMMA term 
                      { $$.term_list = new PR_TERM_LIST($3.term,$1.term_list); }
                   ;

term : maxi_term 
        {
         //cout << "TERM\n    "; $$.term->Output(); cout << "\n"; 
        } ;
                   
maxi_term : mini_term
          | maxi_term infix_op mini_term 
            {
             $$.term = new PR_TERM($2.token,new PR_TERM_LIST($1.term,new PR_TERM_LIST($3.term)));
            }
          ;

mini_term : variable { $$.term = new PR_TERM(PR_TERM::VAR,$1.token); }
          | functor 
             {

              //cout << "MINI_TERM\n"; // debug
              //$1.token->Output(); cout << "\n"; // debug
   
              $$.term = new PR_TERM(PR_TERM::ATOM_FUNCTOR,$1.token); 
              //cout << "----MINI_TERM OK\n"; // debug
             }
          | STRING { $$.term = new PR_TERM(PR_TERM::ATOM_STRING,$1.token); }
          | numeric_constant { $$.term = new PR_TERM(PR_TERM::ATOM_NUMBER,$1.token); }
          | standard_complex_term 
          | prefix_complex_term
          | mini_term strong_infix_op mini_term
             {
              //cout << "CONSTR SIT\n    ";
              //$2.token->Output(); cout << "\n       ";
              //$1.term->Output(); cout << "\n       ";
              //$1.term->Output(); cout << "\n";
             
              $$.term = new PR_TERM($2.token,new PR_TERM_LIST($1.term,new PR_TERM_LIST($3.term)));
               
              //cout << "SIT\n    "; $$.term->Output(); cout << "\n"; // debug
             }
          | list
          | LEFT_PAR term RIGHT_PAR { $$.term = $2.term; }
          ; 

standard_complex_term : functor LEFT_PAR nonempty_term_list RIGHT_PAR 
                         {
                          $$.term = new PR_TERM($1.token,$3.term_list);
                          
                          //cout << "SCT\n    "; $$.term->Output(); cout << "\n"; // debug
                          
                         };

prefix_complex_term : prefix_op mini_term 
                       {
                        $$.term = new PR_TERM($1.token,new PR_TERM_LIST($2.term));
                        
                        //cout << "PCT\n    "; $$.term->Output(); cout << "\n"; // debug
                       };
          
list : LEFT_BR term_list RIGHT_BR 
        {
         $$.term = new PR_TERM($2.term_list);
         //cout << "LST\n    "; $$.term->Output(); cout << "\n"; // debug
        } ;

term_list : nonempty_term_list 
          | /* empty */ { $$.term_list = (PR_TERM_LIST*)0; }
          ;

/*******************************************************************************/
      
predicate : NONNUMERIC_FUNCTOR ;

functor : NONNUMERIC_FUNCTOR ;

prefix_op : minus_minus
          | plus_plus
          | negation
          | exclamation
          | question
          ;                 

infix_op : or
         | and
         | impl
         | rev_impl
         | equivalence
         | non_equivalence
         | nor
         | nand
         ;

strong_infix_op : colon ;

variable : VAR_ID ;

numeric_constant : NUMERIC_CONSTANT ;

minus_minus : MINUS MINUS { $$.token = CreateToken("--",$1.coord); };
plus_plus : PLUS PLUS { $$.token = CreateToken("++",$1.coord); };
negation : NEGATION { $$.token = CreateToken("~",$1.coord); };
exclamation : EXCLAMATION { $$.token = CreateToken("!",$1.coord); };
question : QUESTION { $$.token = CreateToken("?",$1.coord); };

colon : COLON { $$.token = CreateToken(":",$1.coord); };
or : OR { $$.token = CreateToken("|",$1.coord); };
and : AND { $$.token = CreateToken("&",$1.coord); };
impl : Equal Greater { $$.token = CreateToken("=>",$1.coord); };
rev_impl : Less Equal { $$.token = CreateToken("<=",$1.coord); };
equivalence : Less Equal Greater { $$.token = CreateToken("<=>",$1.coord); } ;
non_equivalence : Less NEGATION Greater { $$.token = CreateToken("<~>",$1.coord); };
nor : NEGATION OR { $$.token = CreateToken("~|",$1.coord); };
nand : NEGATION AND { $$.token = CreateToken("~&",$1.coord); };


/*******************************************************************************/      
      
      
      
      
      
      
      
      
      
      
      