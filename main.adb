with struct;
with Ada.Integer_Text_IO;
with Ada.Text_IO; 
use struct; 
use Ada.Text_IO; 
use Ada.Integer_Text_IO;

procedure main is
	a : arbre; b : arbre;
begin
	a := new noeud;
	a.C := 8;
	a.Fils(Droite) := Null;
	a.Fils(Gauche) := Null;
	Inserer(a,7);
	b := Rechercher(a,7);
	Put(b.all.C);
	Put(b.all.Pere.all.C);
end ;
