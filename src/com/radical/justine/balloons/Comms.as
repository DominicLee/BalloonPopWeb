package com.radical.justine.balloons 
{
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import com.demonsters.debugger.MonsterDebugger;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import flash.external.ExternalInterface;
	import com.adobe.serialization.json.JSON;
	 
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class Comms extends EventDispatcher
	{
		
		private static var _root:MovieClip;
		private static var _comms:Comms;
		private var entrantPostURL:String;
		private var scorePostURL:String;
		
		public function Comms()
        {
            trace("loading....");
        }
		
		public static function init(_target:MovieClip) {
			_root = _target;
		}
		
		public static function getInstance () :Comms
        {
            if (_comms == null)
                _comms = new Comms();
            
            return _comms;
        }
		
		// Register User Code
		
		public static function registerUser() {

			var scriptRequest:URLRequest = new URLRequest("http://dev.justine-40years.co.za/wwdjsq33");
			scriptRequest.data = State.buildRegisterObject();
			scriptRequest.method = URLRequestMethod.POST;

			var scriptLoader:URLLoader = new URLLoader();

			scriptLoader.addEventListener(Event.COMPLETE, handleLoadSuccessful);
			scriptLoader.addEventListener(IOErrorEvent.IO_ERROR, handleLoadError); 
			scriptLoader.load(scriptRequest);
		}
		
		private static function handleLoadSuccessful($evt:Event):void
		{
			MonsterDebugger.trace("Incoming result", $evt.currentTarget.data);
			var incomingJSON:Object = JSON.parse($evt.currentTarget.data);
			//State.sessionKey = $evt.currentTarget.data.session_key;
			if (incomingJSON.entry) {
				State.entrantID = incomingJSON.entry;
			}
			Comms.dispatchEvent(new Event("REGISTER_SUCCESS"));
		}
			 
		private static function handleLoadError($evt:IOErrorEvent):void
		{
			MonsterDebugger.trace("Comms", "Message failed.");
			Comms.dispatchEvent(new Event("REGISTER_FAILURE"));
		}
		
		// Post score and check if user made top 10
		
		public static function postScore() {
			var scoreRequest:URLRequest = new URLRequest("http://dev.justine-40years.co.za/wwdjsq33");
			scoreRequest.data = State.buildScoreObject();
			scoreRequest.method = URLRequestMethod.POST;
			var scorePoster:URLLoader = new URLLoader();

			scorePoster.addEventListener(Event.COMPLETE, scoreHandler);
			scorePoster.addEventListener(IOErrorEvent.IO_ERROR, scoreErrorHandler); 
			scorePoster.load(scoreRequest);
		}
		
		private static function scoreHandler(e:Event) {
			MonsterDebugger.trace("Score Return",e);
			var scoreJSON:Object = JSON.parse(e.currentTarget.data);
			State.leaderboard = scoreJSON.board;
			Comms.dispatchEvent(new Event("SCORE_SUCCESS"));
		}
		
		private static function scoreErrorHandler(e:IOErrorEvent) {
			MonsterDebugger.trace("Score Return",e);
			Comms.dispatchEvent(new Event("SCORE_FAILURE"));
		}
		
		
		
		// Event Dispatcher code for Static Classes
		
        public static function dispatchEvent(event:Event):Boolean 
        {
            return getInstance().dispatchEvent(event);
        };
        
        public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
        {
            getInstance().removeEventListener(type, listener, useCapture);
        };
		
		public static function addEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
        {
            getInstance().addEventListener(type, listener, useCapture);
        };
        
        public static function hasEventListener(type:String):Boolean 
        {
            return getInstance().hasEventListener(type);
        };
        
        public static function willTrigger(type:String):Boolean 
        {
            return getInstance().willTrigger(type);
        }
		
	}

}