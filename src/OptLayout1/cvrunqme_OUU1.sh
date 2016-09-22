#!/bin/bash

#SBATCH --time=72:00:00         # walltime
#SBATCH --ntasks=1              # number of processor cores (i.e. tasks)
#SBATCH --mem-per-cpu=24G        # memory per CPU
#SBATCH --nodes=1               # number of nodes
#SBATCH -J "OUUoptimization"   # job name


# Compatibility variables for PBS. Delete if not needed.
export PBS_NODEFILE=`/fslapps/fslutils/generate_pbs_nodefile`
export PBS_JOBID=SLURM_JOB_ID
export PBS_O_WORKDIR="SLURM_SUBMIT_DIR"
export PBS_QUEUE=batch

# This prints information when the job started at the top of the slurm file
printf "Job debugging info\n___\n"
printf "Node List"
cat $PBS_NODEFILE
printf "___\n"
printf "SIM_FILE variable: $1\n"
printf "___\n"
printf "Current Directory: $PWD\n"
printf "___\n"
printf "Starting optimization at "
date
printf "\n___\n"

module purge # removes all modules in use (such as Python, gfortran, STAR-CCM+, etc.)
module load python/2/7 # loading the Python version you'll need to run your files
# use "module load" to load any other modules you need to run your files

# Passing arguments into the bash script from the command line to be used in the Python code (if needed)
args=("$@")
nDirections=${args[0]}


# This is where you put in the actual code you want the supercomputer to run
# In this case, I am using Python to run a file called "QME_cvx_cv_curvefit.py" and reading in the arguments from the command line
python optimizationLayout1.py $nDirections

# This prints information when the job ended at the bottom of the slurm file
printf "___\n"
printf "Ending 3DFLORIS at "
date
printf "\___\n"
printf "Removing temp files\n"
rm -vf ./*~
printf "___\n"
exit 0
