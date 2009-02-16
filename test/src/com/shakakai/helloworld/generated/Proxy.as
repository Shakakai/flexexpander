package com.shakakai.helloworld.generated {

	
	import com.shakakai.commands.MainCommand;
	
	import com.shakakai.mediators.MainMediator;
	
	import com.shakakai.service.TwitterService;
	
	import com.shakakai.helloworld.generated.*;
	
	import com.shakakai.helloworld.generated.interfaces.*;
	
	
	
	
	
	public class Proxy implements  com.shakakai.helloworld.generated.interfaces.ITwitterService ,  com.shakakai.helloworld.generated.interfaces.ITwitterResultListener   {
	
		

	function Proxy( cont:Container ){
		_container = cont;
	}

	
		
		private var _mainProxy:com.shakakai.helloworld.generated.interfaces.IProxy;
		
		public function register_mainProxy( ):void{
			if( _mainProxy == null ){
				_mainProxy = this._container.mainService as com.shakakai.helloworld.generated.interfaces.IProxy;
				_mainProxy.register();
			}
		}
		
		public function unregister_mainProxy():void{
			if( _mainProxy != null ){
				_mainProxy.unregister();
				_mainProxy = null;
			}
		}
		
	


		
		///
		/// Implemented Interfaces
		///

		
		 	/// Implement ITwitterService
			
			
				
				public function getUpdate(  artistName : String   ) : void {
					
					

					
						
						if( this._mainProxy != null && this._mainProxy is ITwitterService){
							ITwitterService(this._mainProxy).getUpdate( artistName  );
						}
						
					


					
				}
			
			
		
		 	/// Implement ITwitterResultListener
			
			
				
				public function onTwitterUpdate(  result : String   ) : void {
					
					

					
						
						if( this._mainProxy != null && this._mainProxy is ITwitterResultListener){
							ITwitterResultListener(this._mainProxy).onTwitterUpdate( result  );
						}
						
					


					
				}
			
			
		
		
		protected var _container:Container;
		
		public function get container():Container
		{
			return _container;
		}
		
	}



}