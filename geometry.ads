package geometry is

    type Point is record
        X : Float;
        Y : Float;
    end record;

    type Segment is record
        P1 : Point;
        P2 : Point;
    end record;

    type TableauPoints is array(Integer range <>) of Point;

end geometry;
