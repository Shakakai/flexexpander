package com.shakakai.helloworld.generated.interfaces {

	
	import com.shakakai.commands.MainCommand;
	
	import com.shakakai.mediators.MainMediator;
	
	import com.shakakai.service.TwitterService;
	
	import com.shakakai.helloworld.generated.*;
	
	import com.shakakai.helloworld.generated.interfaces.*;
	
	
	
	
	
	
	public interface IMediator{
	
		function register():void;
		function unregister():void;
		
		function set facade( value:Facade ):void;
		function get facade():Facade;
		
		function set view( value:Object ):void;
		function get view():Object;
	
	}



}