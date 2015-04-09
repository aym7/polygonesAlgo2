generic
type Type_Clef is private;

package struct is

    function "<"(Comp1,Comp2 : Type_Clef) return Boolean;
    type Point is record
        X : Float;
        Y : Float;
    end record;

    type Segment is record
        P1 : Point;
        P2 : Point;
    end record;

    type TableauPoints is array(Integer range <>) of Point;

    type Noeud ;
    type Arbre is access Noeud ;
    type Direction is (Gauche , Droite) ;
    type Tableau_Fils is array ( Direction ) of Arbre ;
    type Noeud is record
        C : Type_Clef ;
        Fils : Tableau_Fils ;
        Pere : Arbre ;
        Compte : Positive ;
    end record ;

    procedure Inserer(Ptracine : in out arbre; Clef : Type_Clef);

    function Rechercher (Ptracine : in arbre; Clef : Type_Clef) return Arbre;

    procedure Supprimer(Ptracine : in out arbre ; Clef : Type_Clef);

    procedure Noeuds_Voisins(Cible : Arbre ; Petit_Voisin, Grand_Voisin : out Arbre);

    procedure Compte_Position(Cible : Arbre ; Nb_Petits, Nb_Grands : out Natural);

end struct ;
