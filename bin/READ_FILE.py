#!/usr/bin/env python3

#Imports
import sys
import pandas as pd

#Test standalone inputs
#bpdf = pd.read_csv("blood_pressure.csv")
#bpdf = pd.read_csv("$bp_file_in")

#Create dataframe from input
bpdf = pd.read_csv(sys.argv[1])

#Extract data arrays
systolic_pressures_out = bpdf["Systolic"].array
diastolic_pressures_out = bpdf["Diastolic"].array
bpms_out = bpdf["BPM"].array
print(bpdf)
print(systolic_pressures_out)

#Write output to file
bp_lists = open("bp_read_out.txt", "w")
bp_lists.write(str(systolic_pressures_out))
bp_lists.write(str(diastolic_pressures_out))
bp_lists.write(str(bpms_out))
bp_lists.close()

#Test standalone outputs
#print(systolic_pressures_out)
#print(diastolic_pressures_out)
#print(bpms_out)
