package com.hqyj.service.Impl;

import com.hqyj.dao.Goods_typeMapper;
import com.hqyj.pojo.Goods_type;
import com.hqyj.service.GoodsTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

/**
 * @author qb
 * @version 1.0
 * @date 2020/8/5 8:43
 */
@Service
public class GoodsTypeServiceImpl implements GoodsTypeService {
    @Autowired
    private Goods_typeMapper gtm;
    @Override
    public HashMap<String, Object> selectAll(Goods_type goodsType) {
        HashMap<String,Object> map=new HashMap<>();
        List<Goods_type> goodsTypeList=gtm.selectAll(goodsType);
        map.put("goodsTypeList",goodsTypeList);
        return map;
    }
}
