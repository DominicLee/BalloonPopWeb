package com.radical.justine.balloons 
{
	import flash.display.MovieClip;
	import flash.net.URLVariables;
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class State 
	{
		
		public static var score:Number = 0;
		public static var _root:MovieClip;
		public static var firstPlay:Boolean = true;
		public static var playerFirstName:String;
		public static var playerSurname:String;
		public static var playerEmail:String;
		public static var playerContact:String;
		public static var balloonsPopped:Number = 0;
		public static var transmissionKey:String = "secret";
		public static var entrantID:Number;
		public static var sessionKey:String;
		public static var leaderboard:Number = 100;
		public static var debug:Boolean = false;
		
		public function State() 
		{
			
		}
		
		public static function init(_target:MovieClip) {
			_root = _target;
		}
		
		public static function adjScore(_amount:Number) {
			score += _amount;
			score < 0 ? score = 0 : null;
			_root.hud.updateScore(score);
		}
		
		public static function buildRegisterObject():URLVariables {
			var registerObj:URLVariables = new URLVariables();
			//registerObj.transmission_key = transmissionKey;
			registerObj.first_name = playerFirstName;
			registerObj.last_name = playerSurname;
			registerObj.email = playerEmail;
			registerObj.cell_number = playerContact;
			registerObj.aType = "entds";
			return registerObj
		}
		
		public static function buildScoreObject():URLVariables {
			var scoreObj:URLVariables = new URLVariables();
			scoreObj.user_score = score;
			scoreObj.user_id = entrantID;
			//scoreObj.transmission_key = transmissionKey;
			//scoreObj.session_key = sessionKey;
			scoreObj.aType = "escr";
			return scoreObj
		}
		
	}

}