with Struct; 
with Geometry; use Geometry;
package Polygone is
	function "<"(Comp1,Comp2 : integer) return Boolean;
	package abr is new struct(integer, "<");
	use abr;

	function pointAvant(p1, p2 : Point) return boolean;
	function nbSeg (indP : integer; commencant : boolean; tabP : TableauPoints) return natural;
	procedure traitementPoint(p : point; a : arbre; tabP : TableauPoints);
	procedure traitement(abr : arbre; tabP : TableauPoints);
end Polygone;
