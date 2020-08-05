package com.hqyj.pojo;

import com.hqyj.realm.MyRealm;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Goods extends MyPage {
    private String goodsId;

    private String name;

    private Integer typeId;

    private Integer producerId;

    private BigDecimal cost;

    private Integer storeId;

    private Date produceDate;

    private Date expireDate;

    private Long gNum;

    private Integer state;

    private Producer producer;

    private Goods_type goodsType;

    public Goods_type getGoodsType() {
        return goodsType;
    }

    public void setGoodsType(Goods_type goodsType) {
        this.goodsType = goodsType;
    }

    public Producer getProducer() {
        return producer;
    }

    public void setProducer(Producer producer) {
        this.producer = producer;
    }

    public String getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(String goodsId) {
        this.goodsId = goodsId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getTypeId() {
        return typeId;
    }

    public void setTypeId(Integer typeId) {
        this.typeId = typeId;
    }

    public Integer getProducerId() {
        return producerId;
    }

    public void setProducerId(Integer producerId) {
        this.producerId = producerId;
    }

    public BigDecimal getCost() {
        return cost;
    }

    public void setCost(BigDecimal cost) {
        this.cost = cost;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public String getProduceDate() {
        if(this.produceDate!=null){
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
            return  sdf.format(produceDate);
        }
        return "";
    }

    public void setProduceDate(String produceDate) throws ParseException {
        if (produceDate!=null){
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
            this.produceDate=sdf.parse(produceDate);
        }else {
            this.produceDate = new Date();
        }
    }

    public String getExpireDate() {
        if(this.expireDate!=null){
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
            return  sdf.format(expireDate);
        }
        return "";
    }

    public void setExpireDate(String expireDate) throws ParseException {
        if (expireDate!=null){
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
            this.expireDate=sdf.parse(expireDate);
        }else {
            this.expireDate = new Date();
        }
    }

    public Long getgNum() {
        return gNum;
    }

    public void setgNum(Long gNum) {
        this.gNum = gNum;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }
}