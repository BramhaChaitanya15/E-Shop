package com.mycompany.eshop.helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Random;

public class Helper {
   
    /*detete files from web/inf for storage*/
    public static boolean deleteFile(String path) {
        boolean f = false;
        try {

            File file = new File(path);
            f = file.delete();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;

    }
    
    /*save files from web/inf for a path to store images to database*/
    public static boolean saveFile(InputStream is, String path) {
        boolean f = false;

        try {
            byte b[] = new byte[is.available()];

            is.read(b);

            FileOutputStream fos = new FileOutputStream(path);

            fos.write(b);

            fos.flush();
            fos.close();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;

    }
    
    /*to show only first 10 words of the product description*/
    public static String get10Words(String desc)
    {
        String[] strs = desc.split(" ");
        
        if(strs.length>10)
        {
            String res="";
            for(int i=0;i<10;i++)
            {
                res=res+strs[i]+" ";
            }
            return (res+"...");
        }else
        {
            
            return (desc+"...");
        }
        
    }
    
    /*get 6 digit random number for order receipt*/
    public static String getRandomNumberString() {
        // It will generate 6 digit random Number.
        // from 0 to 999999
        Random rnd = new Random();
        int number = rnd.nextInt(999999);

        // this will convert any number sequence into 6 character.
        return String.format("%06d", number);
    }
    
}
