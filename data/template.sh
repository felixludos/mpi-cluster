
#source /home/fleeb/.bashrc

export OMNILEARN_SAVE_DIR="/home/fleeb/trained_nets/"
export OMNILEARN_DATA_DIR="/home/fleeb/local_data/"

export JOB_REGISTRY_PATH="/home/fleeb/jobdir/registry.tsv"

# <header>

#echo "-- starting job $(date) --"

echo "$JOB_NAME\t$JOB_ID\t$(date +%y%m%d-%H%M%S)\t$(hostname)" >> "/home/fleeb/jobdir/starts.tsv"

#pwd
#nvidia-smi
#ls

<job>

CODE=$?

echo "$JOB_NAME\t$JOB_ID\t$(date +%y%m%d-%H%M%S)\t$(hostname)\t$CODE" >> "/home/fleeb/jobdir/terminals.tsv"

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
