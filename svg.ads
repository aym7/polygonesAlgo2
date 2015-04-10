with geometry;
use geometry;
-- fonction drawPolygone à ajouter !!!! 

package Svg is

    type Color is (Red, Green, Blue, Black);
    procedure Svg_Header(filename : in string; Width, Height : Integer);
    procedure Svg_Line(P1, P2 : Point; C : Color);
    procedure Svg_Footer;
    procedure drawPolygone(tabP : TableauPoints);

end Svg;
