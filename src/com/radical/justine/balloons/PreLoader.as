package com.radical.justine.balloons 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import com.demonsters.debugger.MonsterDebugger;
	import caurina.transitions.Tweener;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class PreLoader extends MovieClip
	{
		public var LoaderClip:MovieClip;
		public var justineMain:JustineMain;
		
		public function PreLoader() 
		{
			MonsterDebugger.initialize(this);
			LoaderClip = getChildByName("LoaderMovie") as MovieClip;
			this.loaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			this.loaderInfo.addEventListener(Event.COMPLETE, onLoaded);
		}
			
		private function onProgress(e:ProgressEvent):void {
			var percent:Number = Math.round(e.bytesLoaded / e.bytesTotal * 100);
			LoaderClip.percLoaded.text = percent +"%";
			LoaderClip.LoaderBar.y = 135 - percent * 1.3;
		}
		
		private function onLoaded(e:Event) {
		   this.loaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
		   this.gotoAndStop(2);
		   justineMain = new JustineMain();
		   addChild(justineMain);
		   Tweener.addTween(this, { time:1, onComplete: goForIt } );
		}
		
		private function goForIt() {
			//stage.addEventListener(MouseEvent.CLICK, reportTarget);
			justineMain.init();
		}
		
		private function reportTarget(e:MouseEvent) {
			trace(e.target.name);
		}
		
	}

}