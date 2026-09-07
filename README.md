# 🛞 Parametric TPU Tire for Electric Longboards

<div align="center">
  <img width="300" alt="parametric-tire-3d" src="https://github.com/user-attachments/assets/e7ff0c61-0d91-48d1-a715-55a70dd3a8b7" style="margin: 0 10px;" />
  <img width="300" alt="parametric-tire" src="https://github.com/user-attachments/assets/0407e92f-e4cc-4faa-9ab1-bd98d99b7b56" style="margin: 0 10px;" />
</div>
<br>

A customizable, 3D-printable TPU tire designed specifically for electric longboards, mountainboards, and DIY off-road vehicles using split rims. 

Written in OpenSCAD, this model features an aggressive **hybrid tread pattern** (longitudinal grooves + directional V-tread + shoulder lugs).

## 📏 Default Dimensions
Based on the default parameters in the OpenSCAD file, the generated tire has the following physical dimensions (before material shrinkage):

* **Outer Diameter:** ~144.4 mm
* **Inner Diameter (Rim Fit):** ~92.4 mm *(Designed to shrink to approx. 91.1 mm after cooling)*
* **Total Tire Width:** 50 mm
* **Inner Rim Bed Width:** 43 mm
* **Tire Profile Thickness:** 19 mm

## ✨ Features
* **Supportless Printing:** All tread grooves and lugs use 45-degree chamfers, meaning you can print this entirely without supports.
* **Fully Parametric:** Easily adjust rim diameter, tire width, thickness, and tread depth in the OpenSCAD file to fit your specific hubs.
* **All-Terrain Design:** Built for grip on both pavement and light off-road trails.

## 🖨️ Recommended Print Settings
To get the best ride quality and durability out of this tire, follow these guidelines:

* **Material:** TPU (85A to 95A hardness works best - e.g., Rosa3D or similar)
* **Layer Height:** 0.2 mm - 0.28 mm
* **Walls/Perimeters:** 4-6 (for structural strength)
* **Infill:** **100% Solid (MANDATORY)** - The tire must be printed completely solid. Sparse infill patterns will cause the tire to collapse or tear under the weight, torque, and lateral forces of an electric longboard.
  * *Pro-Tip for 100% TPU:* Use a criss-cross infill pattern (like *Rectilinear* or *Lines* with alternating angles, e.g., 45° and -45°). To maximize durability, the infill lines should not stack perfectly on top of each other vertically. Ensure your slicer slightly offsets (shifts) the paths laterally on subsequent layers. This creates a tightly interwoven internal structure that significantly increases strength while preventing material buildup, bulging, and nozzle clogs common with solid TPU.
* **Supports:** NONE 
* **Cooling:** 100% (Crucial for steep overhangs in the tread)


## ⚠️ Note on Material Shrinkage
Flexible materials like TPU tend to shrink slightly after printing and cooling down. 

* The default `rim_radius` parameter in the OpenSCAD file (46.2 mm) is already slightly enlarged to compensate for this shrinkage, ensuring a tight, secure fit on a standard split rim once cooled. 
* If your printed tire ends up too tight or too loose for your specific hubs, you can either adjust the `rim_radius` variable directly in the code or scale the final STL model by 1-2% on the X and Y axes in your slicer.

* This project is open-source and provided strictly for personal, educational, and non-commercial purposes. You are free to explore, modify, and learn from the codebase. If you wish to use this project for commercial purposes, please contact me.
