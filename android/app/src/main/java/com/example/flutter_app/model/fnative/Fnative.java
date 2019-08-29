package com.example.flutter_app.model.fnative;

import android.text.Html;

/**
 * Time:2019/8/29
 * Author:xmz-dell
 * Description:
 */
public class Fnative {
    private String head;
    private String body;
    public Fnative(){

    }
    public Fnative(String head,String body){
        this.head= head;
        this.body=body;
    }
    public String getHead() {
        return head;
    }

    public void setHead(String head) {
        this.head = head;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }
}
