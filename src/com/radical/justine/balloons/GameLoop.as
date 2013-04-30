package com.radical.justine.balloons 
{
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import com.demonsters.debugger.MonsterDebugger;
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class GameLoop extends MovieClip
	{
		
		public static var _root:MovieClip;
		public static var timerList:Array;
		public static var timeLeft:Timer;
		
		public function GameLoop() 
		{
			
		}
		
		public static function init(_target:MovieClip) {
			_root = _target;
			timerList = new Array();
			timeLeft = new Timer(1000);
		}
		
		public static function startCountdown() {
			timeLeft.addEventListener(TimerEvent.TIMER, countdown);
			timeLeft.start();
		}
		
		public static function stopCountdown() {
			timeLeft.stop();
		}
		
		private static function countdown(e:TimerEvent) {
			_root.countdownTime();
		}
		
		public static function registerEvent(_time:Number, _function:Function) {
			var startTimer:Timer = new Timer(_time + Math.random() * _time, 1)
			
			startTimer.addEventListener(TimerEvent.TIMER, _function);
			startTimer.addEventListener(TimerEvent.TIMER_COMPLETE, startAgain);
			startTimer.start();
			timerList.push(startTimer);
		}
		
		public static function stopAllEvents() {
			for (var xx in timerList) {
				timerList[xx].stop();
				timerList[xx].removeEventListener(TimerEvent.TIMER, arguments.callee);
				timerList[xx].removeEventListener(TimerEvent.TIMER_COMPLETE, startAgain);
				delete timerList[xx];
			}
		}
		
		private static function startAgain(e:TimerEvent) {
			e.target.start();
		}
		
	}

}