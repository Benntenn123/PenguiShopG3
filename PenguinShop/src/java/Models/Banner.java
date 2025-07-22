/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.util.Date;

public class Banner {
    private int bannerID;
    private String bannerName;
    private String bannerHref;
    private int bannerStatus;
    private Date createdAt;
    private String bannerLink;

    public Banner(int bannerID, String bannerName, String bannerHref, int bannerStatus, Date createdAt, String bannerLink) {
        this.bannerID = bannerID;
        this.bannerName = bannerName;
        this.bannerHref = bannerHref;
        this.bannerStatus = bannerStatus;
        this.createdAt = createdAt;
        this.bannerLink = bannerLink;
    }

    public Banner() {
    }

    public int getBannerID() {
        return bannerID;
    }

    public void setBannerID(int bannerID) {
        this.bannerID = bannerID;
    }

    public String getBannerName() {
        return bannerName;
    }

    public void setBannerName(String bannerName) {
        this.bannerName = bannerName;
    }

    public String getBannerHref() {
        return bannerHref;
    }

    public void setBannerHref(String bannerHref) {
        this.bannerHref = bannerHref;
    }

    public int getBannerStatus() {
        return bannerStatus;
    }

    public void setBannerStatus(int bannerStatus) {
        this.bannerStatus = bannerStatus;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public String getBannerLink() {
        return bannerLink;
    }

    public void setBannerLink(String bannerLink) {
        this.bannerLink = bannerLink;
    }
}
