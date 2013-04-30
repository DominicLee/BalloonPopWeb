/*
 * Vector3D for ActionScript 3  
 * Author: Mohammad Haseeb aka M.H.A.Q.S.
 * Original library for Processing by Daniel Shiffman
 * 
 * Licence Agreement
 * 
 * This source code is copyright of Daniel Shiffman, I converted it 
 * to AS3 for my personal convenience.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
 
package com.radical.justine.balloons
{
	import flash.display.*;
	import flash.geom.Point;

	public class Particle extends MovieClip
	{
		var loc:Vector3D;
		var vel:Vector3D;
		var acc:Vector3D;
		var r:Number;
		var timer:Number;
		var rot:Number;

		// One constructor
		public function Particle1(_color:String, a:Vector3D, v:Vector3D, l:Vector3D, r1:Number)
		{
			acc=a.Constructor();
			vel=v.Constructor();
			loc=l.Constructor();
			r=r1;
			timer = 100.0;
			
		}
		// Another constructor (the one we are using here)
		public function Particle(l:Vector3D, _color:String)
		
		{
			this.mouseEnabled = false;
			switch (_color) {
				case "Green":
					var confettigreen:ConfettiGreen = new ConfettiGreen();
					confettigreen.gotoAndStop(Math.round(Math.random() * 4) + 1);
					this.addChild(confettigreen);
					break
				case "Red":
					var confettired:ConfettiRed = new ConfettiRed();
					confettired.gotoAndStop(Math.round(Math.random() * 4) + 1);
					this.addChild(confettired);

					break
				case "Blue":
					var confettiblue:ConfettiBlue = new ConfettiBlue();
					confettiblue.gotoAndStop(Math.round(Math.random() * 4) + 1);
					this.addChild(confettiblue);
					break
			}
			
			
			acc=new Vector3D(0,0.5,0);
			vel=new Vector3D((Math.random() * -10.0 + Math.random() * 10.0),(Math.random() * -6.0 + Math.random() * -6),0);
			loc=l.Constructor();
			r=10.0;
			//timer = 1.0;
			rot = 5 + Math.random() * 5;
			//rotZ = Math.random() * 10;
			
		}


		public function run():void
		{
			update();
			render();
		}

		// Method to update location
		public function update():void
		{
			vel.VectorAddition1(acc);
			loc.VectorAddition1(vel);
			//timer -= 0.01;
		}

		// Method to display
		public function render():void
		{
			this.x = loc.x;
			this.y = loc.y;
			this.z = loc.z;
			this.rotationY += rot;
			this.rotationZ += rot;
		}
		// Is the particle still useful?
		public function dead():Boolean
		{
			var globalPoint:Point = this.localToGlobal(new Point(0, 0));
			//trace(globalPoint);
			if (globalPoint.y>720)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
	}
}