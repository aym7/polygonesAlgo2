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
	a.Compte := 1;
	Put(a.all.Compte);
	Inserer(a,7);
	Put(a.all.Compte);
	b := Rechercher(a,7);
	Inserer(a,6);
	Put(a.all.Compte);
	Inserer(a,11);
	Put(a.all.Compte);
	Inserer(a,2);
	Put(a.all.Compte);
	Inserer(a,5);
	Inserer(a,4);
	Put(a.all.Compte);
	Inserer(a,9);
	Inserer(a,10);
	Inserer(a,12);
	New_Line;
	New_Line;
	Put(a.all.Fils(Gauche).all.C);
	Put(a.all.Fils(Droite).all.C);
	New_Line;
	Put(a.all.Fils(Gauche).all.Fils(Gauche).C);
	Put(a.all.Fils(Droite).all.Fils(Gauche).C);
end ;
