/*
// TODO: include:
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

// wire winding diameter
winding_d=[40,35]; // mm [large,small]
winding_h=[100,90]; // mm [large,small]
wire_d=1.78;
wire_hole_d=4; // drilled hole for the wire
wire_twist=180; // degrees

// main carrier tube
tube_d=18; // mm diameter
tube_l=400; // mm length


holder_d_clr=0.2; // clearance from tube to plastic holder

holder_h=8; // mm height along the tube length
holder_tube_ring_thick=2; // mm thickenss of the big ring around tube
holder_wire_ring_thick=2; // mm thickness of the small ring around wire
holder_radial_thick=2*holder_wire_ring_thick; // mm thickness of radial parts
//holder_radial_thick=2*holder_wire_ring_thick;
//holder_radial_over=wire_hole_d+2*holder_tube_ring_thick; // length to hold the wire
holder_radial_over=0;
holder_radial_d=winding_d+[holder_radial_over,holder_radial_over]*2; // mm total diameter of the radials
circular_segments=32; // smoothness of the rings
extrusion_slices=10; // smoothness of helicoidal extruded countour

//holder_angle=atan(winding_d/winding_h); // wire twist angle 


// h-height at position
// tracks angle of the wire
// and rotates the holder
module wire_holder(h=0)
{
  inner_d=tube_d+2*holder_d_clr;
  outer_d=inner_d+2*holder_tube_ring_thick;
  wire_holder_d=wire_hole_d+2*holder_wire_ring_thick;
  difference()
  {
    intersection()
    {
    union()
    {
      // around the tube
      translate([0,0,h])
      cylinder(d=outer_d, h=holder_h, $fn=circular_segments, center=true);
      // the radials cross
      for(i=[0:3])
      {
        index=i % 2;    
        rotate([0,0,i*90])
          // helical extrude the holder rings around the shape of wires
            linear_extrude(height = winding_h[index], convexity = 10, twist = wire_twist, slices=extrusion_slices, center=true)
    translate([winding_d[index]/2, 0])
      difference()
      {
        union()
        {
          // the radial
          translate([-winding_d[index]/4,0])
          square([winding_d[index]/2,holder_radial_thick],center=true);
          // the holder
          circle(d = wire_holder_d,$fn=6,center=true);
        }
        circle(d = wire_hole_d,$fn=6,center=true);
      }

          // old, linear version
          if(0)
          rotate([holder_angle,0,0])
            translate([holder_radial_d/4,0,0])
          
          difference()
          {
            union()
            {
                // the radial
            cube([holder_radial_d/2,holder_radial_thick,2*holder_h],center=true);
                // cylindrical wire holder at the end
             translate([holder_radial_d/4,0,0])
                cylinder(d=wire_holder_d,h=10*holder_h,$fn=circular_segments/2,center=true);
            }
            // drill holes on both sides
            // for(j=[-1:2:1])
              translate([1*winding_d/4,0,0])
              cylinder(d=wire_hole_d,h=10*holder_h+0.01,$fn=6,center=true);
          }
      }
    }
       // enclosing box that cuts off angled radials
       translate([0,0,h])
       cube([holder_radial_d[0]*2,holder_radial_d[1]*2,holder_h],center=true);
    }
    // hole inside
    translate([0,0,h])
    cylinder(d=inner_d, h=holder_h+0.01, $fn=circular_segments, center=true);
  }
}

// wire helix
module helix(d=10,h=10,wire=3,twist=180)
{
  linear_extrude(height = h, convexity = 10, twist = twist, slices=10, center=true)
    translate([d/2, 0, 0])
      circle(d = wire,$fn=6,center=true);
}

module winding()
{
 for(i=[0:3])
 {
   index=i%2;
   rotate([0,0,90*i])
     %helix(d=winding_d[index],h=winding_h[index],wire=wire_d,twist=wire_twist);
 }
}


wire_holder(h=0);
winding();
