package com.example.flutter_app.tools;

import android.media.MediaPlayer;

import java.io.IOException;

/**
 * Time:2019/7/31
 * Author:xmz-dell
 * Description:
 */
public class MediaPlayerTools {
    public static MediaPlayerTools mMediaPlayerTools = null;
    private MediaPlayer mediaPlayer;

    public static MediaPlayerTools getInstance() {
        if (mMediaPlayerTools == null) {
            mMediaPlayerTools = new MediaPlayerTools();
        }
        return mMediaPlayerTools;
    }

    private MediaPlayerTools() {
        initMediaPlayer();
    }

    public void initMediaPlayer() {
        if (mediaPlayer == null) {
            mediaPlayer = new MediaPlayer();
        }
    }

    public void play(String url) {
        try {
            if (mediaPlayer.isPlaying()) {
                mediaPlayer.pause();
                mediaPlayer.reset();
            }
            mediaPlayer.setDataSource(url);
            mediaPlayer.prepare();
            mediaPlayer.start();


        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void pause() {
        if (mediaPlayer.isPlaying()) {
            mediaPlayer.pause();
        }
    }
}
