#!/usr/bin/env nextflow

//User sets file locations for Nextflow to use
params.input_file = "$projectDir/blood_pressure.csv"
params.find_lowest_file = "$projectDir/bin/FIND_LOWEST.jar"
params

//Main workflow
workflow
{
    READ_FILE(params.input_file)
    FIND_LOWEST(READ_FILE.out, params.find_lowest_file)
    //FIND_AVERAGE(FIND_LOWEST.out)
    //OUTPUT(FIND_AVERAGE.out)
}

//Process to extract data from csv file and find lowest values in repeats - Python
process READ_FILE
{
    input:
        path bp_file_in

    output:
        path ('bp_read_out.txt')

    script:
        """
        READ_FILE.py ${bp_file_in}
        """        
}

//Process to return lowest value of each set of 3 repeats - Java
process FIND_LOWEST
{
    input:
        path ('bp_read_out.txt')
        path find_lowest_file

    output:
        path ('bp_lowest_out.txt')

    script:
    """
    java -jar ${find_lowest_file}
    """
    //echo Main-Class: FIND_LOWEST>manifest.txt (BASH command to copy manifest.txt to .class file)
    //jar cvfe FIND_LOWEST.jar FIND_LOWEST FIND_LOWEST.class (BASH command to add .class file to .jar file)
}

//Process to find average value of each lowest measurement - Python
process FIND_AVERAGE
{
    input:
        path ('bp_lowest_out.txt')

    output:
        path ('bp_average_out.txt')

    script:
    """
    FIND_AVERAGE.py
    """
}

//Process to output results to command line
process OUTPUT
{
    input:
        path ('bp_average_out.txt')

    sys_average = $ sed '1!d' bp_average_out.txt
    dias_average = $ sed '2!d' bp_average_out.txt
    bpm_average = $ sed '3!d' bp_average_out.txt

    log.info
    """
        \
        B L O O D - P R E S S U R E - A N A L Y S E R
        =============================================
        File in: ${params.input_file}
        Average lowest systolic blood pressure: ${sys_average}
        Average lowest diastolic blood pressure: ${dias_average}
        Average lowest bpm: ${bpm_average}
        \
    """
}