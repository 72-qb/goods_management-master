package com.hqyj.dao;

import com.hqyj.pojo.Goods;
import com.hqyj.pojo.Producer;

import java.util.List;

public interface ProducerMapper {
    int deleteByPrimaryKey(Integer producerId);

    int insert(Producer record);
    //增加生产商信息
    int insertSelective(Producer record);

    Producer selectByPrimaryKey(Integer producerId);

    int updateByPrimaryKeySelective(Producer record);

    int updateByPrimaryKey(Producer record);
    //查询所有生产商信息
    List<Producer> selectAll(Producer producer);
    //修改状态
    int updateProState(Producer producer);
    //修改信息
    int updateProSave(Producer producer);

    int deletePro(String producerId);
}