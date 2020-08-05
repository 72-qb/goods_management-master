package com.hqyj.service;

import com.hqyj.pojo.Producer;

import java.util.HashMap;

/**
 * @author qb
 * @version 1.0
 * @date 2020/8/4 16:29
 */
public interface ProducerService {
    //查询所有生产商信息
    HashMap<String,Object> selectAll(Producer producer);
}
