using IscaTools

function streamfunctioninit(;
    prjpath::AbstractString,
    config::AbstractString
)

    init,iroot = iscastartup(
        prjpath=prjpath,config=config,
        fname="atmos_monthly",welcome=false
    );

    iscastreamfunction(init,iroot);

end

function getzonalmean(;
    prjpath::AbstractString,
    config::AbstractString,
    modID::AbstractString,
    parID::AbstractString,
    irun::Integer
)

    init,iroot = iscastartup(
        prjpath=prjpath,config=config,
        fname="atmos_monthly",welcome=false
    )

    _,ipar,_ = iscainitialize(init,modID=modID,parID=parID)

    ds,dvar = iscarawread(ipar,iroot;irun=irun)
    var = dropdims(mean(dsvar[:]*1,dims=1),dims=1)
    lat = ds["lat"][:]
    lvl = ds["pfull"][:]
    close(ds)

    return var,lat,lvl

end
