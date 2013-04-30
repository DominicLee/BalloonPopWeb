package com.radical.justine.balloons 
{
	import caurina.transitions.PropertyInfoObj;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.radical.justine.balloons.State;
	import caurina.transitions.Tweener;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import com.demonsters.debugger.MonsterDebugger;
	
	import com.radical.justine.balloons.ParticleSystem;
	import com.radical.justine.balloons.Vector3D;
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class Balloon extends MovieClip
	{
		
		public var acceleration:Number = 0;
		public var velocity:Number = 0;
		public var points:Number = 0;
		public var frameAdj:Number = 0;
		public var timeAdj:Number = 0;
		public var scale:Number = 1;
		public static var scaleArray:Array;
		public var parallaxPlane:String;
		public var attachedVoucher:Voucher = null;
		public var feedback:MovieClip;
		public var image:MovieClip;
		public var hitzone:MovieClip;
		public var _root:MovieClip;
		public var burstClip:MovieClip;
		public var particleColour:String;
		public var ps:ParticleSystem;
		public var winningBalloon:Boolean = false;
		
		public function Balloon() 
		{
			feedback = MovieClip(this.getChildByName("BalloonFeedback"));
			feedback.mouseEnabled = false;
			feedback.mouseChildren = false;
			feedback.Feedback.mouseEnabled = false;
			image = MovieClip(this.getChildByName("Image"));
			hitzone = MovieClip(this.getChildByName("HitZone"));
			image.mouseEnabled = false;
			image.mouseChildren = false;
			hitzone.addEventListener(MouseEvent.MOUSE_DOWN, popIt, false, 0, true);
		}
		
		public function init(_target:MovieClip) {
			_root = _target;
			scaleArray = new Array(1, 1.25, 1.75, 2.5);
			var balloonPlane:Number = Math.floor(Math.random() * scaleArray.length);
			feedback.Feedback.text = "+"+this.points;
			feedback.visible = false;
			var balloonScale:Number = scaleArray[balloonPlane];
			this.scaleX = this.scaleY = 1 / balloonScale;
			this.x = Math.random()*810;
			this.y = 550;
			this.acceleration = this.acceleration / balloonScale;
			// Choose correct parallax plane to attach to
			parallaxPlane = "level"+balloonPlane;
			_root[parallaxPlane].addChild(this);
			release();
		}
		
		public function release() {
			this.addEventListener(Event.ENTER_FRAME, float, false, 0, true);
		}
		
		public function float(e:Event) {
			velocity += acceleration/2;
			this.y > - 300 ? this.y -= velocity : kill();
		}
		
		public function popIt(e:MouseEvent) {
			var balloonPop:BubblePop = new BubblePop();
			balloonPop.play();
			State.balloonsPopped++;
			this.feedback.visible = true;
			Tweener.addTween(this.feedback, { scaleX:0.7, scaleY:0.7, time:0.5, transition:"EaseOutBack", onComplete: removeFeedback } );
			_root.adjTime(this.timeAdj);
			State.adjScore(this.points);
			burst();
		}
		
		private function removeFeedback() {
			Tweener.addTween(this.feedback, { alpha:0, time:0.4, delay: 0.4, transition: "linear", onComplete: kill} );
		}
		
		public function burst() {
			hitzone.removeEventListener(MouseEvent.MOUSE_DOWN, popIt);
			this.removeEventListener(Event.ENTER_FRAME, float);
			removeChild(hitzone);
			removeChild(image);
			ps = new ParticleSystem(1, new Vector3D(0, 0, 0), particleColour);
			ps.mouseChildren = false;
			ps.mouseEnabled = false;
			ps.addParticles();
			this.addChild(ps);
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event)
			{
			  ps.run();
			}
		
		public function kill() {
			//trace("Killing balloon " + this.name);
			removeEventListener(Event.ENTER_FRAME, update);
			hitzone.removeEventListener(MouseEvent.MOUSE_DOWN, popIt);
			this.removeEventListener(Event.ENTER_FRAME, float);
			_root[parallaxPlane].removeChild(this);
			delete this;
		}
		
		public function killWin() {
			
		}
	}

}