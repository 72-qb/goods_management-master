package com.hqyj.service.Impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hqyj.dao.ProducerMapper;
import com.hqyj.pojo.Producer;
import com.hqyj.service.ProducerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

/**
 * @author qb
 * @version 1.0
 * @date 2020/8/4 16:30
 */
@Service
public class ProducerServiceImpl implements ProducerService {
    @Autowired
    private ProducerMapper pm;
    @Override
    public HashMap<String, Object> selectAll(Producer producer) {
        PageHelper.startPage(producer.getPage(),producer.getRow());
        HashMap<String,Object> map=new HashMap<>();
        List<Producer> producerList=pm.selectAll(producer);
        PageInfo<Producer> pageInfo=new PageInfo<>(producerList);
        map.put("producerList",producerList);
        map.put("count",pageInfo.getTotal());
        map.put("prePage",pageInfo.getPrePage()==0?1:pageInfo.getPrePage());
        map.put("nextPage",pageInfo.getNextPage()==0?pageInfo.getNavigateLastPage():pageInfo.getNextPage());
        map.put("indexPage",pageInfo.getNavigateFirstPage());
        map.put("endPage",pageInfo.getNavigateLastPage());
        map.put("nowPage",pageInfo.getPageNum());
        return map;
    }
}
