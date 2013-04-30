package com.radical.justine.balloons 
{
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class ResultObject 
	{
		
		public var voucherWinner:Boolean = false;
		public var finalScore:Number = 0;
		public var voucher:Voucher;
		public var referenceCode:Number;
		
		public function ResultObject(_winner:Boolean, _score:Number, _voucher:Voucher, _reference:Number) 
		{
			voucherWinner = _winner;
			finalScore = _score;
			voucher = _voucher;
			referenceCode = _reference;
		}
		
	}

}