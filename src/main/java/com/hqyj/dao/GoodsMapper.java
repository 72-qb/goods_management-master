package com.hqyj.dao;

import com.hqyj.pojo.Goods;

import java.util.List;

public interface GoodsMapper {
    //根据goodsId删除商品信息
    int deleteByPrimaryKey(String goodsId);

    int insert(Goods record);

    int insertSelective(Goods record);

    Goods selectByPrimaryKey(String goodsId);

    int updateByPrimaryKeySelective(Goods record);

    int updateByPrimaryKey(Goods record);

    //查询所有商品信息
    List<Goods> selectAll(Goods goods);
    //修改状态
    int updateState(Goods goods);
    //根据ID修改
    int updateSave(Goods goods);
}