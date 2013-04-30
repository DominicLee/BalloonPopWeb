package com.radical.justine.balloons 
{
	import flash.events.MouseEvent;
	import flash.events.Event;
	import caurina.transitions.Tweener;
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class Balloon02 extends Balloon
	{
		
		public function Balloon02() 
		{
			this.acceleration = 0.1;
			this.frameAdj = 0;
			this.timeAdj = 0;
			this.points = 10;
			this.particleColour = "Green";
			super();
		}
		
		
	}

}