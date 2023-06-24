#! /bin/sh
set -x
date


HOMEhafs=/lustre/work/src/HAFS
source ${HOMEhafs}/ush/hafs_pre_job.sh.inc

if ( ! -s ../parm/system.conf ) ; then
    oper-axiom120amd-07L-2022091412.sh ../parm/system.conf
elif ( ! cmp ../parm/system.conf ../oper-axiom120amd-07L-2022091412.sh ) ; then
    echo WARNING: ../parm/system.conf does not match ../parm/oper-axiom120amd-07L-2022091412.sh
fi

cd ${HOMEhafs}/rocoto
EXPT=$(basename ${HOMEhafs})
SUBEXPT=oper
opts="-t -f -s sites/axiom.ent"
scrubopt="config.scrub_work=no config.scrub_com=no"

 ./run_hafs.py ${opts} 2022091412-2022091418 07L HISTORY \
     config.EXPT=${EXPT} config.SUBEXPT=${SUBEXPT} \
     config.run_atm_init=yes config.run_atm_init_fgat=yes config.run_atm_init_ens=no \
     config.run_atm_merge=no config.run_atm_merge_fgat=no config.run_atm_merge_ens=no \
     config.run_atm_vi=yes config.run_atm_vi_fgat=yes config.run_atm_vi_ens=no \
     config.run_gsi_vr=no config.run_gsi_vr_fgat=no config.run_gsi_vr_ens=no \
     config.run_gsi=yes config.run_fgat=yes config.run_envar=yes \
     config.gsi_d01=no config.gsi_d02=yes \
     config.run_ensda=no config.ENS_SIZE=40 config.run_enkf=no \
     config.run_analysis_merge=yes config.run_analysis_merge_ens=no \
     vi.vi_storm_env=init \
     atm_merge.atm_merge_method=vortexreplace analysis_merge.analysis_merge_method=vortexreplace \
     config.NHRS=48 ${scrubopt} \
     config.GRID_RATIO_ENS=2 \
     gsi.use_bufr_nr=yes \
     gsi.grid_ratio_fv3_regional=1 \
     ../parm/hafsv1b_phase3_72s.conf \
     rocoto.FORECAST_RESOURCES=FORECAST_RESOURCES_2040PE

date
echo 'cronjob done'
