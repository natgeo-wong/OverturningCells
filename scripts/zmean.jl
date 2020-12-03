using DrWatson
@quickactivate "OverturningCells"
using Printf

include(srcdir("zmean.jl"))

prjpath = "/n/holyscratch01/kuang_lab/nwong/OverturningCells/data"

for Ωlog = -2 : 0.2 : 1, radii = 0.5 : 0.5 : 2

    if iszero(Ωlog); Ωlog = -0.01 end
    Ωstr = @sprintf("omegalog%03.1f",Ωlog)
    rstr = @sprintf("radius%03.1f",radii)
    zmeantair(prjpath,"$(rstr)-$(Ωstr)")
    zmeanucomp(prjpath,"$(rstr)-$(Ωstr)")
    zmeanpsivall(prjpath,"$(rstr)-$(Ωstr)")

end

for Ωlog = -2 : 0.1 : 1

    if iszero(Ωlog); Ωlog = -0.01 end
    Ωstr = @sprintf("omegalog%03.1f",Ωlog)
    zmeantair(prjpath,"radius1.0-$(Ωstr)")
    zmeanucomp(prjpath,"radius1.0-$(Ωstr)")
    zmeanpsivall(prjpath,"radius1.0-$(Ωstr)")

end
