package com.syndic.beans;

import java.sql.Date;

public class News {
    private int newsId;
    private String newsTitle;
    private String newsContent;
    private Date newsDate;
    private String newsCategory;
    private String newsAttachment;
    private int newsSId;

    // Constructor
    public News() {
    }

    public News(int newsId, String newsTitle, String newsContent, Date newsDate, String newsCategory, String newsAttachment, int newsSId) {
        this.newsId = newsId;
        this.newsTitle = newsTitle;
        this.newsContent = newsContent;
        this.newsDate = newsDate;
        this.newsCategory = newsCategory;
        this.newsAttachment = newsAttachment;
        this.newsSId = newsSId;
    }

    public News( String newsTitle, String newsContent, String newsCategory, String newsAttachment, int newsSId) {
        this.newsTitle = newsTitle;
        this.newsContent = newsContent;
        this.newsCategory = newsCategory;
        this.newsAttachment = newsAttachment;
        this.newsSId = newsSId;
    }

    // Getters and Setters
    public int getNewsId() {
        return newsId;
    }

    public void setNewsId(int newsId) {
        this.newsId = newsId;
    }

    public String getNewsTitle() {
        return newsTitle;
    }

    public void setNewsTitle(String newsTitle) {
        this.newsTitle = newsTitle;
    }

    public String getNewsContent() {
        return newsContent;
    }

    public void setNewsContent(String newsContent) {
        this.newsContent = newsContent;
    }

    public Date getNewsDate() {
        return newsDate;
    }

    public void setNewsDate(Date newsDate) {
        this.newsDate = newsDate;
    }

    public String getNewsCategory() {
        return newsCategory;
    }

    public void setNewsCategory(String newsCategory) {
        this.newsCategory = newsCategory;
    }

    public String getNewsAttachment() {
        return newsAttachment;
    }

    public void setNewsAttachment(String newsAttachment) {
        this.newsAttachment = newsAttachment;
    }

    public int getNewsSId() {
        return newsSId;
    }

    public void setNewsSId(int newsSId) {
        this.newsSId = newsSId;
    }

    @Override
    public String toString() {
        return "News{" +
                "newsId=" + newsId +
                ", newsTitle='" + newsTitle + '\'' +
                ", newsContent='" + newsContent + '\'' +
                ", newsDate=" + newsDate +
                ", newsCategory='" + newsCategory + '\'' +
                ", newsAttachment='" + newsAttachment + '\'' +
                ", newsSId=" + newsSId +
                '}';
    }
}
