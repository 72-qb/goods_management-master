package com.hqyj.service.Impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hqyj.dao.GoodsMapper;
import com.hqyj.dao.Goods_typeMapper;
import com.hqyj.dao.ProducerMapper;
import com.hqyj.pojo.Goods;
import com.hqyj.pojo.Goods_type;
import com.hqyj.pojo.Producer;
import com.hqyj.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

/**
 * @author qb
 * @version 1.0
 * @date 2020/8/3 18:30
 */
@Service
public class GoodsServiceImpl implements GoodsService {
    @Autowired
    private GoodsMapper gm;
    @Autowired
    private ProducerMapper pm;
    @Autowired
    private Goods_typeMapper gtm;
    @Override
    public HashMap<String, Object> selectAll(Goods goods) {
        PageHelper.startPage(goods.getPage(),goods.getRow());
        HashMap<String,Object> map=new HashMap<>();
        List<Goods> goodsList=gm.selectAll(goods);
        Producer producer=new Producer();
        List<Producer> producerList=pm.selectAll(producer);
        Goods_type goodsType=new Goods_type();
        List<Goods_type> goodsTypeList=gtm.selectAll(goodsType);
        PageInfo<Goods> pageInfo=new PageInfo<>(goodsList);
        map.put("goodsList",goodsList);
        map.put("producerList",producerList);
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
    public int delete(String goodsId) {
        return gm.deleteByPrimaryKey(goodsId);
    }

    @Override
    public int updateState(Goods goods) {
        return gm.updateState(goods);
    }

    @Override
    public int updateSave(Goods goods) {
        return gm.updateSave(goods);
    }
}
