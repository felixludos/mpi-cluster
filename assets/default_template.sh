#!

# Job Info: Name={name}, Process={process}, SubmitDate={date.strftime("%y%m%d-%H%M%S")}

###############
# Header
###############

cd {working_dir}

echo "-- starting job $(date) --"

echo "$JOB_NAME\t$JOB_ID\t$(date +%y%m%d-%H%M%S)\t$(hostname)" >> {job_dir}/starts.tsv


###############
# Job
###############

#pwd
#nvidia-smi
#ls
# conda install -c eumetsat expect

{command}


###############
# Tail
###############

CODE=$?

echo "$JOB_NAME\t$JOB_ID\t$(date +%y%m%d-%H%M%S)\t$(hostname)\t$CODE" >> {job_dir}/terminals.tsv

if [ $CODE -eq 3 ]
then
  echo "-- pausing for restart $(date) --"
  exit 3
fi

#echo $CUDA_VISIBLE_DEVICES
#
#nvidia-smi

echo "-- job complete $(date) --"

exit 0
