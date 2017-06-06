lexerFile(FileName, LexedList) :-
  consult('tokenize_file.pl'),
  main(FileName, TokenedList),
  lexer(TokenedList, LexedList).


% set value to something
set(V, V).

% lexer(TokenList, LexedList).
lexer([],[]).

% TYPE_INT
lexer([Atom|T], [Token|Res]) :-
  (
  Atom == 'int',
  set(Token, 'TYPE_INT');
  Atom == 'bool',
  set(Token, 'TYPE_BOOL');
  Atom == ',',
  set(Token, 'COMMA');
  Atom == '==',
  set(Token, 'LOGIC_EQ');
  Atom == '!=',
  set(Token, 'LOGIC_NOT_EQ');
  Atom == '=',
  set(Token, 'ASSIGN');
  Atom == 'let',
  set(Token, 'LET');
  Atom == 'in',
  set(Token, 'LET_IN');
  Atom == 'if',
  set(Token, 'COND_IF');
  Atom == 'then',
  set(Token, 'COND_THEN');
  Atom == 'else',
  set(Token, 'COND_ELSE');
  Atom == '>=',
  set(Token, 'LOGIC_GTEQ');
  Atom == '>',
  set(Token, 'LOGIC_GT');
  Atom == '+',
  set(Token, 'ARITH_ADD');
  Atom == '-',
  set(Token, 'ARITH_SUB');
  Atom == '(',
  set(Token, 'OPEN_P');
  Atom == ')',
  set(Token, 'CLOSE_P');
  atom_number(Atom, NewAtom),
  number(NewAtom),
  set(Token, 'INTEGER');
  set(Token, 'IDENTIFIER')
  )
  ->lexer(T,Res).
