package com.hqyj.dao;

import com.hqyj.pojo.Goods_type;

import java.util.List;

public interface Goods_typeMapper {
    int deleteByPrimaryKey(Integer typeId);

    int insert(Goods_type record);

    int insertSelective(Goods_type record);

    Goods_type selectByPrimaryKey(Integer typeId);

    int updateByPrimaryKeySelective(Goods_type record);

    int updateByPrimaryKey(Goods_type record);

    //查询所有商品类型
    List<Goods_type> selectAll(Goods_type goodsType);
}