using DrWatson
@quickactivate "OverturningCells"
using Printf

include(srcdir("isca.jl"))

prj = "/n/holyscratch01/kuang_lab/nwong/OverturningCells/data"

for Ωlog = -2 : 0.2 : 1, radii = 0.5 : 0.1 : 2

    if iszero(Ωlog); Ωlog = -0.01 end
    Ωstr = @sprintf("omegalog%03.1f",Ωlog)
    rstr = @sprintf("radius%03.1f",radii)
    streamfunctioninit(prjpath=prj,config="$(rstr)-$(Ωstr)");

end

for Ωlog = -2 : 0.1 : 1

    if iszero(Ωlog); Ωlog = -0.01 end
    Ωstr = @sprintf("omegalog%03.1f",Ωlog)
    streamfunctioninit(prjpath=prj,config="radius1.0-$(Ωstr)")

end
