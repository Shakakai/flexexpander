package com.shakakai.helloworld.generated {

	
	import com.shakakai.commands.MainCommand;
	
	import com.shakakai.mediators.MainMediator;
	
	import com.shakakai.service.TwitterService;
	
	import com.shakakai.helloworld.generated.*;
	
	import com.shakakai.helloworld.generated.interfaces.*;
	
	
	
	
	
	public class View implements  com.shakakai.helloworld.generated.interfaces.ITwitterService ,  com.shakakai.helloworld.generated.interfaces.ITwitterResultListener   {
	
		

	function View( cont:Container ){
		_container = cont;
	}

	
		
		private var _mainMediator:com.shakakai.helloworld.generated.interfaces.IMediator;
		
		public function register_mainMediator( view:Object ):void{
			if( _mainMediator == null ){
				_mainMediator = this._container.mainMediator as com.shakakai.helloworld.generated.interfaces.IMediator;
				_mainMediator.view = view;
				_mainMediator.register();
			}
		}
		
		public function unregister_mainMediator():void{
			if( _mainMediator != null ){
				_mainMediator.unregister();
				_mainMediator.view = null;
				_mainMediator = null;
			}
		}
		
	



		
		///
		/// Implemented Interfaces
		///

		
		 	/// Implement ITwitterService
			
			
				
				public function getUpdate(  artistName : String   ) : void {
					
					

					
						
						if( this._mainMediator != null && this._mainMediator is ITwitterService){
							ITwitterService(this._mainMediator).getUpdate( artistName  );
						}
						
					


					
				}
			
			
		
		 	/// Implement ITwitterResultListener
			
			
				
				public function onTwitterUpdate(  result : String   ) : void {
					
					

					
						
						if( this._mainMediator != null && this._mainMediator is ITwitterResultListener){
							ITwitterResultListener(this._mainMediator).onTwitterUpdate( result  );
						}
						
					


					
				}
			
			
		
		
		protected var _container:Container;
		
		public function get container():Container
		{
			return _container;
		}
		
	}



}