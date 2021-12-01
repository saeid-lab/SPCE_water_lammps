# NOTE: This script can be modified for different atomic structures, 
# units, etc. See in.elastic for more info.
#

# Define the finite deformation size. Try several values of this
# variable to verify that results do not depend on it.
variable up equal 5.0e-2
 
# metal units, elastic constants in GPa
##### units		metal

## metal to real conversion !
## 1 bar ~ 1 atm
## 1 eV  = 23.061 kcal/mol

variable cfac equal 1.0e-4

variable cunits string GPa

# Define MD parameters
variable nevery equal 20                  # sampling interval
variable nrepeat equal 10                 # number of samples
variable nfreq equal ${nevery}*${nrepeat} # length of one average
variable nthermo equal ${nfreq}           # interval for thermo output
variable nequil equal 20*${nthermo}       # length of equilibration run
variable nrun equal 10*${nthermo}          # length of equilibrated run
variable timestep equal 1.0	           # timestep



units           real
boundary        p p p

newton          off
pair_style      lj/charmmfsw/coul/long 10 12
pair_modify     mix arithmetic
kspace_style    pppm 1e-6

atom_style      full
bond_style      harmonic
angle_style     charmm
dihedral_style  charmmfsw
special_bonds   charmm
improper_style  harmonic

read_data       sys_after_npt.data
change_box	all triclinic


