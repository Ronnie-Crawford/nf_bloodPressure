//#!/usr/bin/env java

//Imports
import java.io.*;
import java.util.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class FIND_LOWEST
{
    //Test standalone input
    //static int[] systolic_pressures_in = {5,6,7,3,4,5,6,7,9};
    //static int[] diastolic_pressures_in = {3,3,4,1,2,2,3,4,5};
    //static int[] bpms_in = {70, 60, 50, 60, 65, 75, 65, 90, 100};

    public static void main(String[] args)
    {
        String systolic_pressures_string = "";
        String diastolic_pressures_string = "";
        String bpms_string = "";
        
        //Import lists from input file
        try
        {
				systolic_pressures_string = Files.readAllLines(Paths.get("bp_lists.txt")).get(0);
                diastolic_pressures_string = Files.readAllLines(Paths.get("bp_lists.txt")).get(1);
                bpms_string = Files.readAllLines(Paths.get("bp_lists.txt")).get(2);
		}
        catch (FileNotFoundException e)
        {
			e.printStackTrace();
		}
        catch(IOException e)
        {
            e.printStackTrace();
        }
        
        //Convert lists from string to arrays
        //List<String> systolic_pressures_in = new ArrayList<String>(Arrays.asList(systolic_pressures_string.split(",")));
        //List<String> diastolic_pressures_in = new ArrayList<String>(Arrays.asList(diastolic_pressures_string.split(",")));
        //List<String> bpms_in = new ArrayList<String>(Arrays.asList(bpms_string.split(",")));

        String[] sys_frags = systolic_pressures_string.split(",");
        String[] dias_frags = diastolic_pressures_string.split(",");
        String[] bpm_frags = bpms_string.split(",");

        int[] systolic_pressures_in = new int[sys_frags.length];
        int[] diastolic_pressures_in = new int[dias_frags.length];
        int[] bpms_in = new int[bpm_frags.length];


        for (int i = 0; i < sys_frags.length; i++)
        {
            try
            {
                systolic_pressures_in[i] = Integer.parseInt(sys_frags[i]);
            }
            catch (NumberFormatException e)
            {
                e.printStackTrace();
            }
        }

        for (int i = 0; i < dias_frags.length; i++)
        {
            try
            {
                diastolic_pressures_in[i] = Integer.parseInt(dias_frags[i]);
            }
            catch (NumberFormatException e)
            {
                e.printStackTrace();
            }
        }

        for (int i = 0; i < bpm_frags.length; i++)
        {
            try
            {
                bpms_in[i] = Integer.parseInt(bpm_frags[i]);
            }
            catch (NumberFormatException e)
            {
                e.printStackTrace();
            }
        }
        
        //For each group of 3 systolic measures, return lowest
        int[] lowest_systolics = new int[(systolic_pressures_in.length / 3)];
        for(int i = 0; i < systolic_pressures_in.length; i++)
        {
            int lowest = 0;
            if(i % 3 == 0)
            {
                lowest = systolic_pressures_in[i];
            }
            else
            {
                if(systolic_pressures_in[i] < lowest || lowest == 0)
                {
                    lowest = systolic_pressures_in[i];
                }
            }
            System.out.println(lowest);
            if(i % 3 == 2)
            {
                System.out.println("Assigning");
                lowest_systolics[(i / 3)] = lowest;
            }
        }

        //For each group of 3 diastolic measures, return lowest
        int[] lowest_diastolics = new int[(diastolic_pressures_in.length / 3)];
        for(int i = 0; i < diastolic_pressures_in.length; i++)
        {
            int lowest = 0;
            if(i % 3 == 0)
            {
                lowest = diastolic_pressures_in[i];
            }
            else
            {
                if(diastolic_pressures_in[i] < lowest || lowest == 0)
                {
                    lowest = diastolic_pressures_in[i];
                }
            }

            if(i % 3 == 2)
            {
                lowest_diastolics[i / 3] = lowest;
            }
        }

        //For each group of 3 bpm measures, return lowest
        int[] lowest_bpms = new int[(bpms_in.length / 3)];
        for(int i = 0; i < bpms_in.length; i++)
        {
            int lowest = 0;
            if(i % 3 == 0)
            {
                lowest = bpms_in[i];
            }
            else
            {
                if(bpms_in[i] < lowest || lowest == 0)
                {
                    lowest = bpms_in[i];
                }
            }

            if(i % 3 == 2)
            {
                lowest_bpms[i / 3] = lowest;
            }
        }

        //Write results to output file
        try
        {
            PrintWriter writer = new PrintWriter("bp_lowest_out.txt", "UTF-8");
            writer.println(Arrays.toString(lowest_systolics));
            writer.println(Arrays.toString(lowest_diastolics));
            writer.println(Arrays.toString(lowest_bpms));
            writer.close();
        }
        catch(FileNotFoundException e)
        {
            e.printStackTrace();
        }
        catch(UnsupportedEncodingException e)
        {
            e.printStackTrace();
        }
        

        //Test standalone output
        //System.out.println(lowest_systolics.length);
        //System.out.println(lowest_diastolics.length);
        //System.out.println(lowest_bpms.length);
    }
}