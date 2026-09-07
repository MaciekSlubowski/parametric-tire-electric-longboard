

A customizable, 3D-printable TPU tire designed specifically for electric longboards, mountainboards, and DIY off-road vehicles using split rims. 
<img width="657" height="697" alt="parametric-tire-3d" src="https://github.com/user-attachments/assets/e7ff0c61-0d91-48d1-a715-55a70dd3a8b7" />
<img width="561" height="709" alt="parametric-tire" src="https://github.com/user-attachments/assets/0407e92f-e4cc-4faa-9ab1-bd98d99b7b56" />

Written in OpenSCAD, this model features an aggressive **hybrid tread pattern** (longitudinal grooves + directional V-tread + shoulder lugs) 

## ✨ Features
* **Supportless Printing:** All tread grooves and lugs use 45-degree chamfers, meaning you can print this entirely without supports.
* **Fully Parametric:** Easily adjust rim diameter, tire width, thickness, and tread depth in the OpenSCAD file to fit your specific hubs.
* **All-Terrain Design:** Built for grip on both pavement and light off-road trails.

## 🖨️ Recommended Print Settings
To get the best ride quality and durability out of this tire, follow these guidelines:

* **Material:** TPU (85A to 95A hardness works best - e.g., Rosa3D or similar)
* **Layer Height:** 0.2 mm - 0.28 mm
* **Walls/Perimeters:** 4-6 (for structural strength)
* **Infill:** 15% - 25% **Gyroid** (Gyroid infill acts like an air cushion, providing excellent shock absorption)
* **Supports:** NONE 
* **Cooling:** 100% (Crucial for steep overhangs in the tread)

## 🖨️ Recommended Print Settings & Setup

For maximum durability and performance on an electric longboard, this tire is designed to be printed as a solid block. A 3D printer equipped with a **Direct Drive extruder** is highly recommended for reliable extrusion of flexible filaments.

* **Material:** TPU 95A (Tested successfully with Rosa3D 95A)
* **Infill:** 100% (Solid infill ensures the tire can handle the weight and torque of an e-skate)
* **Layer Height:** 0.2 mm - 0.28 mm
* **Walls/Perimeters:** 4-6
* **Supports:** NONE (The tread is designed with FDM-friendly 45° angles)

## ⚠️ Note on Material Shrinkage
Flexible materials like TPU tend to shrink slightly after printing and cooling down. 

* The default `rim_radius` parameter in the OpenSCAD file (46.2 mm) is already slightly enlarged to compensate for this shrinkage, ensuring a tight, secure fit on a standard split rim once cooled. 
* If your printed tire ends up too tight or too loose for your specific hubs, you can either adjust the `rim_radius` variable directly in the code or scale the final STL model by 1-2% on the X and Y axes in your slicer.

* This project is open-source and provided strictly for personal, educational, and non-commercial purposes. You are free to explore, modify, and learn from the codebase. If you wish to use this project for commercial purposes, please contact me.
