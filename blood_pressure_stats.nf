#!/usr/bin/env nextflow

//User sets file locations for Nextflow to use
params.input_file = "$projectDir/blood_pressure.csv"

//Process to extract data from csv file and find lowest values in repeats - Python
process READ_FILE
{
    input:
        path bp_file_in

    output:
        int[] systolic_pressures_out
        int[] diastolic_pressures_out
        int[] bpms_out

        """
            #!/usr/bin/env python3

            import pandas as pd

            print("Reading file...")

            bpdf = pd.read_csv(bp__file_in)

            systolic_pressures_out = bpdf["Systolic"]
            diastolic_pressures_out = bpdf["Diastolic"]
            bpms_out = bpdf["BPM"]

            print("Systolic pressures:")
            print(systolic_pressures_out)
        """
}

//Process to return lowest value of each set of 3 repeats - Java

process FIND_LOWEST
{
    input:
        int[] systolic_pressures_in
        int[] diastolic_pressures_in
        int[] bpms_in

    output:
        int[] lowest_systolics_out
        int[] lowest_diastolics_out
        int[] lowest_bpms_out

    """
        #!/usr/bin/env java
        
        int[] lowest_systolics = new int[(systolic_channel / 3)];
        for(int i = 0; systolic_channel.length; i++)
        {
            int lowest;
            if(i % 3 == 0)
            {
                lowest = systolic_channel[i];
            }
            else
            {
                if(systolic_channel[i] < lowest)
                {
                    lowest = systolic_channel[i];
                }
            }

            if(i % 1 == 2)
            {
                lowest_systolics[(i / 3) = lowest]
            }
        }

        int[] lowest_diastolics = new int[(diastolic_channel / 3)];
        for(int i = 0; diastolic_channel.length; i++)
        {
            int lowest;
            if(i % 3 == 0)
            {
                lowest = diastolic_channel[i];
            }
            else
            {
                if(diastolic_channel[i] < lowest)
                {
                    lowest = diastolic_channel[i];
                }
            }

            if(i % 1 == 2)
            {
                lowest_diastolics[(i / 3) = lowest]
            }

        int[] lowest_bpms = new int[(bpm_channel / 3)];
        for(int i = 0; bpm_channel.length; i++)
        {
            int lowest;
            if(i % 3 == 0)
            {
                lowest = bpm_channel[i];
            }
            else
            {
                if(bpm_channel[i] < lowest)
                {
                    lowest = bpm_channel[i];
                }
            }

            if(i % 1 == 2)
            {
                lowest_bpms[(i / 3) = lowest]
            }
        }
    """
}

//Process to find average value of each lowest measurement - Python
process FIND_AVERAGE
{
    input:
        int[] min_sys_in
        int[] min_dias_in
        int[] min_bpms_in

    output:
        double sys_average_out
        double dias_average_out
        double bpm_average_out

    """
        #!/usr/bin/env python3

        import numpy as np

        sys_average_out = np.mean(min_sys)
        dias_average_out = np.mean(min_dias)
        bpm_average_out = np.mean(min_bpms)
    """
}

process OUTPUT
{
    input:
        double sys_average
        double dias_average
        double bpm_average
    
    //Command line output and log
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

workflow
{
    file_ch = Channel.from(params.input_file)
    READ_FILE(file_ch)
    //FIND_LOWEST(READ_FILE.out.sys_ch, READ_FILE.out.dias_ch, bpm_ch)
    //FIND_AVERAGE(FIND_LOWEST.out.sys_ch, FIND_LOWEST.out.dias_ch, FIND_LOWEST.out.bpms_ch)
    //OUTPUT(FIND_AVERAGE.out.sys_ch, FIND_AVERAGE.out.dias_ch, FIND_AVERAGE.out.bpms_ch)
}

