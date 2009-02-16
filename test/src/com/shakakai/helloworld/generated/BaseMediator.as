package com.shakakai.helloworld.generated {

	
	import com.shakakai.commands.MainCommand;
	
	import com.shakakai.mediators.MainMediator;
	
	import com.shakakai.service.TwitterService;
	
	import com.shakakai.helloworld.generated.*;
	
	import com.shakakai.helloworld.generated.interfaces.*;
	
	
	
	
	
	
	public class BaseMediator implements com.shakakai.helloworld.generated.interfaces.IMediator{
	
		function BaseMediator(){
		
		}
		
		public function register():void
		{
		
		}
		
		public function unregister():void
		{
		
		}
		
		
		
		private var _view:Object;
		
		public function set view( value:Object ):void
		{
			_view = value;
		}
		
		public function get view():Object
		{
			return _view;
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