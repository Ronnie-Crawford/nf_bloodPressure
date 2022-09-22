#!/usr/bin/env nextflow

//User sets file locations for Nextflow to use
params.input_file = "$projectDir/blood_pressure.csv"

//Main workflow
workflow
{
    READ_FILE(params.input_file)
    FIND_LOWEST(READ_FILE.out)
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

    output:
        path ('bp_lowest_out.txt')

    script:
    """
    FIND_LOWEST.java
    """
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
    
    log.info
    """
        \
        B L O O D - P R E S S U R E - A N A L Y S E R
        =============================================
        File in: ${params.input_file}
        Average low systolic blood pressure: ${sys_average}
        Average low diastolic blood pressure: ${dias_average}
        Average low bpm: ${bpm_average}
        \
    """
}

