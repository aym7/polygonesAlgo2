with Struct;
with Geometry; use Geometry;
with Svg;
with ada.text_io; use ada.text_io;
package body Polygone is

    function "<"(Comp1, Comp2 : integer) return boolean is
    begin
	return Comp1 <= Comp2;
    end;

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
    procedure traitementPoint (p : point; a : arbre; tabP : TableauPoints) is
	--       r : boolean := false;
	--	n : arbre := a; -- CAREFUL : can be a problem (pointer)
	--       s : segment;
	--       vPetit, vGrand : arbre;
	--       cPetit, cGrand : natural;
    begin
	null;

	--       if nbSeg(p, true) = 2 then
	--           r := true;
	--           s := Segment'(p, p);
	--           Inserer(n, s);
	--           Noeuds_Voisins(n, vPetit, vGrand);
	--           Supprimer(a, n);
	--       end if;
	--       

	--       if nbSeg(p, false) = 2 then
	--           r := true;
	--           s := Segment'(p, p);
	--           Inserer(n, s);
	--           Noeuds_Voisins(n, vPetit, vGrand);
	--           Supprimer(a, n);
	--       end if;

	-- si on a un point de rebroussement, cela signifie qu'on peut
	-- tracer une droite en svg
	--       if r then
	--           if (cPetit mod 2) = 1 or (cGrand mod 2) = 1 then
	--		    put("toto");
	--               -- trace droite
	-- récupération points pour reconnecter
	-- declare
	-- -- solution temporaire en attendant de trouver la méthode pour récupérer les points
	-- p1, p2 : Point; 
	-- begin
	-- p1 := Point'(p.x, 0.0);
	-- p2 := Point'(p.x, 50.0);
	--svg.svg_line(p1, p2, Svg.Color'first);
	--end;
	--           end if;
	--       end if;
    end traitementPoint ;



    -- main treatment
    procedure traitement (abr : Arbre; tabP : TableauPoints) is
    begin
	for i in tabP'Range loop
	    traitementPoint(tabP(i), abr, tabP);
	end loop;

    end traitement;
end Polygone;
