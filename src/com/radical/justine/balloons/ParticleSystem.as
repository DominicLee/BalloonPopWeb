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
	import flash.display.MovieClip;
	
	public class ParticleSystem extends MovieClip
	{

		var particles:Array;	// An arraylist for all the particles
		var origin:Vector3D;	// An origin point for where particles are created
		var colour:String;

		public function ParticleSystem(num:int,v:Vector3D, _color:String)
		{
			this.mouseChildren = false;
			colour = _color;
			particles=new Array();	// Initialize the arraylist
			origin=v.Constructor();		// Store the origin point
			
			for (var i:uint=0; i < num; i++)
			{
				particles.push(new Particle(origin, colour));	// Add "num" amount of emitters to the arraylist
			}
		}
		
		public function run()
		{
			// Cycle through the ArrayList backwards b/c we are deleting
			for (var i:uint=particles.length - 1 ; i > 0; i--)
			{
				particles[i].run();
				
				if (particles[i].dead())
				{
					//trace(particles[i].name + " is dead");
					removeChild(particles[i]);
					particles.splice(i, 1);
					//trace(particles.length + " particles left");
				}
			}
		}
		public function addParticles()
		{
			for (var xx = 0; xx < 30 + Math.random()*50; xx++) {
				var p:Particle = new Particle(origin, colour);
				particles.push(p);
				addChild(p);
			}
		}
		public function addParticle2(p:Particle)
		{
			particles.push(p);
		}
		// A method to test if the particle system still has particles
		public function dead():Boolean
		{
			if (particles.length < 2)
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