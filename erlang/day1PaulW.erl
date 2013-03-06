%% --------------------------------------------------------------------------------------
-module(day1PaulW).
-export([countWordsInSentence/1]).
-export([countTo/2]).
-export([printMessage/1]).

%% --------------------------------------------------------------------------------------
%%
%% The Erlang language. official site
%%       http://www.erlang.org/
%%
%% Official documentation for Erlang. function library
%%       http://www.erlang.org/doc/apps/stdlib/index.html
%%
%% The documentation for Erlang. OTP library
%%       http://www.erlang.org/doc/
%%


%% --------------------------------------------------------------------------------------
%% Write a function that uses recursion to return the number of words in a string.

countWordsinList([]) ->0;
countWordsinList(Words) -> 
    [_|T] = Words,
    countWordsinList(T) + 1.

countWordsInSentence(Sentence) -> io:format("~p~n", [countWordsinList(string:tokens(Sentence, " "))]).

%% day1PaulW:countWordsInSentence("A cat sat on the hat").

%% --------------------------------------------------------------------------------------
%% Write a function that uses recursion to count to ten.

countTo(N,Max) when N < Max ->
     io:format("~p~n", [N]), 
     countTo(N+1, Max).

%% day1PaulW:countTo(1,10).

%% --------------------------------------------------------------------------------------
%% Write a function that uses matching to selectively print .uccess.or .rror: message.
%% given input of the form {error, Message} or success.


printMessage(success) -> "success";
printMessage({error, Message}) -> "error: " ++ Message. 


%% day1PaulW:printMessage(success).
%% day1PaulW:printMessage({error, "broken"}).


