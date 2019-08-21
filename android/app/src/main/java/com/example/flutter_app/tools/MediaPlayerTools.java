package com.example.flutter_app.tools;

import android.media.MediaPlayer;
import android.os.Handler;

import java.io.IOException;

import static com.example.flutter_app.tools.MusicStatus.SONG_PAUSE;
import static com.example.flutter_app.tools.MusicStatus.SONG_PLAY;

/**
 * Time:2019/7/31
 * Author:xmz-dell
 * Description:
 */
public class MediaPlayerTools {
    public static MediaPlayerTools mMediaPlayerTools = null;
    private MediaPlayer mediaPlayer;
    private int curStatus=SONG_PLAY;
    private String playUrl;// 当前播放歌曲的url
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
        this.playUrl=url;
        mHandler.post(mRunable);
    }

    Handler mHandler=new Handler();
    Runnable mRunable=new Runnable() {
        @Override
        public void run() {
            try {
                if (mediaPlayer.isPlaying()) {
                    mediaPlayer.pause();
                    mediaPlayer.reset();
                }
                mediaPlayer.setLooping(true);//设置循环播放
                mediaPlayer.setDataSource(playUrl);
                mediaPlayer.prepare();
                mediaPlayer.start();
                if(onMediaPlayListener!=null){
                    onMediaPlayListener.onPlayStatus((curStatus=SONG_PLAY));
                }

            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    };
    private void releaseHandler(){
        if(mHandler!=null){
            mHandler.removeCallbacksAndMessages(null);
        }
    }
    public void pause() {
        if (mediaPlayer.isPlaying()) {
            mediaPlayer.pause();
        }
    }
    public void onResume(){
        if (mediaPlayer.isPlaying()) {
            releaseHandler();
            mediaPlayer.pause();
            if(onMediaPlayListener!=null){
                onMediaPlayListener.onPlayStatus((curStatus=SONG_PAUSE));
            }
        }else{
            mediaPlayer.start();
            if(onMediaPlayListener!=null){
                onMediaPlayListener.onPlayStatus((curStatus=SONG_PLAY));
            }
        }

    }
    public OnMediaPlayListener onMediaPlayListener;
    public void setOnMediaPlayListener(OnMediaPlayListener onMediaPlayListener){
        this.onMediaPlayListener=onMediaPlayListener;
    }
    public interface OnMediaPlayListener{
        void onPlayStatus(int playStatus);
        void onReadLrc(String lrc);
    }
}
