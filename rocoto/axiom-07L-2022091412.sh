#! /bin/sh
set -x
date

HOMEhafs=/lustre/work/src/HAFS
source ${HOMEhafs}/ush/hafs_pre_job.sh.inc

cd ${HOMEhafs}/rocoto
EXPT=$(basename ${HOMEhafs})
SUBEXPT=${EXPT}_48hr_v3
opts="-t -f -s sites/azure.ent"
scrubopt="config.scrub_work=no config.scrub_com=no"

 ./run_hafs.py ${opts} 2022091412-2022091418 07L HISTORY \
     config.EXPT=${EXPT} config.SUBEXPT=$SUBEXPT \
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
     ../parm/hafsv0p3_regional_mvnest.conf \
     ../parm/hafsv0p3_hycom.conf \
     rocotostr.FORECAST_RESOURCES=FORECAST_RESOURCES_2040PE

date
echo 'cronjob done'
