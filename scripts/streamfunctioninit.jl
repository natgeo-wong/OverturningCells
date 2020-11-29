using DrWatson
@quickactivate "OverturningCells"

include(srcdir("isca.jl"))

prj = "/n/holyscratch01/kuang_lab/nwong/OverturningCells/data"

streamfunctioninit(prjpath=prj,config="control");
streamfunctioninit(prjpath=prj,config="omega00d1");
streamfunctioninit(prjpath=prj,config="omega00d2");
streamfunctioninit(prjpath=prj,config="omega00d5");
streamfunctioninit(prjpath=prj,config="omega02d0");
streamfunctioninit(prjpath=prj,config="omega05d0");
streamfunctioninit(prjpath=prj,config="omega10d0");
