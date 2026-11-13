/*
  Parametric TPU Tire for Electric Longboards
  -------------------------------------------
  A 3D-printable all-terrain tire for split rims (electric longboards,
  mountainboards and DIY off-road vehicles). The tread is a hybrid pattern:
  continuous longitudinal grooves, a directional V-tread in the centre and
  shoulder lugs on both edges.

  The tire prints flat (its axis vertical) in TPU without supports: the
  longitudinal grooves have 45° walls, and the transverse tread cuts are
  narrow diamonds, so their roofs slope steeply instead of hanging flat.

  All dimensions in millimetres.
  Coordinates:
  - Z is the axis of the tire (the print height). Z = 0 is the centre plane.
  - The cross-section is drawn in the X-Z plane (X = radius) and revolved
    around Z.

  Usage: adjust the parameters, render (F6) and export the STL (F7).
  A ready-made STL for the default dimensions is in the stl/ folder.
*/

/* [Rim fit] */
rim_radius = 46.2;          // Inner radius of the tire. Enlarged to compensate for TPU shrinkage [mm]
inner_width = 43;           // Width of the rim bed [mm]
inner_depth = 7;            // Height of the bead that sits in the rim bed, between the rim halves [mm]
shrinkage = 1.4;            // Measured TPU shrinkage, only used for the console report [%]

/* [Tire body] */
outer_width = 50;           // Total width of the tire [mm]
tire_thickness = 19;        // Thickness of the profile, from the top of the bead to the tread [mm]
edge_round = 3;             // Size of the rounded edges between the tread and the sidewalls [mm]

/* [Longitudinal grooves] */
// Centre of each groove, measured from the centre plane, in ascending order [mm]
groove_positions = [-16, -6, 6, 16];
groove_depth = 2.5;         // Depth of the grooves [mm]
groove_floor_width = 1;     // Width of the groove floor. The walls are at 45°, so the opening is this + 2 × groove_depth [mm]

/* [Tread pattern] */
tread_count = 24;           // Number of tread steps around the tire
// Centre V-tread: two diamond cuts that meet at the centre plane
v_depth = 4.5;              // Depth of the V cuts [mm]
v_offset = 9;               // Distance of each V arm from the centre plane [mm]
v_angle = 40;               // Tilt of each V arm from the axis of the tire [°]
v_length = 25;              // Length of a V arm [mm]
v_width = 4;                // Width of a V arm at its middle [mm]
// Shoulder lugs: diamond cuts across the edges, offset by half a step from the V
lug_depth = 5;              // Depth of the lug cuts [mm]
lug_offset = 20;            // Distance of each lug from the centre plane [mm]
lug_angle = 15;             // Tilt of each lug from the axis of the tire [°]
lug_length = 16;            // Length of a lug [mm]
lug_width = 4.5;            // Width of a lug at its middle [mm]

/* [Quality] */
$fn = 120;                  // Resolution of the revolved profile

/* [Hidden] */
// Rounded edge as [inset from the tread, distance from the sidewall],
// from the sidewall to the tread. Scaled from a 3 mm reference shape.
edge_shape = [[3, 0], [1.5, 0.5], [0.5, 1.5], [0, 3]] * edge_round / 3;

// ============================================================================
// DERIVED VALUES
// ============================================================================

bead_radius = rim_radius + inner_depth;             // Where the sidewalls start
outer_radius = bead_radius + tire_thickness;        // Tread surface
groove_half_opening = groove_floor_width / 2 + groove_depth;
tread_half_width = outer_width / 2 - edge_round;    // Flat part of the tread

assert(inner_width < outer_width, "inner_width must be smaller than outer_width");
assert(2 * edge_round < outer_width, "edge_round is too large for outer_width");
assert(edge_round < tire_thickness, "edge_round must be smaller than tire_thickness");
assert(max(groove_depth, v_depth, lug_depth) < tire_thickness,
       "The tread is deeper than tire_thickness");
for (i = [0 : len(groove_positions) - 1]) {
    c = groove_positions[i];
    assert(c - groove_half_opening >= -tread_half_width && c + groove_half_opening <= tread_half_width,
           str("Groove at ", c, " mm runs into the rounded edge"));
    if (i > 0)
        assert(c - groove_positions[i - 1] >= 2 * groove_half_opening,
               str("Groove at ", c, " mm overlaps the previous one (check the order)"));
}

echo(str("Tire: outer diameter ", 2 * outer_radius, " mm, inner diameter ", 2 * rim_radius,
         " mm (about ", round(2 * rim_radius * (1 - shrinkage / 100) * 10) / 10,
         " mm after ", shrinkage, "% shrinkage), width ", outer_width, " mm"));

// ============================================================================
// CROSS-SECTION
// ============================================================================

// One longitudinal groove centred at z, with 45° walls
function groove_points(z) = [
    [outer_radius,                z - groove_half_opening],
    [outer_radius - groove_depth, z - groove_floor_width / 2],
    [outer_radius - groove_depth, z + groove_floor_width / 2],
    [outer_radius,                z + groove_half_opening]
];

// Cross-section of the tire, traced from the rim bed (Z > 0) down to Z < 0,
// along the -Z sidewall, across the tread and back down the +Z sidewall.
function tire_profile() = concat(
    // Bead in the rim bed
    [[rim_radius,  inner_width / 2],
     [rim_radius, -inner_width / 2],
     [bead_radius, -inner_width / 2],
     [bead_radius, -outer_width / 2]],
    // Rounded edge on the -Z side
    [for (e = edge_shape) [outer_radius - e.x, -outer_width / 2 + e.y]],
    // Tread with the longitudinal grooves
    [for (z = groove_positions) each groove_points(z)],
    // Rounded edge on the +Z side (mirrored and reversed)
    [for (i = [len(edge_shape) - 1 : -1 : 0])
        [outer_radius - edge_shape[i].x, outer_width / 2 - edge_shape[i].y]],
    [[bead_radius, outer_width / 2]]
);

// ============================================================================
// TREAD CUTS
// ============================================================================

// Diamond-shaped cutter on the tread surface, at height z. The diamond is
// `length` long (along Z before the tilt) and `width` wide (around the tire),
// tilted by `angle` around the radius, and cut `depth` deep into the tread.
module tread_cut(z, angle, length, width, depth) {
    translate([outer_radius, 0, z])
        rotate([angle, 0, 0])
            rotate([0, 90, 0])
                linear_extrude(height = 2 * depth, center = true)
                    polygon([[length / 2, 0], [0, width / 2],
                             [-length / 2, 0], [0, -width / 2]]);
}

module tread_pattern() {
    for (i = [0 : tread_count - 1])
        rotate([0, 0, i * 360 / tread_count])
            for (side = [-1, 1]) {
                // Centre V-tread
                tread_cut(side * v_offset, side * v_angle, v_length, v_width, v_depth);
                // Shoulder lugs, interleaved with the V
                rotate([0, 0, 180 / tread_count])
                    tread_cut(side * lug_offset, side * lug_angle, lug_length, lug_width, lug_depth);
            }
}

// ============================================================================
// FINAL MODEL
// ============================================================================

module tire() {
    difference() {
        rotate_extrude()
            polygon(tire_profile());
        tread_pattern();
    }
}

tire();
