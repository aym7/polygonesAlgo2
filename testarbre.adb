with struct;
with Ada.Integer_Text_IO;
with Ada.Text_IO;  
use Ada.Text_IO; 
use Ada.Integer_Text_IO;

-- TEST des fonctions de l'arbre avec des integer
procedure testArbre is
    function "<"(Comp1, Comp2 : integer) return boolean is
    begin
	return Comp1 <= Comp2;
    end;

    package abr is new struct(integer, "<");
    use abr;

	a : arbre; b:arbre; petit : arbre; grand : arbre;
begin

	Put("Ordre voulu : 1 2 3 4 5 6 7 2");
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
	Put(a.all.Compte);
	Inserer(a,4);
	Put(a.all.Compte);
	Inserer(a,9);
	Put(a.all.Fils(Droite).all.Compte);
	Inserer(a,10);
	Inserer(a,12);
	Inserer(a,20);
	Inserer(a,39);
	Inserer(a,24);
	Inserer(a,15);
	Inserer(a,1);
	Inserer(a,19);
	Inserer(a,23);
	Inserer(a,3);
	New_Line;
	New_Line;
	Put("Racine :                    ");
	Put(a.all.C);
	New_Line;
	Put("Premier étage :        ");
	Put(a.all.Fils(Gauche).all.C);
	Put(a.all.Fils(Droite).all.C);
	New_Line;
	Put("Deuxième étage :  ");
	Put(a.all.Fils(Gauche).all.Fils(Gauche).C);
	Put(a.all.Fils(Droite).all.Fils(Gauche).C);
	Put(a.all.Fils(Droite).all.Fils(Droite).C);
	a := Rechercher(a,20);
	Noeuds_Voisins(a,petit,grand);
	New_Line;
	New_Line;
	Put("Les voisins de 20 sont : "); Put(petit.all.C); Put(grand.all.C);
end ;