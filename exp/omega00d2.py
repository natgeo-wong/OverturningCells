import os
import numpy as np
import f90nml
from isca import IscaCodeBase, DiagTable, Experiment, Namelist, GFDL_BASE, GFDL_DATA

from omega01d0 import earth_omega

NCORES = 32
RESOLUTION = 'T85', 30

base_dir = os.path.dirname(os.path.realpath(__file__))
# a CodeBase can be a directory on the computer,
# useful for iterative development
cb = IscaCodeBase.from_directory(GFDL_BASE)

# or it can point to a specific git repo and commit id.
# This method should ensure future, independent, reproducibility of results.
# cb = DryCodeBase.from_repo(repo='https://github.com/isca/isca', commit='isca1.1')

# compilation depends on computer specific settings.  The $GFDL_ENV
# environment variable is used to determine which `$GFDL_BASE/src/extra/env` file
# is used to load the correct compilers.  The env file is always loaded from
# $GFDL_BASE and not the checked out git repo.

cb.compile()  # compile the source code to working directory $GFDL_WORK/codebase

# create an Experiment object to handle the configuration of model parameters
# and output diagnostics

exp = Experiment('omega00d2', codebase=cb)

#Add any input files that are necessary for a particular experiment.
#exp.inputfiles = [os.path.join(GFDL_BASE,'input/land_masks/era_land_t42.nc'),os.path.join(GFDL_BASE,'input/rrtm_input_files/ozone_1990.nc'),
#                      os.path.join(base_dir,'input/ami_qflux_ctrl_ice_4320.nc'), os.path.join(base_dir,'input/siconc_clim_amip.nc')]

#Tell model how to write diagnostics
diag = DiagTable()
diag.add_file('atmos_daily', 1, 'days', time_units='days')

#Tell model which diagnostics to write
diag.add_field('dynamics', 'ps', time_avg=True)
diag.add_field('dynamics', 'bk')
diag.add_field('dynamics', 'pk')
diag.add_field('dynamics', 'vor', time_avg=True)
diag.add_field('dynamics', 'vcomp', time_avg=True)
diag.add_field('dynamics', 'temp', time_avg=True)
diag.add_field('mixed_layer', 't_surf', time_avg=True)
diag.add_field('atmosphere', 'precipitation', time_avg=True)

exp.diag_table = diag

#Empty the run directory ready to run
exp.clear_rundir()

#Define values for the 'core' namelist
exp.namelist = f90nml.read('namelist.nml')
exp.set_resolution(*RESOLUTION)

exp.update_namelist({
    'constants_nml': {
        'omega' : earth_omega * 0.2
    }
})

#Define Restart File
spinup_fin = os.path.join(GFDL_DATA,'spinup/restarts/res0002.tar.gz')

#Lets do a run!
if __name__=="__main__":
    exp.run(1, use_restart=True, restart_file=spinup_fin, num_cores=NCORES)
    for i in range(2,12):
        exp.run(i, num_cores=NCORES)
