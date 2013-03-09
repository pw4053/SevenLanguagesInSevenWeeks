%% ---------------------------------------------------------------------------
%% Day Two
%% ---------------------------------------------------------------------------
-module(day2PaulW).
-export([getKeywordValue/2]).


%% ---------------------------------------------------------------------------
%% Write a function that accepts the list and a keyword and returns the
%% associated value for the keyword.

getKeywordValue(List, Key) ->
      [{ MatchKey, MatchVal} | _ ] = lists:filter(fun({K, V}) -> K == Key end, List),  MatchVal.

%% day2PaulW:getKeywordValue([{erlang, "a functional language"},{ruby, "an OO language"}], erlang).

%% --------------------------------------------------------------------------
%% Consider a shopping list that looks like [{item, quantity, price}, ...].
%% Write a list comprehension that builds a list of items of the form
%% [{item, total_price},...], where total_price is quantity times price.

Cart = [{pencil, 4, 0.25}, {pen, 1, 1.20}, {paper, 2, 0.20}].
TotalPrice = [{Product, Quantity * Price} || {Product, Quantity, Price} <- Cart].

%% --------------------------------------------------------------------------

%% winning combinations
%% rows
isBoardWon( {X,X,X,_,_,_,_,_,_}, X ) -> true;
isBoardWon( {_,_,_,X,X,X,_,_,_}, X ) -> true;
isBoardWon( {_,_,_,_,_,_,X,X,X}, X ) -> true;
% columns
isBoardWon( {X,_,_,X,_,_,X,_,_}, X ) -> true;
isBoardWon( {_,X,_,_,X,_,_,X,_}, X ) -> true;
isBoardWon( {_,_,X,_,_,X,_,_,X}, X ) -> true;
% diagonals
isBoardWon( {X,_,_,_,X,_,_,_,X}, X ) -> true;
isBoardWon( {_,_,X,_,X,_,X,_,_}, X ) -> true;
%% no winner
isBoardWon( {_,_,_,_,_,_,_,_,_}, _ ) -> false.

play() ->
   Board = [{X,X,X,_,_,_,_,_,_}];
   case isBoardWon(Board, O) of
      true  -> io:format("Player O has won~n:);
      false ->
           case isBoardWon(Board, X) of
              true   -> io:format("Player X has won~n);
              false -> io:format("Don;t know~n");
           end
   end.

%% play().

