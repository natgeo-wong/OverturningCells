using ClimateERA
using Dates
using JLD2
using IscaTools
using Logging
using Statistics

function zmeantair(
    prjpath::AbstractString,
    config::AbstractString
)

    @info "$(Dates.now()) - Beginning compilation of zonal-mean AIR TEMPERATURE data for CONFIG $(uppercase(config))..."
    init,iroot = iscastartup(
        prjpath=prjpath,config=config,
        fname="atmos_daily",welcome=false
    ); lat = init["lat"];

    imod,ipar,itime = iscainitialize(init,modID="dpre",parID="temp");
    nruns = itime["nruns"]-1; nlat = length(imod["lat"]); nlvls = length(imod["levels"]);
    tair = zeros(nlat,nlvls,360);

    for irun = 1 : nruns
        @info "$(Dates.now()) - Extracting AIR TEMPERATURE data for RUN $irun of CONFIG $(uppercase(config)) ..."
        ids,ivar = iscarawread(ipar,iroot,irun=irun+1);
        tair += dropdims(mean(ivar[:]*1,dims=1),dims=1)
        close(ids)
    end

    tair = dropdims(mean(tair/nruns,dims=3),dims=3)
    tair = (tair .+ reverse(tair,dims=1))/2

    @info "$(Dates.now()) - Saving compiled zonal-mean AIR TEMPERATURE data for CONFIG $(uppercase(config))..."
    dpath = datadir("compiled/zmean-tair-all/"); if !isdir(dpath); mkpath(dpath); end
    @save "$(dpath)/$(config)-zmean-tair-all.jld2" tair
    @save "$(dpath)/lat.jld2" lat

end

function zmeanpsiv500(
    prjpath::AbstractString,
    config::AbstractString
)

    @info "$(Dates.now()) - Beginning compilation of zonal-mean MERIDIONAL STREAMFUNCTION data at 500 hPa for CONFIG $(uppercase(config))..."
    init,iroot = iscastartup(
        prjpath=prjpath,config=config,
        fname="atmos_daily",welcome=false
    );  lat = init["lat"];

    imod,ipar,itime = iscainitialize(init,modID="cpre",parID="psi_v",pressure=500e2);
    nruns = itime["nruns"]-1; nlat = length(imod["lat"]); psiv = zeros(nlat,360);
    lvl = ipar["level"]

    for irun = 1 : nruns
        @info "$(Dates.now()) - Extracting MERIDIONAL STREAMFUNCTION data at 500 hPa for RUN $irun of CONFIG $(uppercase(config)) ..."
        ids,ivar = iscacalcread(ipar,iroot,irun=irun+1);
        psiv += ivar[:,lvl,:]*1
        close(ids)
    end

    psiv = psiv / nruns
    psiv = (psiv .- reverse(psiv,dims=1))/2

    @info "$(Dates.now()) - Saving compiled zonal-mean MERIDIONAL STREAMFUNCTION data at 500 hPa for CONFIG $(uppercase(config))..."
    dpath = datadir("compiled/zmean-psiv-500hPa/"); if !isdir(dpath); mkpath(dpath); end
    @save "$(dpath)/$(config)-zmean-psiv-500hPa.jld2" psiv
    @save "$(dpath)/lat.jld2" lat

end

function zmeanpsivall(
    prjpath::AbstractString,
    config::AbstractString
)

    @info "$(Dates.now()) - Beginning compilation of zonal-mean MERIDIONAL STREAMFUNCTION data at ALL PRESSURE LEVELS for CONFIG $(uppercase(config))..."
    init,iroot = iscastartup(
        prjpath=prjpath,config=config,
        fname="atmos_daily",welcome=false
    );  lat = init["lat"];

    imod,ipar,itime = iscainitialize(init,modID="cpre",parID="psi_v");
    nruns = itime["nruns"]-1; nlat = length(imod["lat"]); nlvls = length(imod["levels"]);
    psiv = zeros(nlat,nlvls,360);

    for irun = 1 : nruns
        @info "$(Dates.now()) - Extracting MERIDIONAL STREAMFUNCTION data at ALL PRESSURE LEVELS for RUN $irun of CONFIG $(uppercase(config)) ..."
        ids,ivar = iscacalcread(ipar,iroot,irun=irun+1);
        psiv += ivar[:]*1
        close(ids)
    end

    psiv = dropdims(mean(psiv/nruns,dims=3),dims=3)
    psiv = (psiv .- reverse(psiv,dims=1))/2

    @info "$(Dates.now()) - Saving compiled zonal-mean MERIDIONAL STREAMFUNCTION data at ALL PRESSURE LEVELS for CONFIG $(uppercase(config))..."
    dpath = datadir("compiled/zmean-psiv-all/"); if !isdir(dpath); mkpath(dpath); end
    @save "$(dpath)/$(config)-zmean-psiv-all.jld2" psiv
    @save "$(dpath)/lat.jld2" lat

end
