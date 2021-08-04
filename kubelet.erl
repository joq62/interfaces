%%% -------------------------------------------------------------------
%%% @author  : JoqErlang
%%% @version "1.0.0" 
%%% @since 2021-07-20
%%% @doc: logger support for joqs infrastructure
%%% @copyright : JoqErlang 
%%% -------------------------------------------------------------------
-module(kubelet).   

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
-define(SERVER,kubelet_server).
%% --------------------------------------------------------------------
-export([
	 log_msg/1,
	 print/1,
	 print_type/1,
	 add_monitor/1,
	 create_pod/1,
	 delete_pod/1,
	 get_pods/0,
	 get_state/0,
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
-spec add_monitor(Node::node())-> atom().
%% 
%% @doc:sets which nodes where monitor is running
%% @param: Node node where tha monitor is running
%% @returns: ok

add_monitor(Node)-> 
    gen_server:call(?SERVER, {add_monitor,Node},infinity).

%%-----------------------------------------------------------------------
-spec log_msg({Date::term(),Time::term(),Node::atom(),Type::string(),Msg::string(),InfoList::term()})-> atom().
%% 
%% @doc:sends a log message to logger
%% @param: Type=log|ticket|alert, Msg= Message in tex, InfoList=[info items])
%% @returns: ok
log_msg({Date,Time,Node,Type,Msg,InfoList})->
    gen_server:cast(kube_logger_server, {log_msg,{Date,Time,Node,Type,Msg,InfoList}}).

print({Date,Time,Node,Type,Msg,InfoList})->
    gen_server:cast(?SERVER, {log_msg,{Date,Time,Node,Type,Msg,InfoList}}).

print_type(Type)->
    gen_server:cast(?SERVER, {print_type,Type}).

-spec get_pods()-> term().
%% 
%% @doc:reads active pods 
%% @param: no
%% @returns: [PodId]

get_pods()->
    gen_server:call(?SERVER, {get_pods},infinity).

create_pod(PodId)->
    gen_server:call(?SERVER, {create_pod,PodId},infinity).
delete_pod(PodId)->
    gen_server:call(?SERVER, {delete_pod,PodId},infinity).
    
get_state()->
    gen_server:call(?SERVER, {get_state},infinity).


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
