package com.radical.justine.balloons 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.demonsters.debugger.MonsterDebugger;
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class TickBox extends MovieClip
	{
		
		public var isSelected:Boolean = false;
		
		public function TickBox() 
		{
			MonsterDebugger.trace(this, this);
			
		}
		
		public function init() {
			this.gotoAndStop(1);
			MonsterDebugger.trace(this, "init");
			this.addEventListener(MouseEvent.CLICK, changeState);
		}
		
		private function changeState(e:MouseEvent) {
			isSelected = !isSelected;
			isSelected ? this.gotoAndStop(2) : this.gotoAndStop(1);
		}
		
	}

}