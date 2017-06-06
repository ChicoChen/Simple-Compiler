:- use_module(library(assoc)).

create_empty_table:-
  empty_assoc(List),
  b_setval('Map', List).

initialize_function([[]]).
initialize_function([[[ReturnType, FunctionName], '(', ParameterList, ')', '=', CodeBody]|RestFunctions]):-
  add_symbol_list([FunctionName, FunctionName, FunctionName], [CodeBody, ParameterList, ReturnType]),
  initialize_function(RestFunctions).

add_symbol(Key, Value):-
  b_getval('Map', List),
  (
  get_assoc(Key, List, OldValue)
    -> NVs = [Value|OldValue];
  NVs = [Value]
  ),
  put_assoc(Key, List, NVs, NewList),
  b_setval('Map', NewList).

add_symbol_list([],[]).
add_symbol_list([HKey|RestKey], [HValue|RestValue]):-
  add_symbol(HKey, HValue),
  add_symbol_list(RestKey, RestValue).

% get_symbol(Key,ValueList).
get_symbol(Key, Value):-
  b_getval('Map', List),
  get_assoc(Key, List, [Value|_]).

get_FuncInfo(Key, Value):-
  b_getval('Map', List),
  get_assoc(Key, List, Value).

remove_symbol(Key) :-
  b_getval('Map', List),
  (
    get_assoc(Key, List, [_|T])
      -> put_assoc(Key, List, T, NewList);
    NewList = List
  ),
  b_setval('Map', NewList).
