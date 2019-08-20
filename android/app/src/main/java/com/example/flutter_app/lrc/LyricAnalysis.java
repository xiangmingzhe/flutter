package com.example.flutter_app.lrc;

import android.os.Environment;
import android.util.Base64;
import android.util.Log;

import com.example.flutter_app.utils.ZLibUtils;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Time:2019/8/16
 * Author:xmz-dell
 * Description:
 */
public class LyricAnalysis {
    private static final char[] miarry = { '@', 'G', 'a', 'w', '^', '2', 't',
            'G', 'Q', '6', '1', '-', 'Î', 'Ò', 'n', 'i' };
    /**
     *
     * @param filenm krc文件路径加文件名
     * @return krc文件处理后的文本
     * @throws IOException
     */
    public static String getKrcText(String lrc,String fileName) throws IOException
    {
//        String newLrc = new String(Base64.decode(lrc.getBytes(), Base64.DEFAULT));
//
//        File krcfile=new File(KRC_PATH+fileName);
//        if(!krcfile.exists()){
//            createLrcFile(newLrc,fileName);
//        }
//        Log.d("krc_text","解析前的:"+newLrc);
        String path=KRC_PATH+"一克拉的眼泪.krc";
        String krc_text=getKrcTexts(path);
        Log.d("krc_text","解析后的:"+krc_text);
        return krc_text;
    }
    //解密krc数据
    public static String getKrcTexts(String filenm) throws IOException
    {
        File krcfile = new File(filenm);
        byte[] zip_byte = new byte[(int) krcfile.length()];
        FileInputStream fileinstrm = new FileInputStream(krcfile);
        byte[] top = new byte[4];
        fileinstrm.read(top);
        fileinstrm.read(zip_byte);
        int j = zip_byte.length;
        for (int k = 0; k < j; k++)
        {
            int l = k % 16;
            int tmp67_65 = k;
            byte[] tmp67_64 = zip_byte;
            tmp67_64[tmp67_65] = (byte) (tmp67_64[tmp67_65] ^ miarry[l]);
        }
        String krc_text = new String( ZLibUtils.decompress(zip_byte), "utf-8" );
        return krc_text;
    }



    public static final String KRC_PATH =
            Environment.getExternalStorageDirectory().getAbsolutePath() +
                    "/download_krc/";
    /**
     * 创建krc文件
     */
    public static void createLrcFile(String krc,String fileName){
        File dir = new File(KRC_PATH);//验证krc下载地址
        if (!dir.exists()) {
            dir.mkdir();
        }
        File krcFile=new File(KRC_PATH+fileName);
        try {
            if(!krcFile.exists()){
                krcFile.createNewFile();
            }
            try {
                FileWriter fw = new FileWriter(krcFile, true);
                BufferedWriter bw = new BufferedWriter(fw);
                bw.write(krc);
                bw.close();
                fw.close();
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }


        }catch (Exception e){
            Log.d("createLrcFile","**"+e.getMessage());
        }



    }

}
