
% this is for test
% add_to_tree(Formatted):-
%   consult('grammar.pl'),
%   get_formatted(Formatted),
%   consult('symbol_table.pl'),
%   create_empty_table,
%   initialize_function(Formatted).
  % print(Formatted).

% giving Formatted list and ArgumentList to give out Result
% create_empty_table -> add source files' functions
% get Result
interpreter(Formatted, ArgumentList, Result) :-
  consult('symbol_table.pl'),
  create_empty_table,
  initialize_function(Formatted),
  eval_func('main', ArgumentList, Result), !.


eval_func(FunctionName, ArgumentList, Result) :-
  % get functions information
  get_FuncInfo(FunctionName, [ReturnType, ParameterList, CodeBody]),
  % check type if matched
  check_type_matched(ParameterList, ArgumentList),
  expressionHandler(CodeBody, ReturnType, Result).

check_type_matched([], _):- !.
check_type_matched([[]], _):- !.
check_type_matched([ParaH|ParaT], [ArgH|ArgT]) :-
  check_insert(ParaH, ArgH), check_type_matched(ParaT, ArgT).

check_insert([Type, Val], Arg) :-
  check_type(Type, Arg), add_symbol(Val, Arg).

check_type(Type, Arg):-
  (Type = 'bool', (Arg = 1; Arg = 0));
  (Type = 'int' , integer(Arg)).


expressionHandler([[H|_], ExtraExpression], ReturnType, Result):-
  valueHandler(H, ValueResult),
  extraExpressionHandler(ExtraExpression, ExtraResult),
  evaluate(ValueResult, ExtraResult, Result),
  check_type(ReturnType, Result), remove_symbol(H).

valueHandler(H, ValueResult):-
  get_symbol(H, ValueResult).

extraExpressionHandler(ExtraExpression, ExtraResult):-
  ExtraResult = ExtraExpression.

evaluate(Value, [], Result) :-
  Result is Value.

evaluate(Value1, [ '+', Value2 ], Result ) :-
  (
  integer(Value2)
    ->Result is Value1 + Value2;
	atom_number(Value2,V2),
  Result is Value1 + V2
  ).

evaluate(Value1, [ '*', Value2 ], Result ) :-
  (
  integer(Value2)
    -> Result is Value1 * Value2;
	atom_number(Value2,V2),
  Result is Value1 * V2
  ).
