package com.radical.justine.balloons
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.events.ProgressEvent;
	import com.demonsters.debugger.MonsterDebugger;
	import caurina.transitions.Tweener;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.external.ExternalInterface;
	import flash.net.navigateToURL;
	
	import com.radical.justine.balloons.GameLoop;
	import com.radical.justine.balloons.Comms;
	import com.radical.justine.balloons.State;
	import com.radical.justine.balloons.HUD;
	
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class Main extends MovieClip 
	{
		
		public var level1:MovieClip = new MovieClip();
		public var level2:MovieClip = new MovieClip();
		public var level3:MovieClip = new MovieClip();
		public var level0:MovieClip = new MovieClip();
		public var allLevels:Array;
		
		public var timeLeft:Number = 20;
		
		public var EntryFormClip:MovieClip;
		public var RotatingBackground:MovieClip;
		public var hud:MovieClip;
		public var balloonList:Array;
		public var firstPlay:Boolean = true;
		
		public function Main():void 
		{
			
		}
		
		public function init():void 
		{
			State.init(this);
			Comms.init(this);
			GameLoop.init(this);
			
			
			
			EntryFormClip = parent.getChildByName("EntryForm") as MovieClip;
			RotatingBackground = parent.getChildByName("Background") as MovieClip;
			hud = new HUD();
			hud.x = 1050;
			hud.y = 365;
			
			// Make fake parallax levels so we don't have to z-sort
			allLevels = new Array();
			stage.addChild(level3);
			stage.addChild(level2);
			stage.addChild(level1);
			stage.addChild(level0);
			stage.addChild(hud);
			
			allLevels.push(level0);
			allLevels.push(level1);
			allLevels.push(level2);
			allLevels.push(level3);
			balloonList = new Array();
			
			EntryFormClip.init();
			EntryFormClip.addEventListener("EntryComplete", thanks);
			EntryFormClip.addEventListener("PLAY_AGAIN", playAgain);
			EntryFormClip.addEventListener("VIEW_LEADERBOARD", ViewLeaderboard);
			EntryFormClip.addEventListener("SHARE_GENERIC", ShareGeneric);
			EntryFormClip.addEventListener("VIEW_TERMS", viewTerms);
			
		}
		
		public function startBalloons() {
			
			GameLoop.registerEvent(100, makeBalloon01);
			GameLoop.registerEvent(200, makeBalloon02);
			GameLoop.registerEvent(300, makeBalloon03);
			
			GameLoop.startCountdown();
		}
		
		public function makeBalloon01(e:TimerEvent) {
			var balloon01:Balloon01 = new Balloon01();
			balloonList.push(balloon01);
			balloon01.init(this);
		}
		
		public function makeBalloon02(e:TimerEvent) {
			var balloon02:Balloon02 = new Balloon02();
			balloonList.push(balloon02);
			balloon02.init(this);
		}
		
		public function makeBalloon03(e:TimerEvent) {
			var balloon03:Balloon03 = new Balloon03();
			balloonList.push(balloon03);
			balloon03.init(this);
		}
		
		public function adjSpeed(_amount:Number) {
			(stage.frameRate > 29 && stage.frameRate < 60) ? stage.frameRate += _amount : null;
			stage.frameRate < 30 ? stage.frameRate = 30 : null;
		}
		
		public function countdownTime() {
			timeLeft--;
			hud.updateTime(timeLeft);
			timeLeft < 1 ? endGame() : null;
		}
		
		public function adjTime(_amount:Number = -1) {
			timeLeft += _amount;
			hud.updateTime(timeLeft);
			timeLeft < 1 ? endGame() : null;
		}
		
		private function endGame() {
			GameLoop.stopAllEvents();
			GameLoop.stopCountdown();
			removeBalloons();
			hud.hideHUD();
			if (State.debug) {
				showResults();
			} else {
				Comms.addEventListener("SCORE_SUCCESS", showResults);
				Comms.addEventListener("SCORE_FAILURE", showError);
				Comms.postScore();	
			}
		}
		
		private function showResults(e:Event=null) {
			EntryFormClip.showResults();
		}
		
		private function showError(e:Event) {
			
		}
		
	// ACTIONS THAT CAN HAPPEN AFTER THE REG FORM
		
		public function thanks(e:Event) {
			hud.showHUD();
			startBalloons();
		}
		
		private function playAgain(e:Event) {
			MonsterDebugger.trace(this, "Playing Again");
			cleanUp();
			EntryFormClip.hide();
			
			hud.showHUD();
			startBalloons();
		}
		
		private function ViewLeaderboard(e:Event) {
			navigateToURL(new URLRequest("http://dev.justine-40years.co.za/justine/leaderboard.html"), "_self");
			
		}
		
		private function ShareGeneric(e:Event) {
			// call javascript share
			var JSvalue = ExternalInterface.call('shareApp',State.score);
		}
		
		private function ShareWinner(e:Event) {
			// call javascript share
			var JSvalue = ExternalInterface.call('shareWin',State.score);
		}
		
		private function viewTerms(e:Event) {
			// call javascript share
			trace("Calling js");
			var JSvalue = ExternalInterface.call('showTerms');
		}
		
	// UTILITIES
	
		private function cleanUp() {
			timeLeft = 20;
			State.score = 0;
			State.balloonsPopped = 0;
			State.leaderboard = 100;
			hud.resetHUD();
		}
		
		private function removeBalloons() {
			// Kill all balloons
			for (var balloonCount in balloonList) {
				//trace("removing balloon " + balloonList[balloonCount]);
				if (balloonList[balloonCount].stage) {
					Balloon(balloonList[balloonCount]).kill();
				} 
			}
		}
		
		public function popBalloons(_winningBalloon:BalloonWin) {
			for (var balloonCount in balloonList) {
				if (balloonList[balloonCount].stage) {
					
					if (balloonList[balloonCount].winningBalloon) {
						
					} else {
						//trace(balloonList[balloonCount].name);
						Balloon(balloonList[balloonCount]).burst();
					}
				} else {
					//balloonList.splice(balloonCount,);
				}
			}
		}

	}
	
}