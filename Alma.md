https://tinmarino.github.io/?show=cosmo_obs_cheat

# Science

## Submillimetre astronomy

*  0.3 mm to 3.6 mm, 84 GHz to 950 GHz => a range of 10 around 1mm
* REsolution:
  * ALMA: 0.1''
  * Event Horizon Telescope: 25e-6 ''
* mm/sub-mm wavelength region are essential for investigating the coolest components of outer space such as cold and dusty molecular clouds, where star formation is occurring
* carbon monoxide rotational transition
  * between the first level and the ground state of the molecule from Messier 51 (=NGC5194).
  * The carbon monoxide is thought to represent the distribution of the molecular hydrogen, which cannnot emit at low temperatures.
* Broad band 16 GhZ wide

## Vocabulary: Optical Vs Radio


| Optical                      | Radio |
| ---                          | --- |
| OPD: Optical Path Difference | Delay, Lag |
| PSF: Point Spread Function   | Dirty Beam |
| Raw Image                    | Dirty Image |
| Differential piston          | Delay residual |
| Beam combiner                | Correlator |
| Strehl Ratio                 | Antena gain |
| Background level             | System temperature |
| Fringe tracking              | Phase referencing |
| Telescope                    | Antenna |
| Magnitude                    | Log (flux density) |
| Obscure band designation     | Confusing band designation |
| Adaptive Optic               | Phase Calibration |



## Emission

1. Discrete cosmic radio sources, at first, supernova remnants and radio galaxies
(1948; see Kirshner 2004),
2. The 21 cm line of atomic hydrogen (1951; see Sparke and Gallagher 2007;
Kalberla et al. , 2005),
3. Quasi Stellar Objects or “Quasars” (1963; see Begelman and Rees 2009),
4. The Cosmic Microwave Background (1965; see Silk 2008),
5. Interstellar molecules (1968; see Herbst and Dishoeck 2009) and the connection
with Star Formation, including circumstellar and protoplanetary disks (see
Stahler and Palla 2005; Reipurth et al. 2007),
6. Pulsars (1968; see Lyne and Graham-Smith 2012),
7. Distance determinations using source proper motions determined from Very
Long Baseline Interferometry (see Reid 1993),
8. The Sunyaev-Zeldovich effect (see, e.g. Marrone et al. 2012)
9. Gravitational Lenses
10. Molecules in high redshift sources (see Solomon and Vanden Bout 2005).

# Technic

## Calibration

1. Primary Calibration: use of a “known” standard source to determine time independent quantities e.g. B ij
2. Secondary Calibration: estimate local conditions with nearby calibrator
3. Self-Calibration: use of the target field to determine time dependent quantities, e.g. G ij

* Sources of error:
  * Atmosphere
    - Ionosphere
    - Troposphere
    - water vapor
  * Antenna/feed
    - System temperature
    - Primary beam
    - Pointing
    - Position (location)
  * LNA+conversion chain
    - Clock
    - Gain, phase, delay
    - Frequency response
  * Digitiser/Correlator
    - Auto-leveling
    - Baseline errors


## Reduction

All deconvolution methods supply missing information.
* CLEAN does this by saying that sky is point sources.
* MEM demands that the smoothest map consistent with the data is the most likely

### Vocabulary

* Dirty beam: Point spread function: inverse Fourier transform of the aperture
* Dirty image: Image not reduced: ∬ S(u, v)V(u, v)exp[2iπ(ul+vm)]dldm

### MEM: Maximum Entropy Method

Bayesian strategy that selects one image among many feasible.
Since the data is noisy and incomplete, the solution space is first
reduced choosing those images that fit the measured visibilities to
within noise level. Among these, the Bayesian strategy selects the
one that has a maximum probability of being observed according to
a counting rule 

### Clean

* https://en.wikipedia.org/wiki/CLEAN_(algorithm)
* CLEAN heuristic (Hogbom, 1974). This algorithm is based on the dirty image/beam representation of the problem (Algorithm A), which results in a deconvolution problem 
* The algorithm assumes that the image consists of a number of point sources. It will iteratively find the highest value in the image and subtract a small gain of this point source convolved with the point spread function ("dirty beam") of the observation, until the highest value is smaller than some threshold. 

#### CLEAN ideas

The family of CLEAN algorithms is based on the a priori assumption that the sky intensity distribution is a collection of point sources. The algorithms have three main steps

##### 1. Initialization
* of the residual map to the dirty map;
* and of the clean component list to a NULL (i.e. zero) value.

The clean beam is usually a fit of the main lobe (i.e. the inner part) of the dirty beam


##### 2. Iterative search
* for point sources on the residual map. As those point sources are found,
* they are subtracted from the residual map;
* and then they are logged in the clean component list.

##### 3. Restoration
* of the clean map
  1. by convolution of the clean component list with the clean beam, i.e. a Gaussian whose size matches the synthesized beam size and
  2. by addition of the residual map

* The final addition of the residual map plays a double role. First, it is a first order correction to insufficient deconvolution. Second, it enables noise estimate on the cleaned image since the residual image should be essentially noise when the deconvolution has converged.

 
 
## Antenas

* 54x12m + 12x7m = 66 antenas
* 100 micro-metter -> 1 milli-meter = 100 GHz
* Pointing precision: 0.6 arcseconds


## Receiver

* 4°K cryostats
* Example: The Parkes multibeam receiver
* Feed Horn -> Cables -> Receiver / Amplifier -> Recording device


## Optic fiber

## Correlator

## Interferometry

* Optical resolution: θ=206000λ/D, 
* phase closure to correct seeing: (3 antenas)
* “amplitude  closure (4 antenas)
* phase tracking: real time, time dealys correction

## Transporters



# Links:

* ESO: Eris: https://www.eso.org/sci/meetings/2015/eris2015/program.html
* 2018_Tool_Of_Radio_Astro
* 2017_Book_Interferometry_And_Synthesis_In_RA
