with geometry;
use geometry;

package Parseur is

    procedure lectureEnTete (filename : in String; Nbsommets : out Natural);

    procedure lecture (filename : in String; Sommets : in out TableauPoints);

end parseur;
