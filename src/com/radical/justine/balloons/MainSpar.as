package com.radical.justine.balloons
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import com.demonsters.debugger.MonsterDebugger;
	import caurina.transitions.Tweener;
	
	
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class MainSpar extends Main 
	{
		
		override public function startBalloons() {
			State.voucherInPlay ? GameLoop.registerEvent(500, makeWinBalloon) : GameLoop.registerEvent(500, makeBalloon03);
			GameLoop.registerEvent(500, makeBalloon02);
			GameLoop.registerEvent(500, makeBalloon01);
			//GameLoop.registerEvent(1000, speedUp);
			//	GameLoop.startCountdown();
		}
		
		private function speedUp(e:TimerEvent) {
			adjSpeed(1);
		}	
	}
}