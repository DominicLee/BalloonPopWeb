package com.radical.justine.balloons 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import com.demonsters.debugger.MonsterDebugger;
	import flash.text.TextFormat;
	import caurina.transitions.Tweener;
	import com.radical.justine.balloons.TickBox;
	import com.radical.justine.balloons.State;
	
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class Registration extends MovieClip
	{
		
		public var FirstName:TextField;
		public var Surname:TextField;
		public var EmailAddress:TextField;
		public var Contact:TextField;
		public var RefCode:TextField;
		public var ResponseHeader:TextField;
		public var redText:TextFormat;
		public var blackText:TextFormat;
		public var winnerState:Boolean = false;
		private var tickBox:MovieClip;

		
		public function Registration() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, setup);
		}
		
		private function setup(e:Event) {
			this.removeEventListener(Event.ADDED_TO_STAGE, setup);
			
			redText = new TextFormat();
			redText.color = 0xFF0000;
			
			blackText = new TextFormat();
			blackText.color = 0x000000;
			
			FirstName.addEventListener(FocusEvent.FOCUS_IN, clearHint);
			FirstName.addEventListener(FocusEvent.FOCUS_OUT, showHint);
			Surname.addEventListener(FocusEvent.FOCUS_IN, clearHint);
			Surname.addEventListener(FocusEvent.FOCUS_OUT, showHint);
			EmailAddress.addEventListener(FocusEvent.FOCUS_IN, clearHint);
			EmailAddress.addEventListener(FocusEvent.FOCUS_OUT, showHint);
			Contact.addEventListener(FocusEvent.FOCUS_IN, clearHint);
			Contact.addEventListener(FocusEvent.FOCUS_OUT, showHint);
			
			MovieClip(getChildByName("SubmitButton")).Spinner.visible = false;
			
			MovieClip(getChildByName("PlayAgain")).addEventListener(MouseEvent.CLICK, playAgain);
			MovieClip(getChildByName("ViewWinners")).addEventListener(MouseEvent.CLICK, viewWinners);
			MovieClip(getChildByName("SubmitButton")).addEventListener(MouseEvent.CLICK, validate);
			MovieClip(getChildByName("Terms")).addEventListener(MouseEvent.CLICK, viewTerms);
			MovieClip(getChildByName("Terms")).buttonMode = true;
			
			ResponseText.tabEnabled = false;
			SubmitButton.tabEnabled = false;
			FinalScore.mouseEnabled = false;
			
			if (stage.focus) { trace (stage.focus.name); }
		}
		
		private function getTab(e:FocusEvent) {
			trace(e.currentTarget.name);
		}
		
		public function init() {
			MovieClip(getChildByName("Share")).removeEventListener(MouseEvent.CLICK, shareWin);
			MovieClip(getChildByName("Share")).removeEventListener(MouseEvent.CLICK, shareApp);
			MovieClip(getChildByName("SubmitButton")).addEventListener(MouseEvent.CLICK, validate);
			Tweener.addTween(this, { y:10, time:4, transition: "easeOutBack" } );
		}
		
		public function showResults() {
			FinalScore.text = State.score.toString();
			if (State.leaderboard<11) {
				ResponseText.text = "Congratulations! You made the Top 10!";
				MovieClip(getChildByName("Share")).addEventListener(MouseEvent.CLICK, shareWin);
			} else {
				ResponseText.text = "Thank you for celebrating with us!";
				MovieClip(getChildByName("Share")).addEventListener(MouseEvent.CLICK, shareApp);
			}
			Tweener.addTween(this,{y: -960, time:4, transition: "easeOutBack" } );
		}
		
		public function hide() {
			Tweener.addTween(this,{y: -480, time:4, transition: "easeInOutBack" } );
		}
		
		private function validate(e:MouseEvent) {
			
			clearErrors();
			var go:Boolean = true;
			var errorList:Array = new Array();
			// Check Fields
			if (FirstName.text == "") { go = false; errorList.push("FirstNameBox") }
			if (Surname.text == "") { go = false; errorList.push("SurnameBox") }
			if (Contact.text =="" || Contact.text.search(/[0-9]/)<0 || Contact.text.length<10) { go = false; errorList.push("ContactBox") }
			if (EmailAddress.text.indexOf("@") == -1 || EmailAddress.text.indexOf(".") == -1) { go = false; errorList.push("AddressBox"); }
						
			if (go || State.debug) {
				// Store info for later use
				MovieClip(getChildByName("SubmitButton")).removeEventListener(MouseEvent.CLICK, validate);
				MovieClip(getChildByName("SubmitButton")).Spinner.visible = true;
				State.playerFirstName = FirstName.text;
				State.playerSurname = Surname.text;
				State.playerEmail = EmailAddress.text;
				State.playerContact = Contact.text;
				if (State.debug) {
					successHandler();
				} else {
					Comms.addEventListener("REGISTER_SUCCESS", successHandler);
					Comms.addEventListener("REGISTER_FAILURE", failureHandler);
					Comms.registerUser();
				}
			} else {
				trace("Errors");
				showErrors(errorList);
			}
		}
		
		private function successHandler(e:Event = null) {
			ResponseText.text = "Thanks, your details were saved.";
			MovieClip(getChildByName("SubmitButton")).Spinner.visible = false;
			hide();
			this.dispatchEvent(new Event("EntryComplete"));
			State.firstPlay = false;
		}
		
		private function failureHandler(e:Event) {
			ResponseText.text = "There was an error submitting your information. Please try again.";
			MovieClip(getChildByName("SubmitButton")).Spinner.visible = false;
			MovieClip(getChildByName("SubmitButton")).addEventListener(MouseEvent.CLICK, validate);
		}
		
		private function showErrors(_list:Array) {
			for (var xx in _list) {
				var _target:MovieClip = getChildByName(_list[xx]) as MovieClip;
				_target.gotoAndStop(2);
			}
		}
		
		private function clearErrors() {
			MovieClip(this.getChildByName("FirstNameBox")).gotoAndStop(1);
			MovieClip(this.getChildByName("SurnameBox")).gotoAndStop(1);
			MovieClip(this.getChildByName("ContactBox")).gotoAndStop(1);
			MovieClip(this.getChildByName("AddressBox")).gotoAndStop(1);
		}
		
		private function clearHint(e:FocusEvent) {
			//MonsterDebugger.trace(this, e);
			e.currentTarget.textColor = 0x000000;
			this[e.currentTarget.name+"Hint"].visible = false;
		}
		
		private function showHint(e:FocusEvent) {
			e.currentTarget.text == "" ? this[e.currentTarget.name+"Hint"].visible = true : null;
		}
		
		private function changeState(e:MouseEvent) {
			if (e.currentTarget.isSelected == null) e.currentTarget.isSelected = false;
			e.currentTarget.isSelected = !e.currentTarget.isSelected;
			e.currentTarget.isSelected ? e.currentTarget.gotoAndStop(2) : e.currentTarget.gotoAndStop(1);
		}
		
		private function playAgain(e:MouseEvent) {
			this.dispatchEvent(new Event("PLAY_AGAIN"));
		}
		
		private function viewWinners(e:MouseEvent) {
			this.dispatchEvent(new Event("VIEW_LEADERBOARD"));
		}
		
		private function shareWin(e:MouseEvent) {
			this.dispatchEvent(new Event("SHARE_GENERIC"));
		}
		
		private function shareApp(e:MouseEvent) {
			this.dispatchEvent(new Event("SHARE_GENERIC"));
		}
		
		private function viewTerms(e:MouseEvent) {
			MonsterDebugger.trace(this, "Viewing terms");
			trace("viewing terms");
			this.dispatchEvent(new Event("VIEW_TERMS"));
		}
		
	}

}