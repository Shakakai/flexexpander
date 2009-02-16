package com.shakakai.helloworld.generated {

	
	import com.shakakai.commands.MainCommand;
	
	import com.shakakai.mediators.MainMediator;
	
	import com.shakakai.service.TwitterService;
	
	import com.shakakai.helloworld.generated.*;
	
	import com.shakakai.helloworld.generated.interfaces.*;
	
	
	import flash.utils.getDefinitionByName;
	
	
	public class Container{
	
		function Container(facade:Facade){
			_facade = facade;
		}
		
		private var _facade:Facade;
		
		///
		/// Object collection
		///
		
			
			
			private var _mainCommand:com.shakakai.commands.MainCommand;
			
			
			public function get mainCommand():com.shakakai.commands.MainCommand {
				
				if( _mainCommand != null ) return _mainCommand;
				
				
				var a:com.shakakai.commands.MainCommand = new com.shakakai.commands.MainCommand();
				
					
					
						a.string1 = cast(com.shakakai.commands.MainCommand, 'string1', 'Thanks for checking this out!');
					
					
				
				
				
				_mainCommand = a;
				
				
				
				a.facade = _facade;
				
				
				return a;
			}
		
			
			
			
			public function get mainMediator():com.shakakai.mediators.MainMediator {
				
				
				var a:com.shakakai.mediators.MainMediator = new com.shakakai.mediators.MainMediator();
				
					
					
						a.mainCommand = this.mainCommand;
					
					
				
					
					
						a.title = cast(com.shakakai.mediators.MainMediator, 'title', 'Hello World!');
					
					
				
				
				
				
				
				a.facade = _facade;
				
				
				return a;
			}
		
			
			
			private var _mainService:com.shakakai.service.TwitterService;
			
			
			public function get mainService():com.shakakai.service.TwitterService {
				
				if( _mainService != null ) return _mainService;
				
				
				var a:com.shakakai.service.TwitterService = new com.shakakai.service.TwitterService();
				
					
					
						a.url = cast(com.shakakai.service.TwitterService, 'url', 'http://ws.audioscrobbler.com/2.0/?method=artist.gettopalbums&amp;artist=${artist}&amp;api_key');
					
					
				
				
				
				_mainService = a;
				
				
				
				a.facade = _facade;
				
				
				return a;
			}
		
	
		protected function cast( clz:Class, property:String, value:String ):*
						{
							var result:XML = flash.utils.describeType( clz );
							var type:String;
							var clazz:Class;

							if( result.factory.variable.(@name == property).length() > 0){
								type = result.factory.variable.(@name == property)[0].@type;
								clazz = flash.utils.getDefinitionByName(type) as Class;
								return new clazz(value);
							}
							else if( result.factory.accessor.(@name == property).length() > 0 )
							{
								type = result.factory.accessor.(@name == property)[0].@type;
								clazz = flash.utils.getDefinitionByName(type) as Class;
								return new clazz(value);
							}
							else
							{
								throw new Error("Can't find property: " + property + " :: on class: " + clz);
							}
						}
	}



}