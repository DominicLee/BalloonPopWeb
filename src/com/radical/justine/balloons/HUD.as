package com.radical.justine.balloons 
{
	import flash.display.MovieClip;
	import caurina.transitions.Tweener;
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class HUD extends MovieClip
	{
		
		
		public function HUD() 
		{
			
		}
		
		public function showHUD() {
			Tweener.addTween(this, {x:580, time:1, delay:2, transition:"EaseOutBack"} );
		}
		
		public function hideHUD() {
			Tweener.addTween(this, {x:1051, time:1, transition:"EaseInBack"} );
		}
		
		public function updateScore(s:Number) {
			this.Score.text = s.toString();
		}
		
		public function updateTime(t:Number) {
			t.toString().length > 1 ? this.TimeLeft.text = "0:"+t.toString() : this.TimeLeft.text = "0:0"+t.toString();
		}
		
		public function resetHUD() {
			this.Score.text = "0";
			this.TimeLeft.text = "0:20";
		}
		
		
	}

}