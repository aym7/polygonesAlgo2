with geometry;
use geometry;

package Parseur is

    procedure lectureEnTete (filename : in String; Nbsommets : out Natural);

    procedure lecture (filename : in String; nbP : natural; Sommets : in out TableauPoints);

end parseur;
