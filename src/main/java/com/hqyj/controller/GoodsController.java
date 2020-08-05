package com.hqyj.controller;

import com.hqyj.dao.GoodsMapper;
import com.hqyj.pojo.Goods;
import com.hqyj.pojo.Goods_type;
import com.hqyj.pojo.Producer;
import com.hqyj.service.GoodsService;
import com.hqyj.service.GoodsTypeService;
import com.hqyj.service.ProducerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;

/**
 * @author qb
 * @version 1.0
 * @date 2020/8/3 16:45
 */
@Controller
@RequestMapping("gc")
public class GoodsController {
    @Autowired
    private GoodsService gs;
    @Autowired
    private ProducerService ps;
    @Autowired
    private GoodsTypeService gts;
    //转到商品信息界面
    @RequestMapping("listPage.ajax")
    public String listPage(){
        return "list";
    }
    //商品信息界面ajax请求
    @RequestMapping("list.ajax")
    @ResponseBody
    public HashMap<String,Object> list(Goods goods){
        return gs.selectAll(goods);
    }
    //转到查看页面
    @RequestMapping("selectPage.ajax")
    public String selectPage() {
      /*  Goods goods=gm.selectByPrimaryKey(goodsId);
        request.setAttribute("goods",goods);*/
        return "select";
    }
    //转到商品信息界面
    @RequestMapping("producerListPage.ajax")
    public String producerListPage(){
        return "producerList";
    }

    //生产商信息界面ajax请求
    @RequestMapping("producerList.ajax")
    @ResponseBody
    public HashMap<String,Object> producerList(Producer producer){
        return ps.selectAll(producer);
    }
    @RequestMapping("goodsType.ajax")
    @ResponseBody
    public HashMap<String,Object> goodsType(Goods_type goodsType){
        return gts.selectAll(goodsType);
    }
    //删除信息的ajax请求
    @RequestMapping("delete.ajax")
    @ResponseBody
    public int delete(String goodsId){
        return gs.delete(goodsId);
    }
    @RequestMapping("updateSwitch.ajax")
    @ResponseBody
    public int updateSwitch(Goods goods){
        return gs.updateState(goods);
    }
    @RequestMapping("updateSave.ajax")
    @ResponseBody
    public int updateSave(Goods goods){
        return gs.updateSave(goods);
    }

}
