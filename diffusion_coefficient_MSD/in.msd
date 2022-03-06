# setup problem
atom_style      full
boundary        p p p
units           real

pair_style   lj/cut/coul/long 12.0 12.0
bond_style   harmonic
angle_style  harmonic
kspace_style pppm 0.0001

read_data SPCE_OPT.data

pair_coeff     1 1 0.1553 3.166
pair_coeff     * 2 0.0 0.0

bond_coeff 1    600.0 1.0
angle_coeff 1   75.0 109.47
special_bonds   lj/coul 0.0 0.0 0.5


neighbor	2.0 bin
neigh_modify	delay 1 every 1  check yes

fix	       fshake all shake 0.0001 20 0 b 1 a 1

timestep	1.0
thermo		100
thermo_style    custom step temp vol press etotal pe ke epair ecoul lx ly lz density cpuremain

# equilibration and thermalization

#velocity     all create ${T} 12345 mom yes rot yes dist gaussian
fix          NVT all nvt temp 300.0 300.0 100 drag 0.2
run          1000

# switch to NVE if desired

#unfix       NVT
#fix         NVE all nve


reset_timestep  0

variable       dim equal 3*2  #3Dimenstion *2
variable       nevery equal 10


compute         msd all msd com yes
variable        twopoint equal c_msd[4]/${dim}/(step*dt+1.0e-6)
fix             9 all vector ${nevery} c_msd[4]
variable        fitslope equal slope(f_9)/${dim}/(${nevery}*dt)

timestep	1.0
thermo		1000

thermo_style	custom step time temp c_msd[4] v_twopoint v_fitslope cpuremain
run          500000








