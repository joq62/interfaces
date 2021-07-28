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
