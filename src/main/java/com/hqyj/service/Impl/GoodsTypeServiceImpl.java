package com.hqyj.service.Impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
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
        PageHelper.startPage(goodsType.getPage(),goodsType.getRow());
        HashMap<String,Object> map=new HashMap<>();
        List<Goods_type> goodsTypeList=gtm.selectAll(goodsType);
        PageInfo<Goods_type> pageInfo=new PageInfo<>(goodsTypeList);
        map.put("goodsTypeList",goodsTypeList);
        map.put("count",pageInfo.getTotal());
        map.put("prePage",pageInfo.getPrePage()==0?1:pageInfo.getPrePage());
        map.put("nextPage",pageInfo.getNextPage()==0?pageInfo.getNavigateLastPage():pageInfo.getNextPage());
        map.put("indexPage",pageInfo.getNavigateFirstPage());
        map.put("endPage",pageInfo.getNavigateLastPage());
        map.put("nowPage",pageInfo.getPageNum());
        map.put("size",pageInfo.getSize());
        return map;
    }

    @Override
    public int updateTypeSwitch(Goods_type goodsType) {
        return gtm.updateTypeState(goodsType);
    }

    @Override
    public int updateTypeSave(Goods_type goodsType) {
        return gtm.updateTypeSave(goodsType);
    }

    @Override
    public int deleteType(int typeId) {
        return gtm.deleteByPrimaryKey(typeId);
    }

    @Override
    public int insertTypeSave(Goods_type goodsType) {
        return gtm.insertSelective(goodsType);
    }
}
