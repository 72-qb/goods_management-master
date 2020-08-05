package com.hqyj.service;

import com.hqyj.pojo.Goods;

import java.util.HashMap;

/**
 * @author qb
 * @version 1.0
 * @date 2020/8/3 18:29
 */
public interface GoodsService {
    //查询所有商品信息
    HashMap<String, Object> selectAll(Goods goods);
    //根据goodsId删除商品信息
    int delete(String goodsId);
    //修改状态
    int updateState(Goods goods);
    //根据ID修改信息
    int updateSave(Goods goods);

}
