# **<div align="center">OverturningCells</div>**

This repository contains the analysis scripts and output for the **Overturning Cells** project, written in Julia.  We aim to investigate how planetary rotation rates can affect the number of cells in the overturning circulation of a planet.

**Created/Mantained By:** Nathanael Wong (nathanaelwong@fas.harvard.edu)

> Introductory Text Here.

## Progress
* [ ] Experimental Runs
   * [x] Earth-sized planets, varying rotation rates (0.1-10x Earth Ω)
   * [ ] Different-sized planet, if necessary

* [ ] Analysis
   * [ ] A basic analysis on the mean meridional overturning circulation
   * [ ] Derive a basic pattern for number of cells, and rotation rate, if any

## 0. Motivation

Text

## 1. Methodology

### A. Isca Model

Text

### B. Mean Meridional Overturning Circulation

Text

## 2. Results

## Installation

To (locally) reproduce this project, do the following:

0. Download this code base. Notice that raw data are typically not included in the
   git-history and may need to be downloaded independently.
1. Open a Julia console and do:
   ```
   julia> ] activate .
    Activating environment at `~/Projects/OverturningCells/Project.toml`

   (OverturningCells) pkg> instantiate
   (OverturningCells) pkg> add IscaTools#master
   ```

This will install all necessary packages for you to be able to run the scripts and
everything should work out of the box.

*(Note: You need to install the #master versions of IscaTools.jl as of now.)*

## **Other Acknowledgements**
> Project Repository Template generated using [DrWatson.jl](https://github.com/JuliaDynamics/DrWatson.jl) created by George Datseris.
