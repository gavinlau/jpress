package io.jpress.module.entre.controller;

public class Ver {
    private String frontImgsrc;
    private String backImgsrc;
    private String facebizCode;


    public String getFacebizCode() {
        return facebizCode;
    }

    public void setFacebizCode(String facebizCode) {
        this.facebizCode = facebizCode;
    }

    public String getFaceOrderNo() {
        return faceOrderNo;
    }

    public void setFaceOrderNo(String faceOrderNo) {
        this.faceOrderNo = faceOrderNo;
    }

    private String faceOrderNo;

    private String verStatus;

    public String getBackImgsrc() {
        return backImgsrc;
    }
    public void setBackImgsrc(String backImgsrc) {
        this.backImgsrc = backImgsrc;
    }

    public String getFrontImgsrc() {
        return frontImgsrc;
    }

    public void setFrontImgsrc(String frontImgsrc) {
        this.frontImgsrc = frontImgsrc;
    }
    public String getVerStatus() {
        return verStatus;
    }

    public void setVerStatus(String verStatus) {
        this.verStatus = verStatus;
    }


    private String proxyIdx;
    private String proxyName;

    public String getProxyIdx() {
        return proxyIdx;
    }

    public void setProxyIdx(String proxyIdx) {
        this.proxyIdx = proxyIdx;
    }

    public String getProxyName() {
        return proxyName;
    }

    public void setProxyName(String proxyName) {
        this.proxyName = proxyName;
    }

    public String getProxyAreaCode() {
        return proxyAreaCode;
    }

    public void setProxyAreaCode(String proxyAreaCode) {
        this.proxyAreaCode = proxyAreaCode;
    }

    public String getProxyAreaName() {
        return proxyAreaName;
    }

    public void setProxyAreaName(String proxyAreaName) {
        this.proxyAreaName = proxyAreaName;
    }

    public String getProxyStreet() {
        return proxyStreet;
    }

    public void setProxyStreet(String proxyStreet) {
        this.proxyStreet = proxyStreet;
    }

    public String getProxyCommunity() {
        return proxyCommunity;
    }

    public void setProxyCommunity(String proxyCommunity) {
        this.proxyCommunity = proxyCommunity;
    }

    public String getProxySpace() {
        return proxySpace;
    }

    public void setProxySpace(String proxySpace) {
        this.proxySpace = proxySpace;
    }

    public String getPayUserName() {
        return payUserName;
    }

    public void setPayUserName(String payUserName) {
        this.payUserName = payUserName;
    }

    public String getPayPhoneName() {
        return payPhoneName;
    }

    public void setPayPhoneName(String payPhoneName) {
        this.payPhoneName = payPhoneName;
    }

    public String getPayCardNo() {
        return payCardNo;
    }

    public void setPayCardNo(String payCardNo) {
        this.payCardNo = payCardNo;
    }

    private String proxyAreaCode;
    private String proxyAreaName;
    private String proxyStreet;
    private String proxyCommunity;
    private String proxySpace;
    private String payUserName;
    private String payPhoneName;
    private String payCardNo;


    public String getContactStatus() {
        return contactStatus;
    }

    public void setContactStatus(String contactStatus) {
        this.contactStatus = contactStatus;
    }

    private String contactStatus;//0 unaudited 1 auditing 2 audited

    public String[] getContactPicsList() {
        return contactPicsList;
    }

    public void setContactPicsList(String[] contactPicsList) {
        this.contactPicsList = contactPicsList;
    }

    private String[] contactPicsList;
}
