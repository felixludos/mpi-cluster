
export FOUNDATION_RUN_MODE="cluster"

export FOUNDATION_SAVE_DIR="/home/fleeb/trained_nets/"
export FOUNDATION_DATA_DIR="/home/fleeb/local_data/"
export FOUNDATION_TESTING="0"

export JOB_REGISTRY_PATH="/home/fleeb/jobs/registry.txt"

export RESTART_AFTER="10"

echo "-- starting job --"

#nvidia-smi

{}

CODE=$?

#echo "CODE"
#echo $CODE

if [ $CODE -eq 3 ]
then
  echo "-- pausing for restart --"
  exit 3
fi
#
#echo "DEVICE"
#echo $CUDA_VISIBLE_DEVICES
#
#nvidia-smi

echo "-- job complete --"
