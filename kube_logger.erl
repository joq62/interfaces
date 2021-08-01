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
	 print_type/1,
	 add_monitor/1,
%---------------------
	 kube_log/1,
	 install_dbase/0,
	 log/1,ticket/1,alarm/1,
	 file_log/1,file_ticket/1,file_alarm/1,

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
install_dbase()->
     gen_server:call(?SERVER, {install_dbase},infinity).
    
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
    gen_server:cast(?SERVER, {log_msg,{Date,Time,Node,Type,Msg,InfoList}}).


print_type(Type)->
    gen_server:cast(?SERVER, {print_type,Type}).
%%-----------------------------------------------------------------------
kube_log(Info)->
       gen_server:cast(?SERVER, {kube_log,Info}).
 
log(LogInfo)-> 
    gen_server:cast(?SERVER, {log,LogInfo}).
ticket(TicketInfo)-> 
    gen_server:cast(?SERVER, {ticket,TicketInfo}).
alarm(AlarmInfo)-> 
    gen_server:cast(?SERVER, {alarm,AlarmInfo}).

file_log(LogInfo)-> 
    gen_server:cast(?SERVER, {file,file_log,LogInfo}).
file_ticket(TicketInfo)-> 
    gen_server:cast(?SERVER, {file,file_ticket,TicketInfo}).
file_alarm(AlarmInfo)-> 
    gen_server:cast(?SERVER, {file,file_alarm,AlarmInfo}).

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
