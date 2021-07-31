%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Description : dbase using dets 
%%% 
%%% Created : 10 dec 2012 
%%% -------------------------------------------------------------------
-define(PrintLog(Type,Msg,InfoList),
	io:format("~s: ~w, ~s, ~p, ~n",
		  [misc_fun:date_time(),Type,Msg,InfoList]),
	rpc:cast(node(),kube_logger,log_msg,[{date(),time(),node(),Type,Msg,InfoList}])
       ).
-record(kube_logger,
	{
	 id,
	 status,
	 severity,
	 date,
	 time,
	 node,
	 application,
	 module,
	 function_name,
	 line,
	 info
	}).

-define(Logger(Info),[{date,date()},{time,time()},
		      {module,?MODULE},
		      {function_name,?FUNCTION_NAME},
		      {line,?LINE},
		      {node,node()},
		      {info,Info}]).
-define(KubeLog(Severity,Info),
	{
	 Severity,
	 date(),
	 time(),
	 node(),
	 application:get_application(?MODULE),
	 ?MODULE,
	 ?FUNCTION_NAME,
	 ?LINE,
	 Info}).
