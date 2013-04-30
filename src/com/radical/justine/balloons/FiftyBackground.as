package com.radical.justine.balloons 
{
	
	import flash.display.MovieClip
	import caurina.transitions.Tweener;
	import com.demonsters.debugger.MonsterDebugger;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class FiftyBackground extends MovieClip
	{
		
		public function FiftyBackground() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		private function init(e:Event) {
			//this.x = 405;
		}
		
		public function changeBG(_page:Number) {
			MonsterDebugger.trace(this, _page);
			Tweener.addTween(this, { x: 0-((_page-1)*810), time: 1, transition:"EaseInOutQuad" } );
		}
	}
}