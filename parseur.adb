with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Float_Text_Io; use Ada.Float_Text_Io;
with Struct;

package body Parseur is
	file : File_Type;

	--récupère le nombre de sommets
	procedure lectureEnTete (filename : in String; Nbsommets : out Natural) is
	begin
		Open (File => file, Mode => In_File, Name => filename);
		Get(file, NbSommets);
	end;

	--parcoure le fichier et récupère les données sur les points
	procedure lecture (filename : in String; nbP : natural; Sommets : in out TableauPoints) is 
	begin
		for i in Sommets'Range loop
			Get(file, Sommets(i).X);
			Get(file, Sommets(i).Y);
		end loop;

		Close(file);
	end;

end Parseur;
