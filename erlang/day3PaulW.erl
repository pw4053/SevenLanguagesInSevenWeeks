%% ---
%%  Excerpted from "Seven Languages in Seven Weeks",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/btlang for more book information.
%%---
-module(day3PaulW).
-behaviour(gen_server).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start/0, checkout/2, lookup/1, return/1]).


%% -export([loop/0, translate/2]).
%% loop() ->
%% 
%%     receive
%%         {From, "casa"} -> 
%%             From ! "house", 
%%             loop();
%%         
%%        {From, "blanca"} -> 
%%            From ! "white", 
%%            loop();
%%        
%%        {From, _} -> 
%%            From ! "I don't understand.", 
%%            loop()       
%% end.
%%
%% translate(To, Word) ->
%%    To ! {self(), Word}, 
%%   receive
%%        Translation -> Translation
%%    end.
%%
%% Translator = spawn(fun day3PaulW:loop/0).
%% day3PaulW:translate(Translator, "blanca").
%% day3PaulW:translate(Translator, "casa").




%% --------------
%%  SUPERVISORS
%% This section introduces a process structuring model for programming fault tolerant applications. The model is based on the idea of workers, supervisors, and a supervision tree. 
%% 
%% Workers are processes which perform computations.
%% Supervisors are processes which monitor the behaviour of workers. A supervisor can restart a worker if something goes wrong.
%% The supervision tree is a hierarchical arrangement of an application into workers and supervisors.
%% A supervisor can supervise either workers or supervisors. Hereafter we will use the term child to mean either a worker or a supervisor. 
%% 
%% Supervision trees can be manipulated by using the functions exported from the module supervisor. 

%% --------------

% These are all wrappers for calls to the server
start() -> gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).
checkout(Who, Book) -> gen_server:call(?MODULE, {checkout, Who, Book}).	
lookup(Book) -> gen_server:call(?MODULE, {lookup, Book}).
return(Book) -> gen_server:call(?MODULE, {return, Book}).

% This is called when a connection is made to the server
init([]) ->
	Library = dict:new(),
	{ok, Library}.

% handle_call is invoked in response to gen_server:call
handle_call({checkout, Who, Book}, _From, Library) ->
	Response = case dict:is_key(Book, Library) of
		true ->
			NewLibrary = Library,
			{already_checked_out, Book};
		false ->
			NewLibrary = dict:append(Book, Who, Library),
			ok
	end,
	{reply, Response, NewLibrary};

handle_call({lookup, Book}, _From, Library) ->
	Response = case dict:is_key(Book, Library) of
		true ->
			{who, lists:nth(1, dict:fetch(Book, Library))};
		false ->
			{not_checked_out, Book}
	end,
	{reply, Response, Library};

handle_call({return, Book}, _From, Library) ->
	NewLibrary = dict:erase(Book, Library),
	{reply, ok, NewLibrary};

handle_call(_Message, _From, Library) ->
	{reply, error, Library}.

% We get compile warnings from gen_server unless we define these
handle_cast(_Message, Library) -> {noreply, Library}.
handle_info(_Message, Library) -> {noreply, Library}.
terminate(_Reason, _Library) -> ok.
code_change(_OldVersion, Library, _Extra) -> {ok, Library}.


%% day3PaulW:start().
%% day3PaulW:checkout(jesse, "Australian Dreams").
%% day3PaulW:lookup("Australian Dreams").
%% day3PaulW:checkout(jojo, "Australian Dreams").
%% day3PaulW:return("Australian Dreams").
%% day3PaulW:checkout(jojo, "Australian Dreams").
%% day3PaulW:lookup("Australian Dreams").


