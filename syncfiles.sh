# Copyright (C) 2025 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

#!/bin/bash
set -e

function sync_chart {
  chart=$1
  valuefiles=$(yq eval ".$chart.values" $configfile |sed 's/^- //')

  echo "Copying value files for $chart ..."
  src_repo=$(yq eval ".$chart.src_repo" $configfile)
  dest_repo=$(yq eval ".$chart.dest_repo" $configfile)
  src_dir=$(yq eval ".$chart.src_dir" $configfile)
  dest_dir=$(yq eval ".$chart.dest_dir" $configfile)
  echo "Clean up the original values yaml"
  rm $dest_repo/$dest_dir/*values.yaml
  echo "Copying new values file: $valuefiles"
  for valuefile in $valuefiles; do
    echo “  Copy $valuefile”
    # wget https://raw.githubusercontent.com/opea-project/${src_repo}/refs/heads/main/${src_dir}/${valuefile} -qO tmp/src.yaml
    # Use local version src values
    echo "cp $src_repo/$src_dir/$valuefile $dest_repo/$dest_dir/"
    cp $src_repo/$src_dir/$valuefile $dest_repo/$dest_dir/
  done
}

configfile=GenAIInfra/helm-charts/valuefiles.yaml

charts_list=${1:-$(cat $configfile |grep -v "^#" |grep -v "^  " |grep -v "^$" |sed 's/:/ /')}

echo $charts_list
for chart in $charts_list;do
  sync_chart $chart
done
