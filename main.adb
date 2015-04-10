with struct; 
with Polygone;
with Parseur;
with Svg;
with Geometry; use Geometry;
with ada.command_line; use ada.command_line;
with ada.integer_text_io; use ada.integer_text_io;
with ada.text_io; use ada.text_io;

procedure Main is
    nbPoints : natural;
    ABRStockSegments : polygone.abr.arbre;
begin
    if Argument_Count /= 2 then
        Put_Line(Standard_Error, "utilisation : main src.in polygone.svg");
        return;
    end if;

    Parseur.lectureEnTete(Argument(1), nbPoints);

    svg.svg_header(Argument(2), 30, 50);

    declare
        tabPoints : TableauPoints(0..nbPoints-1);
	tabTri : TableauPoints(0..nbPoints-1);
    begin
        Parseur.Lecture(Argument(1), nbPoints, tabPoints);
        -- dessine d'abord le polygone
        svg.drawPolygone(tabPoints);
        -- fait le traitement principal sur le polygone
	
	tritab(tabPoints, tabTri);
	--création abr;

        Polygone.traitement(tabPoints);
        --
        svg.svg_footer;
    end;

end Main;
