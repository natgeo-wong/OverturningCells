import os
import numpy as np
import f90nml
from isca import IscaCodeBase, DiagTable, Experiment, Namelist, GFDL_BASE, GFDL_DATA

NCORES = 32
RESOLUTION = 'T85', 30

cb = IscaCodeBase.from_directory(GFDL_BASE)
cb.compile()

earth_omega  = 7.292e-5
earth_radius = 6376.0e3

diag = DiagTable()
diag.add_file('atmos_daily', 1, 'days', time_units='days')
diag.add_field('dynamics', 'ps', time_avg=True)
diag.add_field('dynamics', 'bk')
diag.add_field('dynamics', 'pk')
diag.add_field('dynamics', 'vor', time_avg=True)
diag.add_field('dynamics', 'div', time_avg=True)
diag.add_field('dynamics', 'ucomp', time_avg=True)
diag.add_field('dynamics', 'vcomp', time_avg=True)
diag.add_field('dynamics', 'temp', time_avg=True)

exp = Experiment('drycore/spinup', codebase=cb)
exp.set_resolution(*RESOLUTION)
exp.clear_rundir()
exp.diag_table = diag
exp.namelist   = f90nml.read('namelistdryc.nml')

exp.run(1, num_cores=NCORES, use_restart=False, overwrite_data=True)
