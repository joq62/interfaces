%%% -------------------------------------------------------------------
%%% @author  : JoqErlang
%%% @version "1.0.0" 
%%% @since 2021-07-20
%%% @doc: logger support for joqs infrastructure
%%% @copyright : JoqErlang 
%%% -------------------------------------------------------------------
-module(iaas).   

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
-define(SERVER,iaas_server).
%% --------------------------------------------------------------------
-export([
	 cluster_strive_desired_state/1,
	 status_all_clusters/0,

	 status_all_hosts/0,
	 status_hosts/1,
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


%%-----------------Cluster---------------------------------------

status_all_clusters()->
    gen_server:call(?SERVER, {status_all_clusters},infinity).

cluster_strive_desired_state(ClusterStatus)->
    gen_server:cast(?SERVER, {cluster_strive_desired_state,ClusterStatus}).


%%------------------ Hosts --------------------------------------
%%---------------------------------------------------------------
status_all_hosts()->
    gen_server:call(?SERVER, {status_all_hosts},infinity).

status_hosts(HostsStatus)->
    gen_server:cast(?SERVER, {status_hosts,HostsStatus}).


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
