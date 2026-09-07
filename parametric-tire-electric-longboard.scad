/* =====================================================================
   PROJECT: TPU ALL-TERRAIN TIRE FOR SPLIT RIMS
   VERSION: HYBRID TREAD DESIGN
   
   DESCRIPTION:
   A parametric, 3D-printable TPU tire designed for electric longboards 
   or similar off-road vehicles using split rims. Features a hybrid 
   tread pattern with 4 longitudinal grooves, a directional V-tread, 
   and aggressive shoulder lugs. 
   
   FDM OPTIMIZED:
   All tread cuts utilize 45-degree angles to ensure clean, supportless 
   printing on standard FDM 3D printers.
   ===================================================================== */

// --- TIRE PARAMETERS (in millimeters) ---
rim_radius = 46.2;       // Slightly enlarged inner diameter (compensates for TPU shrinkage, yields ~91.1mm)
inner_width = 43;        // Width of the rim bed
inner_depth = 7;         // Depth of the rim bed fit
outer_width = 50;        // Total width of the tire
tire_thickness = 19;     // Thickness of the tire profile

// --- TREAD PARAMETERS ---
groove_count = 24;       // Number of transverse tread blocks
long_groove_depth = 2.5; // Depth of the continuous longitudinal grooves
tread_depth = 3.5;       // Depth of the V-tread and shoulder lugs

// --- RENDER SETTINGS ---
$fn = 120;               // High resolution for smooth curves
outer_radius = rim_radius + inner_depth + tire_thickness;

/* =====================================================================
   MODULES
   ===================================================================== */

/* 
 * fdm_cut: Generates a diamond-shaped cutting tool.
 * Uses 45-degree overhang angles so the tread grooves can be printed
 * cleanly without requiring support material.
 */
module fdm_cut(depth, w, l) {
    rotate([0, 90, 0])
    linear_extrude(height = depth * 2, center = true)
    polygon([
        [l / 2, 0],
        [0, w / 2],
        [-l / 2, 0],
        [0, -w / 2]
    ]);
}

/* 
 * tpu_tire: Main geometry of the tire.
 * Combines the rounded profile, longitudinal grooves, and the directional 
 * tread pattern using boolean difference.
 */
module tpu_tire() {
    difference() {
        
        // 1. MAIN TIRE BODY (Rounded edges + 4 Longitudinal Grooves)
        rotate_extrude() {
            polygon(points=[
                // --- INNER RIM FIT ---
                [rim_radius, inner_width / 2],
                [rim_radius, -inner_width / 2],
                [rim_radius + inner_depth, -inner_width / 2],
                [rim_radius + inner_depth, -outer_width / 2],
                
                // --- BOTTOM EDGE ROUNDING (Fillet) ---
                [outer_radius - 3, -outer_width / 2],
                [outer_radius - 1.5, -outer_width / 2 + 0.5],
                [outer_radius - 0.5, -outer_width / 2 + 1.5],
                [outer_radius, -outer_width / 2 + 3],        
                
                // --- 4 LONGITUDINAL GROOVES (45° chamfers for FDM) ---
                // Groove 1
                [outer_radius, -19],                
                [outer_radius - long_groove_depth, -16.5],
                [outer_radius - long_groove_depth, -15.5],
                [outer_radius, -13],                
                
                // Groove 2
                [outer_radius, -9],                
                [outer_radius - long_groove_depth, -6.5],  
                [outer_radius - long_groove_depth, -5.5],  
                [outer_radius, -3],                
                
                // Groove 3
                [outer_radius, 3],                  
                [outer_radius - long_groove_depth, 5.5],   
                [outer_radius - long_groove_depth, 6.5],   
                [outer_radius, 9],                  
                
                // Groove 4
                [outer_radius, 13],                
                [outer_radius - long_groove_depth, 15.5],  
                [outer_radius - long_groove_depth, 16.5],  
                [outer_radius, 19],    
                
                // --- TOP EDGE ROUNDING (Fillet) ---
                [outer_radius, outer_width / 2 - 3],
                [outer_radius - 0.5, outer_width / 2 - 1.5],
                [outer_radius - 1.5, outer_width / 2 - 0.5],
                [outer_radius - 3, outer_width / 2],
                
                [rim_radius + inner_depth, outer_width / 2]                        
            ]);
        }
        
        // 2. DIRECTIONAL TRANSVERSE TREAD PATTERN
        for(i = [0 : groove_count - 1]) {
            rotate([0, 0, i * (360 / groove_count)]) {
                
                // --- CENTER: Directional "V" pattern ---
                translate([outer_radius, 0, 9])
                    rotate([40, 0, 0])
                    fdm_cut(tread_depth + 1, 4, 25);
                    
                translate([outer_radius, 0, -9])
                    rotate([-40, 0, 0])
                    fdm_cut(tread_depth + 1, 4, 25);
                    
                // --- SIDES: Aggressive Off-Road Shoulder Lugs ---
                // Offset by half a step to interleave with the center V-pattern
                rotate([0, 0, 180 / groove_count]) {
                    
                    translate([outer_radius, 0, 20])
                        rotate([15, 0, 0])
                        fdm_cut(tread_depth + 1.5, 4.5, 16);
                        
                    translate([outer_radius, 0, -20])
                        rotate([-15, 0, 0])
                        fdm_cut(tread_depth + 1.5, 4.5, 16);
                }
            }
        }
    }
}

/* =====================================================================
   MODEL GENERATION
   ===================================================================== */
tpu_tire();