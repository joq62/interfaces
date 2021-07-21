%%% -------------------------------------------------------------------
%%% @author  : Joq Erlang
%%% @doc: : 
%%% Created : 
%%% Pod is an erlang vm and 1-n erlang applications (containers) 
%%% Pods network id is the node name  
%%% The pod lives as long as the applications is living 
%%% In each pod there is a mnesias dbase
%%% Pod template {apiVersion, kind, metadata,[{namen,striang}]
%%%               spec,[{containers,[{name,},{image,busybox},
%%%                     {command,['erl cmd]},restart policy]
%%% storage in Pod
%%% File System:
%%%  
%%% -------------------------------------------------------------------
-module(doc_gen).   


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

%% --------------------------------------------------------------------


-export([start/0
	]).


%% ====================================================================
%% External functions
%% ====================================================================

%% Asynchrounus Signals

%% Gen server functions

start()-> 
    os:cmd("rm -rf doc/*"),
    {ok,FileNames}=file:list_dir("."),
    IfFiles=[FileName||FileName<-FileNames,
		       ".erl"==filename:extension(FileName)],
    edoc:files(IfFiles,[{dir,"doc"}]),
    io:format("~p~n",[file:list_dir("doc")]),
    init:stop().
