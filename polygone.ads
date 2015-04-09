with Struct; 
with Geometry; use Geometry;
package Polygone is
    function "<"(Comp1,Comp2 : integer) return Boolean;
    function "<"(Comp1,Comp2 : Segment) return Boolean;
    -- détermination du type du package générique
    --	package abr is new struct(integer, "<");
    package abr is new struct(Segment, "<");
    use abr;

    function pointAvant(p1, p2 : Point) return boolean;
    function nbSeg (indP : integer; commencant : boolean; tabP : TableauPoints) return natural;
    procedure traitementPoint(indP : integer; a : arbre; tabP : TableauPoints);
    procedure traitement(abr : arbre; tabP : TableauPoints);
end Polygone;
