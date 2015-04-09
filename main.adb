with struct; 
with Polygone;
with Parseur;
with Svg;
with Geometry; use Geometry;
with ada.command_line; use ada.command_line;
with ada.integer_text_io; use ada.integer_text_io;
with ada.text_io; use ada.text_io;

procedure Main is
	a : Polygone.abr.arbre := null;
	nbPoints : natural;
begin
	if Argument_Count /= 2 then
		Put_Line(Standard_Error, "utilisation : main src.in polygone.svg");
		return;
	end if;

	Parseur.lectureEnTete(Argument(1), nbPoints);

	svg.svg_header(30, 50);

	declare
		tabPoints : TableauPoints(1..nbPoints);
	begin
		Parseur.Lecture(Argument(1), nbPoints, tabPoints);
		-- dessine d'abord le polygone
		svg.drawPolygone(Argument(2), tabPoints);
		-- fait le traitement principal sur le polygone
		Polygone.traitement(a, tabPoints);
		--
		svg.svg_footer;
	end;

end Main;
