package com.radical.justine.balloons 
{
	
	import flash.events.MouseEvent;
	import flash.events.Event;
	import caurina.transitions.Tweener;
	
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class BalloonWin extends Balloon
	{
		
		public function BalloonWin() 
		{
			this.acceleration = 0.1;
			this.particleColour = "Red";
			//attachedVoucher = new Voucher();
			super();
		}
		
		override public function killWin() {
			this.removeEventListener(MouseEvent.CLICK, popIt);
			this.removeEventListener(Event.ENTER_FRAME, float);
			//_root[parallaxPlane].removeChild(this);
			_root.endGameWin(this);
			//delete this;
		}
		
	}

}