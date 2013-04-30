package com.radical.justine.balloons 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class Spinner extends MovieClip
	{
		
		public function Spinner() 
		{
			this.loadingClip.addEventListener(Event.ENTER_FRAME, spin);
		}
		
		private function spin(e:Event) {
			e.target.rotation += 5;
		}
		
	}

}