%%% -------------------------------------------------------------------
%%% @author  : JoqErlang
%%% @version "1.0.0" 
%%% @since 2021-07-20
%%% @doc: Interface description for cli
%%% @copyright : JoqErlang 
%%% -------------------------------------------------------------------
-module(monitor).   

%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------

%% --------------------------------------------------------------------
%% Key Data structures
%% 
%% --------------------------------------------------------------------

%% --------------------------------------------------------------------
%% Definitions 
%% --------------------------------------------------------------------
-define(SERVER,monitor_server).
%% --------------------------------------------------------------------

-export([
	 print/1,
	 print/2,
	 ping/0
	]).

-export([
	 boot/0,
	 start/0,
	 stop/0

	]).


%% ====================================================================
%% External functions
%% ====================================================================
boot()->
    monitor:start().
%% Asynchrounus Signals

%% Gen server functions

start()-> gen_server:start_link({local, ?SERVER}, ?SERVER, [], []).
stop()-> gen_server:call(?SERVER, {stop},infinity).


%%---------------------------------------------------------------
%%---------------------------------------------------------------
-spec print(Info::string())-> atom().
%% 
%% @doc:check if service is running
%% @param: Info text string with related information
%% @returns:{pong,node,module}|{badrpc,Reason}
%%
print(Info)-> 
    gen_server:cast(?SERVER, {print,Info}).

%%---------------------------------------------------------------
-spec print(Severity::atom(),Info::string())-> atom().
%% 
%% @doc:check if service is running
%% @param: Severity atom log, ticket or alert 
%% @param: Info text string with related information
%% @returns:{pong,node,module}|{badrpc,Reason}
%%
print(Severity,Info)-> 
    gen_server:cast(?SERVER, {print,Severity,Info}).

%%---------------------------------------------------------------
-spec ping()-> {atom(),node(),module()}|{atom(),term()}.
%% 
%% @doc:check if service is running
%% @param: non
%% @returns:{pong,node,module}|{badrpc,Reason}
%%
ping()-> 
    gen_server:call(?SERVER, {ping},infinity).



%%----------------------------------------------------------------------
