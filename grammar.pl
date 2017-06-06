% get_formatted
get_formatted(FileName, Formatted):-
  consult('tokenize_file.pl'),
  main(FileName, Tokens),
  consult('lexer.pl'),
  lexerFile(FileName, LexedList),
  parse_list(LexedList, StructuredList),
  % print(LexedList),nl,
  format(Tokens, StructuredList, Formatted, []).

% parse_list( LexedList, StructuredList )

parse_list(LexedList, StructuredList):-
  phrase(program(StructuredList), LexedList,[]).

% format(OriginTokenList, ParsedTokenList, FormattedTokenList, RemainList).
% note: u have to add '' to ( and ) in the 'format' predicate, which shows in
% Parser_Output_Final.txt
format(OriginTokenList, [], [], OriginTokenList).
format(OriginTokenList, [Head1|ParsedTokenList], [Head2|FormattedTokenList], RemainList) :-
	is_list(Head1),
	format(OriginTokenList, Head1, Head2, Remain1),
	format(Remain1, ParsedTokenList, FormattedTokenList, RemainList).
format([Head|OriginTokenList], [_|ParsedTokenList], [Head|FormattedTokenList], RemainList) :-
	format(OriginTokenList, ParsedTokenList, FormattedTokenList, RemainList).

program(X) --> functionList(X).
functionList([X, Y]) -->
  func(X), functionListCollection(Y).
functionListCollection(X) -->
  functionList(X).
functionListCollection([]) --> [].
func([X, '(', Y, ')', '=', Z]) -->
  typeID(X), ['OPEN_P'], typeIDList(Y), ['CLOSE_P'], ['ASSIGN'], expression(Z).
typeID(['int', 'id']) -->
  ['TYPE_INT', 'IDENTIFIER'].
typeID(['bool', 'id']) -->
  ['TYPE_BOOL', 'IDENTIFIER'].
typeIDList([X|Y]) -->
  typeID(X), typeIDListCollection(Y).
typeIDListCollection([','|X]) -->
  ['COMMA'], typeIDList(X).
typeIDListCollection([]) --> [].
expression(['if', X, 'then', Y, 'else', Z]) -->
  ['COND_IF'], comparison(X), ['COND_THEN'], value(Y), ['COND_ELSE'], value(Z).
expression(['let', 'id', '=', X, 'in', Y]) -->
  ['LET'], ['IDENTIFIER'], ['ASSIGN'], value(X), ['LET_IN'], value(Y).
expression([X, Y]) --> value(X), extraExpression(Y).
extraExpression(X) --> arithmetic(X).
extraExpression([]) --> [].
arithmetic(['+', X]) --> ['ARITH_ADD'], value(X).
arithmetic(['-', X]) --> ['ARITH_SUB'], value(X).
comparison([X, Y]) --> value(X), comparisonRight(Y).
comparisonRight(['==', X]) -->
  ['LOGIC_EQ'], value(X).
comparisonRight(['!=', X]) -->
  ['LOGIC_NOT_EQ'], value(X).
comparisonRight(['>', X]) -->
  ['LOGIC_GT'], value(X).
comparisonRight(['>=', X]) -->
  ['LOGIC_GTEQ'], value(X).
value('num') --> ['INTEGER'].
value(['id', X]) -->
  ['IDENTIFIER'], valueParameters(X).
valueParameters(['(', X, ')']) -->
  ['OPEN_P'], parameters(X), ['CLOSE_P'].
valueParameters([]) --> [].
parameters([X, Y]) --> value(X), parametersList(Y).
parametersList([',', X]) -->
  ['COMMA'], parameters(X).
parametersList([]) --> [].
