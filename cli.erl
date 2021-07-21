%%% -------------------------------------------------------------------
%%% @author  : JoqErlang
%%% @version "1.0.0" 
%%% @since 2021-07-20
%%% @doc: Interface description for cli
%%% @copyright : JoqErlang 
%%% -------------------------------------------------------------------
-module(cli).   

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
-define(SERVER,cli_server).
%% --------------------------------------------------------------------

-export([
	 where_is_monitor/0,
	 monitor/1,
	 print/2,
	 ping/0
	]).

-export([start/0,
	 stop/0
	]).


%% ====================================================================
%% External functions
%% ====================================================================

%% Asynchrounus Signals

%% Gen server functions

start()-> gen_server:start_link({local, ?SERVER}, ?SERVER, [], []).
stop()-> gen_server:call(?SERVER, {stop},infinity).


%%---------------------------------------------------------------



%%---------------------------------------------------------------
-spec where_is_monitor()-> node()|atom().
%% 
%% @doc:check on which node the monitor is
%% @param: non
%% @returns: node | undefined
%%
where_is_monitor()->
    gen_server:call(?SERVER, {where_is_monitor},infinity).  

%%---------------------------------------------------------------
-spec monitor(Node::node())-> atom().
%% 
%% @doc:sets which nodes where monitor is running
%% @param: Node node where tha monitor is running
%% @returns: ok

monitor(Node)->    
    gen_server:call(?SERVER, {monitor,Node},infinity).    

%%---------------------------------------------------------------
-spec ping()-> {atom(),node(),module()}|{atom(),term()}.
%% 
%% @doc:check if service is running
%% @param: non
%% @returns:{pong,node,module}|{badrpc,Reason}
%%
ping()-> 
    gen_server:call(?SERVER, {ping},infinity).

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

%%----------------------------------------------------------------------
