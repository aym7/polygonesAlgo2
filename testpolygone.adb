with Polygone; use Polygone;
with geometry; use geometry;
with ada.text_io; use ada.text_io;

procedure TestPolygone is
    procedure testPointAvant is
	p1, p2 : Point;
    begin

	p1 := Point'(1.0,2.0);
	p2 := Point'(3.0,2.0);

	if pointAvant(p1, p2) then
	    put_line("TEST1 : ok pour pointAvant !");
	else
	    put_line("pointAvant doesn't work !");
	end if;

	p1 := Point'(3.0,2.0);
	p2 := Point'(3.0,4.0);

	if pointAvant(p1, p2) then
	    put_line("TEST2 : ok pour pointAvant !");
	else
	    put_line("pointAvant doesn't work !");
	end if;
    end testPointAvant;



    procedure testNbSeg is
	T : TableauPoints(0..4);
    begin
	T := ((0.0, 3.0), (1.0, 4.0), (3.0, 6.0), (2.0, 3.0), (3.0, 0.0)); 

	for i in T'range loop
	    put_line("Tab(" & integer'image(i) & ") : commencant : " & natural'image(nbSeg(i, true, T)) & " finissant : " & natural'image(nbSeg(i, false, T)) );
	end loop;


    end testNbSeg;



    procedure testSegInf is
	s1, s2 : Segment;
	p1, p2, p3 : Point;
    begin
	p1 := Point'(0.0,3.0);
	p2 := Point'(3.0,2.0);
	p3 := Point'(0.0,4.0);

	s1 := Segment'(p1, p2);
	s2 := Segment'(p3, p2);

	if s1 < s2 then
	    put("seg < ok !");
	else
	    put ("seg < ERROR");
	end if;

    end testSegInf;

begin

    testPointAvant;
    testNbSeg;
    testSegInf;

end TestPolygone;
