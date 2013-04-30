package com.radical.justine.balloons 
{
	/**
	 * ...
	 * @author Dom Lee
	 */
	public class Voucher 
	{
		
		public var voucherValue:Number = 0;
		public var voucherReference:String;
		public var voucherID:Number = 0;
		
		public function Voucher(_value:Number, _id:Number, _ref:String) 
		{
			voucherValue = _value;
			voucherID = _id;
			voucherReference = _ref;
		}
		
	}

}