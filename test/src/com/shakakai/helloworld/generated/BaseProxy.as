package com.shakakai.helloworld.generated {

	
	import com.shakakai.commands.MainCommand;
	
	import com.shakakai.mediators.MainMediator;
	
	import com.shakakai.service.TwitterService;
	
	import com.shakakai.helloworld.generated.*;
	
	import com.shakakai.helloworld.generated.interfaces.*;
	
	
	
	
	
	
	public class BaseProxy implements com.shakakai.helloworld.generated.interfaces.IProxy{
	
		function BaseProxy(){
		
		}
	
		
		public function register():void
		{
		
		}
		
		public function unregister():void
		{
		
		}
		
		
		private var _facade:Facade;
		
		public function get facade():Facade
		{
			return _facade;
		}
		
		public function set facade( value:Facade ):void
		{
			_facade = value;
		}
		
	}


}