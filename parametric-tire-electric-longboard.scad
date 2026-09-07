/* =========================================================
   PROJEKT OPONY TPU DO ROZKRĘCANEJ FELGI - WERSJA HYBRYDOWA
   (Zaktualizowany promień i grubość, 4 Rowki wzdłużne + V + Kostki)
   ========================================================= */

// --- PARAMETRY OPONY (w milimetrach) ---
promien_felgi = 46.2;  // Lekko powiększony otwór (po skurczu da ok. 91.1mm)
szer_wew = 43;
gl_wew = 7;
szer_zew = 50;
grubosc_zew = 19;      // Opona cieńsza o 1 mm

// --- PARAMETRY BIEŻNIKA ---
ilosc_rowkow = 24;   
gl_rowkow = 2.5;     
gl_bieznika = 3.5;   

$fn = 120;
R_out = promien_felgi + gl_wew + grubosc_zew;

// Moduł cięcia z wbudowanymi kątami "podporowymi" dla FDM
module fdm_cut(depth, w, l) {
    rotate([0, 90, 0])
    linear_extrude(height = depth*2, center = true)
    polygon([
        [l/2, 0],
        [0, w/2],
        [-l/2, 0],
        [0, -w/2]
    ]);
}

module opona_tpu() {
    difference() {
        // 1. GŁÓWNA BRYŁA OPONY (Zaokrąglone ranty + 4 ROWKI WZDŁUŻNE)
        rotate_extrude() {
            polygon(points=[
                [promien_felgi, szer_wew/2],
                [promien_felgi, -szer_wew/2],
                [promien_felgi + gl_wew, -szer_wew/2],
                [promien_felgi + gl_wew, -szer_zew/2],
                
                // --- ZAOKRĄGLENIE RANTU DOLNEGO ---
                [R_out - 3, -szer_zew/2],
                [R_out - 1.5, -szer_zew/2 + 0.5],
                [R_out - 0.5, -szer_zew/2 + 1.5],
                [R_out, -szer_zew/2 + 3],        
                
                // --- 4 ROWKI WZDŁUŻNE (Kąty 45 stopni pod FDM) ---
                [R_out, -19],               
                [R_out - gl_rowkow, -16.5],
                [R_out - gl_rowkow, -15.5],
                [R_out, -13],                
                
                [R_out, -9],                
                [R_out - gl_rowkow, -6.5],  
                [R_out - gl_rowkow, -5.5],  
                [R_out, -3],                
                
                [R_out, 3],                 
                [R_out - gl_rowkow, 5.5],   
                [R_out - gl_rowkow, 6.5],   
                [R_out, 9],                 
                
                [R_out, 13],                
                [R_out - gl_rowkow, 15.5],  
                [R_out - gl_rowkow, 16.5],  
                [R_out, 19],   
                
                // --- ZAOKRĄGLENIE RANTU GÓRNEGO ---
                [R_out, szer_zew/2 - 3],
                [R_out - 0.5, szer_zew/2 - 1.5],
                [R_out - 1.5, szer_zew/2 - 0.5],
                [R_out - 3, szer_zew/2],
                
                [promien_felgi + gl_wew, szer_zew/2]                       
            ]);
        }
        
        // 2. KIERUNKOWY BIEŻNIK POPRZECZNY
        for(i = [0 : ilosc_rowkow - 1]) {
            rotate([0, 0, i * (360 / ilosc_rowkow)]) {
                
                // --- CENTRUM: Kierunkowy wzór "V" ---
                translate([R_out, 0, 9])
                    rotate([40, 0, 0])
                    fdm_cut(gl_bieznika + 1, 4, 25);
                    
                translate([R_out, 0, -9])
                    rotate([-40, 0, 0])
                    fdm_cut(gl_bieznika + 1, 4, 25);
                    
                // --- BOKI: Masywne kostki terenowe (Shoulder Lugs) ---
                rotate([0, 0, 180 / ilosc_rowkow]) {
                    
                    translate([R_out, 0, 20])
                        rotate([15, 0, 0])
                        fdm_cut(gl_bieznika + 1.5, 4.5, 16);
                        
                    translate([R_out, 0, -20])
                        rotate([-15, 0, 0])
                        fdm_cut(gl_bieznika + 1.5, 4.5, 16);
                }
            }
        }
    }
}

// Generowanie modelu
opona_tpu();