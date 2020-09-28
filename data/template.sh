
source /home/fleeb/.bashrc

export FOUNDATION_SAVE_DIR="/home/fleeb/trained_nets/"
export FOUNDATION_DATA_DIR="/home/fleeb/local_data/"

export JOB_REGISTRY_PATH="/home/fleeb/jobdir/registry.txt"

# <head>

#echo "-- starting job $(date) --"

echo "$JOB_NAME\t$JOB_ID\t$(date)\t$(hostname)" >> "/home/fleeb/jobdir/starts.txt"

#nvidia-smi

<job>

CODE=$?

echo "$JOB_NAME\t$JOB_ID\t$(date)\t$(hostname)\t$CODE" >> "/home/fleeb/jobdir/terminals.txt"

#echo "CODE"
#echo $CODE

if [ $CODE -eq 3 ]
then
#  echo "-- pausing for restart $(date) --"
  exit 3
fi
#
#echo "DEVICE"
#echo $CUDA_VISIBLE_DEVICES
#
#nvidia-smi

#echo "-- job complete $(date) --"

exit 0
