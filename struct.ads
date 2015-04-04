package struct is

	type Noeud ;
	type Arbre is access Noeud ;
	type Direction is (Gauche , Droite) ;
	type Tableau_Fils is array ( Direction ) of Arbre ;
	type Noeud is record
		C : Integer ;
		Fils : Tableau_Fils ;
		Pere : Arbre ;
		Compte : Positive ;
	end record ;

	procedure inserer(a:in out arbre; e:Integer);
	procedure supprimer(Ptracine : in out arbre ; e : Integer);
	function rechercher (a:in arbre; e:Integer) return Arbre;

end struct ;
