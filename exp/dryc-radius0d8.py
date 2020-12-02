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
rscale = 0.8

diag = DiagTable()
diag.add_file('atmos_monthly', 50, 'days', time_units='days')
diag.add_field('dynamics', 'ps', time_avg=True)
diag.add_field('dynamics', 'bk')
diag.add_field('dynamics', 'pk')
diag.add_field('dynamics', 'ucomp', time_avg=True)
diag.add_field('dynamics', 'vcomp', time_avg=True)
diag.add_field('dynamics', 'temp', time_avg=True)

for oscale in np.arange(-2,1.1,0.2):

    rfol = 'radius'   + '{:03.1f}'.format(rscale)
    ofol = 'omegalog' + '{:03.1f}'.format(oscale)
    exp = Experiment(os.path.join('drycore',rfol+'-'+ofol), codebase=cb)
    exp.clear_rundir()
    exp.diag_table = diag
    exp.namelist   = f90nml.read('namelistdryc.nml')
    exp.set_resolution(*RESOLUTION)
    exp.update_namelist({
        'constants_nml': {
            'radius' : earth_radius * rscale,
            'omega'  : earth_omega  * (10 ** oscale)
        }
    })

    if __name__=="__main__":
        exp.run(1, use_restart=False, num_cores=NCORES)
        for i in range(2,12):
            exp.run(i, num_cores=NCORES)
