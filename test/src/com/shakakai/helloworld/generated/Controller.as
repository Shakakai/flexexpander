package com.shakakai.helloworld.generated {

	
	import com.shakakai.commands.MainCommand;
	
	import com.shakakai.mediators.MainMediator;
	
	import com.shakakai.service.TwitterService;
	
	import com.shakakai.helloworld.generated.*;
	
	import com.shakakai.helloworld.generated.interfaces.*;
	
	
	
	
	
	public class Controller implements  com.shakakai.helloworld.generated.interfaces.ITwitterService ,  com.shakakai.helloworld.generated.interfaces.ITwitterResultListener   {
	
		

	function Controller( cont:Container ){
		_container = cont;
	}
	
	
		
		private var _mainCommand:com.shakakai.helloworld.generated.interfaces.ICommand;
		
		public function register_mainCommand( ):void{
			if( _mainCommand == null ){
				_mainCommand = this._container.mainCommand as com.shakakai.helloworld.generated.interfaces.ICommand;
				_mainCommand.register();
			}
		}
		
		public function unregister_mainCommand():void{
			if( _mainCommand != null ){
				_mainCommand.unregister();
				_mainCommand = null;
			}
		}
		
	


		
		///
		/// Implemented Interfaces
		///

		
		 	/// Implement ITwitterService
			
			
				
				public function getUpdate(  artistName : String   ) : void {
					
					

					
						
						if( this._mainCommand != null && this._mainCommand is ITwitterService){
							ITwitterService(this._mainCommand).getUpdate( artistName  );
						}
						
					


					
				}
			
			
		
		 	/// Implement ITwitterResultListener
			
			
				
				public function onTwitterUpdate(  result : String   ) : void {
					
					

					
						
						if( this._mainCommand != null && this._mainCommand is ITwitterResultListener){
							ITwitterResultListener(this._mainCommand).onTwitterUpdate( result  );
						}
						
					


					
				}
			
			
		
		
		protected var _container:Container;
		
		public function get container():Container
		{
			return _container;
		}
		
	}



}