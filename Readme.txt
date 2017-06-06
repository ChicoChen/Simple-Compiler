1. To test tokenize_file.pl:
    read file in prolog, input
      main('test.txt', Tokens).
    the result should be
      Tokens = [int,main,(,int,input,),=,input,+,3].

2. To test lexer.pl:
    read file in prolog, input
      lexerFile('test.txt', LexedList).
    the result should be
      LexedList = [TYPE_INT,IDENTIFIER,OPEN_P,TYPE_INT,IDENTIFIER,CLOSE_P,ASSIGN,IDENTIFIER,ARITH_ADD,INTEGER].

3. To test grammar.pl:
    read file in prolog, input
      get_formatted("test.txt", Formatted).
    the result should be
      Formatted = [[[int,main],(,[[int,input]],),=,[[input,[]],[+,3]]],[]] .

4. To test symbol_table.pl, interpreter.pl & language_executor.pl
    read file in prolog, input
      run_program("test.txt", [1], Result).
    the result should be
      Result = 4 .
