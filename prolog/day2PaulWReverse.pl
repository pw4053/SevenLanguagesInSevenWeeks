
rev([], []).
rev([Head|[]], [Head]).
rev([Head|Tail], Answer) :-
  rev(Tail, What),
  append(What, [Head], Answer).

