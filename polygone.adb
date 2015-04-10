with Struct;
with Geometry; use Geometry;
with Svg;
with ada.text_io; use ada.text_io;

package body Polygone is

    function "<"(Comp1, Comp2 : integer) return boolean is
    begin
	return Comp1 <= Comp2;
    end;

    -- testée OK
    function "<"(Comp1,Comp2 : Segment) return boolean is
	height1, height2 : float;
    begin
	height1 := (comp1.P1.y + comp1.P2.y) / 2.0;
	height2 := (comp2.P1.y + comp2.P2.y) / 2.0;

	return height1 < height2;
    end;


    -- testée, OK
    -- retourne vrai si p1 avant (lexicographiquemement parlant) p2
    -- on s'en sert pour savoir si un segment commence ou non par un point
    function pointAvant(p1, p2 : Point) return boolean is
    begin
	return p1.x < p2.x or (p1.x = p2.x and p1.y < p2.y);
    end pointAvant;



    -- testée, OK
    -- renvoit le nombre de segment commencant/finissant par le point tabP(indP)
    function nbSeg (indP : integer; commencant : boolean; tabP : TableauPoints) return natural is
	nbS : natural := 0;
    begin
	if indP = tabP'first then
	    if pointAvant(tabP(indP), tabP(tabP'last)) then
		if commencant then
		    nbS := nbS +1;
		end if;
	    else
		if not commencant then
		    nbS := nbS +1;
		end if;
	    end if;
	else
	    if pointAvant(tabP(indP), tabP(indP-1)) then
		if commencant then
		    nbS := nbS +1;
		end if;
	    else
		if not commencant then
		    nbS := nbS +1;
		end if;
	    end if;
	end if;

	if pointAvant(tabP(indP), tabP( (indP+1) mod tabP'length)) then
	    if commencant then
		nbS := nbS +1;
	    end if;
	else
	    if not commencant then
		nbS := nbS +1;
	    end if;
	end if;

	return nbS; 
    end nbSeg;


    -- traitement d'un point
    -- dessine le segment si point de rebroussement et non-monotone
    procedure traitementPoint (indP : integer; tree : in out arbre; tabP : TableauPoints) is
	isRebroussement : boolean := false;
	n : arbre; -- "point de repère" pouisRebroussement le point courant
	seg : segment;
	vPetit, vGrand : arbre;
	cPetit, cGrand : natural;
	p : Point := tabP(indP);
    begin

	    -- si le point est un point de rebroussement 'initial'
	    if nbSeg(indP, true, tabP) = 2 then
		    isRebroussement := true;
		    seg := Segment'(p, p);
		    Inserer(tree , seg );
		    n := Rechercher(tree , seg );
		    Noeuds_Voisins(n, vPetit, vGrand);
		    Compte_Position(n, cPetit, cGrand);
		    Supprimer(tree , seg );
		    Put_Line("Point de rebroussement initial");
	    end if;


	    -- Enlever;
	    -- Ajouter;


	    -- si le point est un point de rebroussement 'terminal'
	    if nbSeg(indP, false, tabP) = 2 then
		    isRebroussement := true;
		    seg := Segment'(p, p);
		    Inserer(tree , seg );
		    n := Rechercher(tree , seg);
		    Noeuds_Voisins(n, vPetit, vGrand);
		    Compte_Position(n, cPetit, cGrand);
		    Supprimer(tree , seg );
		    Put_Line("Point de rebroussement terminal");
	    end if;

	    -- si on a un point de rebroussement...
	    if isRebroussement then
		    -- ... et que le polygone n'est pas monotone...
		    if (cPetit mod 2) = 1 or (cGrand mod 2) = 1 then
			    -- trace droite
			    -- récupération points pour reconnecter
			    put_line("Segment trouvé ! ");
			    declare
				    -- temporary
				    p1, p2 : Point; 
			    begin
				    p1 := Point'(p.x, 0.0);
				    p2 := Point'(p.x, 50.0);
				    svg.svg_line(p1, p2, Svg.Red);
			    end;
		    end if;
	    end if;
    end traitementPoint ;

    -- main treatment
    procedure traitement (tabP : TableauPoints) is
	    abr : Arbre := null;
    begin
	    -- la "droite" se déplace de point en point
	    for i in tabP'Range loop
		    put(integer'image(i));
		    traitementPoint(i, abr, tabP);
	    end loop;
    end traitement;

end Polygone;
