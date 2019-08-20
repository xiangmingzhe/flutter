package com.example.flutter_app.utils;

import android.os.Environment;

import java.io.File;

/**
 * Time:2019/8/20
 * Author:xmz-dell
 * Description:
 */
public class FileUtils {
    public static final String path =
            Environment.getExternalStorageDirectory().getAbsolutePath() +
                    "/download_krc/";
    public FileUtils() {
        File file = new File(path);
        /**
         *如果文件夹不存在就创建
         */
        if (!file.exists()) {
            file.mkdirs();
        }
    }

    /**
     * 创建一个文件
     * @param FileName 文件名
     * @return
     */
    public File createFile(String FileName) {
        return new File(path, FileName);
    }

}
