#!/usr/bin/env python3

#Imports
import numpy as np

#Test standalone input
#min_sys = {3,4,5}
#min_dias = {2,3,4}
#min_bpms = {50,60,70}

#Read input file
data = open('bp_lowest_out.txt', 'r')
lines = data.readlines()

min_sys = lines[0]
min_dias = lines[1]
min_bpms = lines[2]

#Find averages
sys_average_out = np.mean(min_sys)
dias_average_out = np.mean(min_dias)
bpm_average_out = np.mean(min_bpms)

#Write output file
writer = open("bp_averages_out.txt", "w")
writer.write(str(sys_average_out))
writer.write(str(dias_average_out))
writer.write(str(bpm_average_out))
writer.close()

#Test standalone output
#print(sys_average_out)
#print(dias_average_out)
#print(bpm_average_out)
