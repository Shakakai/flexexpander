package com.shakakai.helloworld.generated {

	
	import com.shakakai.commands.MainCommand;
	
	import com.shakakai.mediators.MainMediator;
	
	import com.shakakai.service.TwitterService;
	
	import com.shakakai.helloworld.generated.*;
	
	import com.shakakai.helloworld.generated.interfaces.*;
	
	
	
	
	
	public class Facade implements  com.shakakai.helloworld.generated.interfaces.ITwitterService ,  com.shakakai.helloworld.generated.interfaces.ITwitterResultListener   {
	
		

		function Facade(){
			_container = new Container(this);
			_controller = new Controller(_container);
			_proxy = new Proxy(_container);
			_view = new View(_container);
		}
		
		protected var _controller:Controller;
		protected var _proxy:Proxy;
		protected var _view:View;
		
		///
		/// Helper methods
		///
		
		public function get controller():Controller
		{
			return _controller;
		}
		
		public function get view():View
		{
			return _view;
		}
		
		public function get proxy():Proxy
		{
			return _proxy;
		}
		

		
		///
		/// Implemented Interfaces
		///

		
		 	/// Implement ITwitterService
			
			
				
				public function getUpdate(  artistName : String   ) : void {
					
					
_controller.getUpdate( artistName  );
_proxy.getUpdate( artistName  );
_view.getUpdate( artistName  );

					
				}
			
			
		
		 	/// Implement ITwitterResultListener
			
			
				
				public function onTwitterUpdate(  result : String   ) : void {
					
					
_controller.onTwitterUpdate( result  );
_proxy.onTwitterUpdate( result  );
_view.onTwitterUpdate( result  );

					
				}
			
			
		
		
		protected var _container:Container;
		
		public function get container():Container
		{
			return _container;
		}
		
	}



}