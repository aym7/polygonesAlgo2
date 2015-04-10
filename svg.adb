with Ada.Text_IO, Ada.Float_Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Float_Text_IO, Ada.Integer_Text_IO;

package body Svg is

    Display_Width, Display_Height : Float;
    file : file_type;

    procedure Svg_Line(P1, P2 : Point ; C : Color) is
    begin
        Put(file, "<line x1=""" & float'image(P1.X) & 
            """ y1=""" & float'image(P1.Y) & """ x2=""" & 
            float'image(P2.X) & """ y2=""" & float'image(P2.Y) &
            """ style=""stroke:");
        case C is
            when Red => Put("rgb(255,0,0)");
            when Green => Put("rgb(0,255,0)");
            when Blue => Put("rgb(0,0,255)");
            when Black => Put("rgb(0,0,0)");
        end case;
        Put_Line(";stroke-width:0.2""/>");
    end Svg_Line;

    --trace le polygone à partir des points du tableau
    procedure drawPolygone(tabP : TableauPoints) is
    begin
        Put(file, "<polygon fill=""blue"" points="""); 
        for i in tabP'range loop
            put(file, " " & float'image(tabP(i).x) & "," & float'image(tabP(i).y) & " ");
        end loop;

        put_line(file, """/>");
    end;

    procedure Svg_Header(filename : in string; Width, Height : Integer) is
    begin
        Create (File => file, Mode => Out_File, Name => filename);
        Put_line(file, "<svg width=""" & integer'image(Width) & 
                    """ height=""" & integer'image(Height) & """>");
        Display_Width := Float(Width);
        Display_Height := Float(Height);
    end Svg_Header;

    procedure Svg_Footer is
    begin
        Put_Line(file, "</svg>");
        close(file);
    end Svg_Footer;

end Svg;
