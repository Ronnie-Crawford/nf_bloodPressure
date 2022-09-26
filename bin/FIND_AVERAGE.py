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

min_sys = min_sys.replace('[', '')
min_dias = min_dias.replace('[', '')
min_bpms = min_bpms.replace('[', '')

min_sys = min_sys.replace(']', '')
min_dias = min_dias.replace(']', '')
min_bpms = min_bpms.replace(']', '')

min_sys = np.fromstring(min_sys, dtype = int, sep = ', ')
min_dias = np.fromstring(min_dias, dtype = int, sep = ', ')
min_bpms = np.fromstring(min_bpms, dtype = int, sep = ', ')

print(min_sys)

#Find averages
sys_average_out = np.mean(min_sys)
dias_average_out = np.mean(min_dias)
bpm_average_out = np.mean(min_bpms)
print(sys_average_out)

#Write output file
print("Writing to file")
writer = open("bp_average_out.txt", "w")
writer.write("Systolic pressure, average of lowest repeats: " + str(sys_average_out) + "\n")
writer.write("Diastolic pressure, average of lowest repeats: " + str(dias_average_out) + "\n")
writer.write("BPM, average of lowest repeats: " + str(bpm_average_out) + "\n")
writer.close()

#Test standalone output
#print(sys_average_out)
#print(dias_average_out)
#print(bpm_average_out)