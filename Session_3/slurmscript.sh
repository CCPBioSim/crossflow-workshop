#!/bin/bash --login

#SBATCH -J grompp_mdrun
#SBATCH -p e280-workshop_1018917
#SBATCH -A e280-workshop
#SBATCH --cpus-per-task=1
#SBATCH -t 00:15:00
#SBATCH --nodes=1
#SBATCH --qos="reservation"
#SBATCH --tasks-per-node=128
module load gromacs
export OMP_NUM_THREADS=1

gmx grompp -f nvt.mdp -c 1ake_em.gro -p 1ake.top -o 1ake_nvt.tpr -maxwarn 1
srun --distribution=block:block --hint=nomultithread gmx_mpi mdrun -deffnm 1ake_nvt
echo 0 | gmx trjconv -f 1ake_nvt.trr -s 1ake_nvt.tpr -o 1ake_nvt_whole.trr -pbc whole
