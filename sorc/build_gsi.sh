#!/bin/sh
set -eux
source ./machine-setup.sh > /dev/null 2>&1
cwd=$(pwd)

cd hafs_gsi.fd/ush/

export BUILD_VERBOSE=ON
export GSI_MODE=Regional
export ENKF_MODE=FV3REG
export CMAKE_OPTS=-DENABLE_MKL=OFF
./build.sh

exit
