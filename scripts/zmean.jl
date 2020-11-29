using DrWatson
@quickactivate "MonsoonTilt"

include(srcdir("zmean.jl"))

prjpath = "/n/holyscratch01/kuang_lab/nwong/OverturningCells/data"

zmeanpsivall(prjpath,"control");
zmeanpsivall(prjpath,"omega00d1");
zmeanpsivall(prjpath,"omega00d2");
zmeanpsivall(prjpath,"omega00d5");
zmeanpsivall(prjpath,"omega02d0");
zmeanpsivall(prjpath,"omega05d0");
zmeanpsivall(prjpath,"omega10d0");

zmeantair(prjpath,"control");
zmeantair(prjpath,"omega00d1");
zmeantair(prjpath,"omega00d2");
zmeantair(prjpath,"omega00d5");
zmeantair(prjpath,"omega02d0");
zmeantair(prjpath,"omega05d0");
zmeantair(prjpath,"omega10d0");
