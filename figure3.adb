with struct;
with Ada.Integer_Text_IO;
with Ada.Text_IO; 
use struct; 
use Ada.Text_IO; 
use Ada.Integer_Text_IO;

procedure figure3 is
	a, b, c, d, Petit5, Grand5, Petit2, Grand2, Petit1, Grand1 : Arbre;
begin
	a := new noeud;
	a.C := 5;
	a.Compte := 1;
	Inserer(a,2);
	Inserer(a,3);
	Inserer(a,1);
	Inserer(a,6);
	b:=Rechercher(a,2);
	c:=Rechercher(a,1);
	d:=Rechercher(a,6);
	Put(a.Compte);New_Line;Put(b.Compte);New_Line;Put(c.Compte);Put(d.Compte);
	New_Line;
	New_Line;
	Noeuds_Voisins(a,Petit5,Grand5);
	Put("On obtient pour Noeuds_Voisins de 5 : ");Put(Petit5.C);Put(Grand5.C);
	New_Line;
	Noeuds_Voisins(b,Petit2,Grand2);
	Put("On obtient pour Noeuds_Voisins de 2 : ");Put(Petit2.C);Put(Grand2.C);
New_Line;
Noeuds_Voisins(c,Petit1,Grand1);
Put("On obtient pour Noeuds_Voisins de 1 : ");Put(Grand1.C);
end;
