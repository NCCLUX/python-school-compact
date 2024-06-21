#!/bin/bash -l
#SBATCH --account=p200301           # project account
#SBATCH --job-name=JUPYTER          # Job name
#SBATCH --partition=cpu             # Cluster partition
#SBATCH --qos=short                 # SLURM qos
#SBATCH --time=0-4:00:00            # Time to run the Job(HH:MM:SS)
#SBATCH --nodes=1                   # Number of nodes
#SBATCH --ntasks-per-node=1         # Number of tasks per node
#SBATCH --cpus-per-task=128         # CORES per task

# Load Modules
module load Python
pip install --user --upgrade pip
pip install numpy pandas pymp-pypi numba matplotlib
module load JupyterLab

echo "Connect to meluxina: ssh -L 8888:localhost:8888 ${USER}@login.lxp.lu -p 8822" > notebook_commands.log
echo "Port forwarding: ssh -L 8888:localhost:8888 $(hostname)" >> notebook_commands.log

# Launch jupyter notebook
jupyter lab --no-browser --ip "*" --notebook-dir notebook_dir  --port 8888 --NotebookApp.token='token12345' --NotebookApp.password=''

# Use the following in Windows
#salloc -A p200301 -t 03:00:00 -p cpu -q short -N 1 -c 128