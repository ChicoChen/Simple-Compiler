main(FileName, FinalTokens) :-
  set_prolog_flag(answer_write_options, [max_depth(0)]),
  open(FileName, read, In),
  readF(In, Temp1),
  replace(9, 32, Temp1, Temp2),
  replace(10, 32, Temp2, Temp3),
  replace(11, 32, Temp3, Temp4),
  replace(13, 32, Temp4, Temp5),
  replace(3, 32, Temp5, Tokens0),
  removeRepeatSpace(Tokens0, Tokens1),
  removeFirstSpace(Tokens1, Tokens2),
  removeLastSpace(Tokens2, Tokens),
  atom_codes(To, Tokens),
  atomic_list_concat(FinalTokens,' ',To),
  close(In),!.

readF(In, []) :-
  at_end_of_stream(In), !.
readF(In, [X|L]) :-
  \+ at_end_of_stream(In),
  get0(In, X),
  readF(In, L),!.

removeRepeatSpace([], []).
removeRepeatSpace([L], [L]).
removeRepeatSpace([S,S|T], [S|NT]) :-
  S is 32,
  removeRepeatSpace([S|T], [S|NT]).
removeRepeatSpace([X, Y|T], [X, Y|NT]) :-
  removeRepeatSpace([Y|T], [Y|NT]).

removeFirstSpace([H|T],T) :-
  H is 32.
removeFirstSpace([H|T],[H|T]) :-
  not(H is 32).

removeLastSpace(List, RemList):-
  reverse(List, RvsdList),
  removeFirstSpace(RvsdList, NewList),
  reverse(NewList, RemList).

replace(_,_,[],[]).
replace(X,Y,[X|OldRes],[Y|NewRes]) :-
  replace(X,Y,OldRes,NewRes).
replace(X,Y,[W|OldRes],[W|NewRes]) :-
  dif(X,W),
  replace(X,Y,OldRes,NewRes).
