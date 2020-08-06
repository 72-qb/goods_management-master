package com.hqyj.service;

import com.hqyj.pojo.Goods_type;

import java.util.HashMap;

/**
 * @author qb
 * @version 1.0
 * @date 2020/8/5 8:43
 */
public interface GoodsTypeService {
    HashMap<String,Object> selectAll(Goods_type goodsType);

    int updateTypeSwitch(Goods_type goodsType);

    int updateTypeSave(Goods_type goodsType);

    int deleteType(int typeId);

    int insertTypeSave(Goods_type goodsType);
}
