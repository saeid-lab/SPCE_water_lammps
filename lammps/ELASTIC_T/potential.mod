# NOTE: This script can be modified for different pair styles 
# See in.elastic for more info.

reset_timestep 0


# Setup neighbor style
neighbor 1.0 nsq
neigh_modify once no every 1 delay 0 check yes

# Setup output

fix avp all ave/time  ${nevery} ${nrepeat} ${nfreq} c_thermo_press mode vector
thermo		${nthermo}

thermo_style custom step temp pe press f_avp[1] f_avp[2] f_avp[3] f_avp[4] f_avp[5] f_avp[6] lx ly lz xlo xhi ylo yhi zlo zhi xy xz yz 
thermo_modify norm no




# Setup MD

timestep ${timestep}
fix 4 all nvt temp 300.0 300.0 100

kspace_style    pppm 1e-6


