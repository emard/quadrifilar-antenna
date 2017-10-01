/*

Calculator from javascript adapted to openscad
original from: John Coppens ON6JC/LW3HAZ
https://www.jcoppens.com/ant/qfh/calc.en.php


Design frequency 	MHz
Number of turns (twist) 	
Length of one turn 	
wavelengths
Bending radius 	mm
Conductor diameter 	mm (optimum: - mm)
Width/height ratio 	

	
Results

Wavelength 	- mm
Compensated wavelength 	- mm
Bending correction 	- mm

Larger loop
Total length 	
	- mm
Vertical separator 	
	- mm
Total compensated length 	
	- mm
Compensated vertical separation 	
	- mm
Antenna height 	H1= 	- mm
Internal diameter 	Di1= 	- mm
Horizontal separator 	D1= 	- mm
Compensated horiz. separation 	Dc1= 	- mm

Smaller loop
Total length 	
	- mm
Vertical tube 	
	- mm
Compensated total length 	
	- mm
Compensated vertical tube 	
	- mm
Antenna height 	H2= 	- mm
Internal diameter 	Di2= 	- mm
Horizontal separator 	D2= 	- mm
Compensated horiz. separator 	Dc2= 	- mm

Legend
This calculator generates a lot of data! Take care in the use of the information in order not to make mistakes...

Here's a little explanation:

Design frequency
    Evident?
Number of turns (twist)
    What's the twist of the antenna? (normally 0.5 (180 degrees)
Length of one turn
    A few variations of the antenna exist. Normally the circumference (length of the loop) is 1 wavelength, but 1.5 wavelength and 2 wavelength versions exist.
Bending diameter
    As it's impossible to bend the corner abruptly at 90 degrees, this value is needed for the calculations. It's measured from the bending center to the center of the tube.
Conductor diameter
    External diameter of the tube or coax cable.
Diameter/height ratio
    Most frequently this ratio is 0.44, but slightly lower values (0.3 to 0.4) give better horizon coverage.
Wavelength
    Wavelength, corresponding to the selected frequency.
Compensated wavelength
    Wavelength, compensated according to the conductor diameter.
Bending correction
    Correction value needed according to the bending diameter.
Total length
    Total length of the loop, before compensation.
Total loop cmpensated length
    Total length of the loop, compensated for the bending effect, and the fact that the loop must be slightly larger (or smaller). This is the amount of tubing necessary for this loop.
Compensated vertical separation
    Vertical separation (without the 'bends').
Compensated horizontal separation
    This is in fact the horizontal part without the 'bends', and corresponds to the horizontal pipe necessary to support the cable.
Antenna height
    Height of the loop (twisted!).
Internal diameter
    The diameter of the (imaginary) cylinder 

*/

// main carrier tube
tube_d=18; // mm diameter
tube_l=400; // mm length

holder_d_clr=0.2; // clearance from tube to plastic holder

holder_h=10; // mm height along the tube length
holder_ring_thick=2; // mm thickenss of the ring around tube
holder_radial_thick=7; // mm thickness of radial parts

module wire_holder()
{
  outer_d=tube_d+2*holder_d_clr+2*holder_ring_thick;
  cylinder(d=tube_d+2*holder_ring_thick
}


wire_holder();