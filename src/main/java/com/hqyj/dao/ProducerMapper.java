package com.hqyj.dao;

import com.hqyj.pojo.Producer;

import java.util.List;

public interface ProducerMapper {
    int deleteByPrimaryKey(Integer producerId);

    int insert(Producer record);

    int insertSelective(Producer record);

    Producer selectByPrimaryKey(Integer producerId);

    int updateByPrimaryKeySelective(Producer record);

    int updateByPrimaryKey(Producer record);
    //查询所有生产商信息
    List<Producer> selectAll(Producer producer);
}