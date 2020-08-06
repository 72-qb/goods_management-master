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
    /*注解注入*/
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
    //转到编辑商品信息页面
    @RequestMapping("selectPage.ajax")
    public String selectPage() {
        return "select";
    }
    //转到编辑商品类型信息页面
    @RequestMapping("selectTypePage.ajax")
    public String selectTypePage() {
        return "selectTypePage";
    }
    //转到添加生产商信息页面
    @RequestMapping("insertProPage.ajax")
    public String insertProPage() {
        return "producerAdd";
    }
    //转到添加生产商信息页面
    @RequestMapping("insertTypePage.ajax")
    public String insertTypePage() {
        return "goodsTypeAdd";
    }
    //新增生产商信息并保存
    @RequestMapping("insertProSave.ajax")
    @ResponseBody
    public int insertProSave(Producer producer){
        return ps.insertProSave(producer);
    }
    //新增商品类型信息并保存
    @RequestMapping("insertTypeSave.ajax")
    @ResponseBody
    public int insertTypeSave(Goods_type goodsType){
        return gts.insertTypeSave(goodsType);
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
    //转到编辑生产商页面
    @RequestMapping("selectProPage.ajax")
    public String selectProPage() {
        return "selectProPage";
    }
    //商品类型信息界面ajax请求
    @RequestMapping("goodsTypeList.ajax")
    @ResponseBody
    public HashMap<String,Object> goodsTypeList(Goods_type goodsType){
        return gts.selectAll(goodsType);
    }
    //修改生产商是否处于合作的状态
    @RequestMapping("updateTypeSwitch.ajax")
    @ResponseBody
    public int updateTypeSwitch(Goods_type goodsType){
        return gts.updateTypeSwitch(goodsType);
    }
    //删除商品信息的ajax请求
    @RequestMapping("delete.ajax")
    @ResponseBody
    public int delete(String goodsId){
        return gs.delete(goodsId);
    }
    //删除生产商信息的ajax请求
    @RequestMapping("deletePro.ajax")
    @ResponseBody
    public int deletePro(int producerId){
        return ps.deletePro(producerId);
    }
    //删除生产商信息的ajax请求
    @RequestMapping("deleteType.ajax")
    @ResponseBody
    public int deleteType(int typeId){
        return gts.deleteType(typeId);
    }

    //修改商品是否处于库存中的状态
    @RequestMapping("updateSwitch.ajax")
    @ResponseBody
    public int updateSwitch(Goods goods){
        return gs.updateState(goods);
    }
    //修改商品信息信息并保存
    @RequestMapping("updateSave.ajax")
    @ResponseBody
    public int updateSave(Goods goods){
        return gs.updateSave(goods);
    }
    //修改生产商信息并保存
    @RequestMapping("updateProSave.ajax")
    @ResponseBody
    public int updateProSave(Producer producer){
        return ps.updateProSave(producer);
    }
    //修改商品类型信息并保存
    @RequestMapping("updateTypeSave.ajax")
    @ResponseBody
    public int updateTypeSave(Goods_type goodsType){
        return gts.updateTypeSave(goodsType);
    }
    //修改生产商是否处于合作的状态
    @RequestMapping("updateProSwitch.ajax")
    @ResponseBody
    public int updateProSwitch(Producer producer){
        return ps.updateProState(producer);
    }
    //转到商品类型页面
    @RequestMapping("goodsTypeListPage.do")
    public String goodsTypeListPage(){
        return "goodsTypeList";
    }


}
