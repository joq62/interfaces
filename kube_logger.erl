%%% -------------------------------------------------------------------
%%% @author  : JoqErlang
%%% @version "1.0.0" 
%%% @since 2021-07-20
%%% @doc: logger support for joqs infrastructure
%%% @copyright : JoqErlang 
%%% -------------------------------------------------------------------
-module(kube_logger).   

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
-define(SERVER,kube_logger_server).
%% --------------------------------------------------------------------
-export([
	 log_msg/1,

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

%%-----------------------------------------------------------------------
-spec log_msg({Date::term(),Time::term(),Node::atom(),Type::string(),Msg::string(),InfoList::term()})-> atom().
%% 
%% @doc:sends a log message to logger
%% @param: Type=log|ticket|alert, Msg= Message in tex, InfoList=[info items])
%% @returns: ok
log_msg({Date,Time,Node,Type,Msg,InfoList})->
    gen_server:cast(?SERVER, {log_msg,{Date,Time,Node,Type,Msg,InfoList}}).


%%-----------------------------------------------------------------------

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
