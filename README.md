Tutorial: Understanding Data Chunking 
===
Demo for Edu Pilot

[![DOI](https://zenodo.org/badge/629057707.svg)](https://zenodo.org/badge/latestdoi/629057707)


<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/80x15.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.

Date: April 27, 2023

Authors: Lina M. Estupinan-Suarez, Felix Cremer, Fabian Gans 

Affiliation: Max Planck Institute for Biogeochemistry

In this tutorial we showed the importance of data chunking when working with spatio-temporal gridded data sets. This is relevant because data sets for the Earth system sciences are getting larger and larger and they can no longer be completely loaded into working memory. Moreover, the number of input/output operations should be minimized to avoid limiting computation speed when data have to be accessed on disk. Complementary, more and more data is also available in the cloud and needs to be made cloud compatible.

Here we used a global data set of air temperature at 2 m above the ground (T) from 1979 to 2021 at 0.25° produced by ERA5. We have previously generated two files of the same variable T but with different chunking configurations. Thus, one file has a spatial chunking that facilitates access to the data and the process for spatial analyses. The second file has intermediate chunking that has a good compromise between spatial and temporal analyses.  The programming language used for the tutorial is Julia.

In brief, the tutorial shows:
* How to load files with different chunks and explore their properties.
* It computes global per-pixel statistics and time steps, and compares the performance of data processing for different chunks.
* It demonstrates the relevance of chunking when processing data for different data axes (i.e. time, space).

The tutorial includes short boxed summaries as take-home messages to highlight key points. An additional Julia file is included for supporting plotting figures and maps.

This work was funded by NDFI4Earth Educational Pilots.
