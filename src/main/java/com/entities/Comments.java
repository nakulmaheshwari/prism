package com.entities;

public class Comments {

    private int coId;
    private String coContent;
    private String coReply;
    private int pid;
    private int uid;

    public Comments() {
    }

    public Comments(int coId, int uid) {
        this.coId = coId;
        this.uid = uid;
    }

    public Comments(int coId, String coContent, String coReply, int pid, int uid) {
        this.coId = coId;
        this.coContent = coContent;
        this.coReply = coReply;
        this.pid = pid;
        this.uid = uid;
    }

    public Comments(String coContent, int pid, int uid) {
        this.coContent = coContent;
        this.pid = pid;
        this.uid = uid;
    }
    

    public int getCoId() {
        return coId;
    }

    public void setCoId(int coId) {
        this.coId = coId;
    }

    public String getCoContent() {
        return coContent;
    }

    public void setCoContent(String coContent) {
        this.coContent = coContent;
    }

    public String getCoReply() {
        return coReply;
    }

    public void setCoReply(String coReply) {
        this.coReply = coReply;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }
    
    
    

}
