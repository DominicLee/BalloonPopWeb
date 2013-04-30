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
	public class JustineMain extends Main 
	{
		
		override public function startBalloons() {
			GameLoop.registerEvent(200, makeBalloon01);
			GameLoop.registerEvent(500, makeBalloon02);
			GameLoop.registerEvent(1000, makeBalloon03);
			GameLoop.startCountdown();
		}
		
		private function speedUp(e:TimerEvent) {
			adjSpeed(1);
		}	
	}
}