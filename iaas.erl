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
%%---------------------------------------------------------------
-spec create_cluster(ClusterId::string())-> atom().
%% 
%% @doc:creates a cluster 
%% @param: Cluster id 
%% @returns: ok or {error,[Err]}

create_cluster(ClusterId)->
    gen_server:call(?SERVER, {create_cluster,ClusterId},infinity).
status_all_clusters()->
    gen_server:call(?SERVER, {status_all_clusters},infinity).
running_clusters()->
    gen_server:call(?SERVER, {running_clusters},infinity).
missing_clusters()->
    gen_server:call(?SERVER, {not_available_clusters},infinity).
status_cluster(ClusterId)->
    gen_server:call(?SERVER, {status_cluster,ClusterId},infinity).


cluster_strive_desired_state(ClusterStatus)->
    gen_server:cast(?SERVER, {cluster_strive_desired_state,ClusterStatus}).


%%------------------ Hosts --------------------------------------
%%---------------------------------------------------------------
status_all_hosts()->
    gen_server:call(?SERVER, {status_all_hosts},infinity).
running_hosts()->
    gen_server:call(?SERVER, {running_hosts},infinity).
missing_hosts()->
    gen_server:call(?SERVER, {missing_hosts},infinity).
status_host(HostId)->
    gen_server:call(?SERVER, {status_host,HostId},infinity).


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
