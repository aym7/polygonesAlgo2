with struct;
with geometry; use geometry;
with Ada.Integer_Text_IO;
with Ada.Text_IO; 
use Ada.Text_IO; 
use Ada.Integer_Text_IO;

-- TEST des fonctions noeuds_voisins et compte_position avec des integer
-- l'exemple utilisé est le meme que celui du sujet afin de 
-- pouvoir vérifier les résultats
procedure testNoeudsCompte is
    function "<"(Comp1, Comp2 : integer) return boolean is
    begin
	return Comp1 <= Comp2;
    end;

    package abr is new struct(integer, "<");
    use abr;

	a, b, c, d, Petit5, Grand5, Petit2, Grand2, Petit1, Grand1, Petit6, Grand6 : Arbre;
	NbPetits5, NbGrands5, NbPetits2, NbGrands2, NbPetits1, NbGrands1, NbPetits6, NbGrands6 : Natural;
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


	Put_Line("Les comptes de 5, 2, 1, et 6 sont : ");
	Put(a.Compte);New_Line;Put(b.Compte);New_Line;Put(c.Compte);Put(d.Compte);


	New_Line;New_Line;
	Noeuds_Voisins(a,Petit5,Grand5);
	Put("On obtient pour Noeuds_Voisins de 5 : ");Put(Petit5.C);Put(Grand5.C);
	New_Line;
	Noeuds_Voisins(b,Petit2,Grand2);
	Put("On obtient pour Noeuds_Voisins de 2 : ");Put(Petit2.C);Put(Grand2.C);
	New_Line;
	Noeuds_Voisins(c,Petit1,Grand1);
	Put("On obtient pour Noeuds_Voisins de 1 :  ");Put("      Null");Put(Grand1.C);
	New_Line;
	Noeuds_Voisins(c,Petit6,Grand6);
	Put("On obtient pour Noeuds_Voisins de 6 :  ");Put(Petit6.C);Put("      Null");
	New_Line;New_Line;

	Compte_Position(a,NbPetits5,NbGrands5);
	Compte_Position(b,NbPetits2,NbGrands2);
	Compte_Position(c,NbPetits1,NbGrands1);
	Compte_Position(d,NbPetits6,NbGrands6);

	Put("On obtient pour Compte_Position de 5 : ");Put(NbPetits5);Put(NbGrands5);
	New_Line;
	Put("On obtient pour Compte_Position de 2 : ");Put(NbPetits2);Put(NbGrands2);
	New_Line;
	Put("On obtient pour Compte_Position de 1 : ");Put(NbPetits1);Put(NbGrands1);
	New_Line;
	Put("On obtient pour Compte_Position de 6 : ");Put(NbPetits6);Put(NbGrands6);

end;
