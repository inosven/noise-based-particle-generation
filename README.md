# Noise-based realistic particle generation

This instruction describes a set of MATLAB codes that includes the following three commonly used noise algorithms and the generation of realistic particle based on them:

- Value noise
- Perlin noise
- Worley noise

#### Instructions for the MATLAB codes

The folder `Noise function` holds the codes for the 2D and 3D functions of three noise algorithms, such as `Perlinnoise2D.m` and `Perlinnoise3D.m`. The folder `The base geometry` holds the base geometries which are used in the algorithms, such as `The base geometry\Sphere\Sphere_L6.stl`. Finally, copy all the MATLAB files (`*.m`) and STereoLithography files (`*.stl`) to a new working directory.

**Tips:** The noise function (`Valuenoise2D.m` or `Valuenoise3D.m`) used in these codes can be replaced with other noise functions for the corresponding dimension in the folder `Noise function`.

### 2D noise maps

Run `Plot_2Dnoise.m` to get four noise maps with pixels of 400 × 400, grid number of 10 × 10, and feature point number in the cell of 1 (set `m = 400`,`f = 10`,`n = 1`).

Run `Plot_2Dfractalnoise.m` to obtain a fractal noise map that is composed of a noise with 5 layers of frequency doubling and amplitude halving, superimposed with a low-frequency noise (set `q = 0.5`,`N = 5`).

<img title="Four noise maps" src="../Example_figures/Example_four%20noise%20maps.png" alt="Four noise maps" data-align="center" width="480">

### 2D particle shapes

Run `Generation_2Dparticleshape.m` to generate random 2D particle shapes based on 2D Value noise.

<img title="2D particle shape" src="../Example_figures/Example_2Dparticle%20shape.png" alt="2D particle shape" data-align="center" width="480">

### 3D particle shapes

Run `Generation_3Dparticleshape.m` to generate random 3D particle shapes from a sphere (set `fv=stlread('Sphere_L6.stl')`) based on 3D Value noise.

<img title="3D particle shape" src="../Example_figures/Example_3Dparticle%20shape.png" alt="3D particle shape" data-align="center" width="480">

### Realistic particle generation through noise superposition

Run `G3Dparticle_noisesuperposition.m` to superimpose 5 layers of high-frequency noise to generate realistic particles with complex surface features (set `N = 5`).

**Tips:** The base geometry used to generate 3D particles can be replaced with other simple geometries, such as an ellipsoid (set `fv=stlread('Ellipsoid.stl')`). Reference: `The base geometry\Simple geometry\Ellipsoid.stl`.

<img title="Particle generation through noise superposition" src="../Example_figures/Example_3Dparticle%20noisesuperposition.png" alt="Particle generation through noise superposition" data-align="center" width="480">

### Scanned particles as the base geometries

Run `G3Dparticle_scannedparticle.m` to normalize the size of a scanned particle and generate new realistic particles by superimposing noise on top of it. Reference: `The base geometry\Scanned particel\Ballast.stl`.

<img title="Scanned particles as the base geometries" src="../Example_figures/Example_3Dparticle%20scanned.png" alt="Scanned particles as the base geometries" data-align="center" width="480">
