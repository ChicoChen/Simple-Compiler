run_program(FileName, ArgumentList, Result) :-
  consult('grammar.pl'),
  consult('interpreter.pl'),
	get_formatted(FileName, Formatted),
  interpreter(Formatted, ArgumentList, Result).
