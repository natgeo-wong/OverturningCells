using IscaTools

function streamfunctioninit(;
    prjpath::AbstractString,
    config::AbstractString
)

    init,iroot = iscastartup(
        prjpath=prjpath,config=config,
        fname="atmos_daily",welcome=false
    );

    iscastreamfunction(init,iroot);

end
