<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="x-admin-sm">

<head>
    <meta charset="UTF-8">
    <title>欢迎页面-X-admin2.2</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/xadmin.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-3.5.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/xadmin.js"></script>
</head>

<body onload="load(1)">
<div class="x-nav">
            <span class="layui-breadcrumb">
                <a href="">首页</a>
                <a href="">演示</a>
                <a>
                    <cite>导航元素</cite></a>
            </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新">
        <i class="layui-icon layui-icon-refresh" style="line-height:30px"></i>
    </a>
</div>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-body ">
                        <div class="layui-input-inline layui-show-xs-block">
                            <input  type="text" class="layui-input" placeholder="商品名" id="startName"/></div>
                        <div class="layui-input-inline layui-show-xs-block">
                            <input type="text" class="layui-input" placeholder="商品类型" id="startType"/></div>
                        <div class="layui-input-inline layui-show-xs-block">
                            <input type="text" placeholder="请输入商品编号" id="startId" autocomplete="off" class="layui-input"/></div>
                        <div class="layui-input-inline layui-show-xs-block">
                            <button class="layui-btn layui-btn-warm" onclick="load(nowPage)" lay-filter="sreach">
                                <i class="layui-icon">&#xe615;</i></button>
                        </div>
                        <%--      <div style="float: right" class="layui-input-inline layui-show-xs-block">
                                  <input type="text" name="username" placeholder="请输入商品编号" autocomplete="off" class="layui-input"></div>
                              <div style="float: right" class="layui-input-inline layui-show-xs-block">
                                  <button class="layui-btn" lay-filter="sreach">
                                      <i class="layui-icon">&#xe615;</i></button>
                              </div>--%>
                </div>
             <%--   <div class="layui-card-header">
                    <button class="layui-btn layui-btn-danger" onclick="delAll()">
                        <i class="layui-icon"></i>批量删除</button>
                    <button class="layui-btn" onclick="xadmin.open('添加用户','./order-add.html',800,600)">
                        <i class="layui-icon"></i>添加</button></div>--%>
                <div class="layui-card-body ">
                    <table class="layui-table layui-form">
                        <thead>
                        <tr>
                            <th>
                                <input type="checkbox" name="" lay-skin="primary">
                            </th>
                            <th>商品编号</th>
                            <th>商品名称</th>
                            <th>商品类型</th>
                            <th>生产商</th>
                            <th>进价</th>
                            <th>库存编号</th>
                            <th>生产日期</th>
                            <th>过期时间</th>
                            <th>当前批次库存</th>
                            <th>状态</th>
                            <th>操作</th></tr>
                        </thead>
                        <tbody>

                        </tbody>
                    </table>
                </div>
                <div class="layui-card-body ">
                    <div class="page">
                        <div>
                            <%--分页按钮--%>
                            <div class="col offset-3">

                                <button type="button" class="layui-btn" onclick="indexPage()">首页</button>
                                <button type="button" class="layui-btn layui-btn-normal" onclick="prePage()"> <i class="layui-icon">&#xe65a;</i></button>
                                <div style="display: inline-block" id="pageNow"></div>
                                <button type="button" class="layui-btn layui-btn-normal" class="num" onclick="nextPage()"> <i class="layui-icon">&#xe65b;</i></button>
                                <buttonb type="button" class="layui-btn" onclick="endPage()">尾页</buttonb>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    layui.use(['laydate', 'form'],
        function() {
            var laydate = layui.laydate;

            //执行一个laydate实例
            laydate.render({
                elem: '#start' //指定元素
            });

            //执行一个laydate实例
            laydate.render({
                elem: '#end' //指定元素
            });
        });
    layui.use(['form'], function(){
        form = layui.form;
    });

    var nPage;
    var pPage;
    var iPage;
    var ePage;
    var nowPage;
    var size;
    function prePage() {
        load(pPage);
    }
    function nextPage() {
        load(nPage);
    }
    function indexPage() {
        load(iPage);
    }
    function endPage() {
        load(ePage);
    }
    var json1;
    function load(p) {
        var name=$("#startName").val();
        var typeId=$("#startType").val();
        var goodsId=$("#startId").val();
        var params={
            "name":name,
            "typeId":typeId,
            "goodsId":goodsId,
            "page":p
        }
        $.ajax({
            url:"${pageContext.request.contextPath}/gc/list.ajax",
            data:params,
            type:"get",
            dataType:"json",
            success:function (info) {
                var goodsTypeList="";
                for (var i = 0; i < info.goodsTypeList.length; i++) {
                    goodsTypeList+="<option value='"+info.goodsTypeList[i].typeId+"'>"+info.goodsTypeList[i].name+"</option>"
                }
                var producerList="";
                for (var i = 0; i < info.producerList.length; i++) {
                    producerList+="<option value='"+info.producerList[i].producerId+"'>"+info.producerList[i].name+"</option>"
                }
                var data1={
                    "goodsTypeList":goodsTypeList,
                    "producerList":producerList
                }
                json1=JSON.stringify(data1);
                nPage=info.nextPage;
                pPage=info.prePage;
                iPage=info.indexPage;
                ePage=info.endPage;
                nowPage=info.nowPage;
                size=info.size;
                var t="";
                var t1="";
                var html="";
                for (var i = 0; i < info.goodsList.length; i++) {
                    if (info.goodsList[i].state==0){
                    t="<input id='switch' type='checkbox'  name='switch' lay-text='已入库|已出库' checked='' lay-skin='switch'>";
                    t1="已入库";
                    }else if (info.goodsList[i].state==1){
                    t="<input id='switch' type='checkbox'  name='switch' lay-text='已入库|已出库' lay-skin='switch'>";
                    t1="已出库";
                    }
                    html+="<tr>"+
                        "<td><input type='checkbox' name='' lay-skin='primary' ></td>"+
                        "<td>"+info.goodsList[i].goodsId+"</td>"+
                        "<td>"+info.goodsList[i].name+"</td>"+
                        "<td hidden>"+info.goodsList[i].typeId+"</td>"+
                        "<td>"+info.goodsList[i].goodsType.name+"</td>"+
                        "<td hidden>"+info.goodsList[i].producerId+"</td>"+
                        "<td>"+info.goodsList[i].producer.name+"</td>"+
                        "<td>"+info.goodsList[i].cost+"</td>"+
                        "<td>"+info.goodsList[i].storeId+"</td>"+
                        "<td>"+info.goodsList[i].produceDate+"</td>"+
                        "<td>"+info.goodsList[i].expireDate+"</td>"+
                        "<td>"+info.goodsList[i].gNum+"</td>"+
                        "<td><a href='javascript:;' title='"+t1+"' onclick='sw(this)'>"+t+"</a></td>"+
                        "<td><button class='layui-btn layui-btn-radius layui-btn-normal' onclick='selectPage(this)'><i class='layui-icon'>&#xe63c;</i>编辑</button>"+
                        "<button class='layui-btn layui-btn-radius layui-btn-danger' onclick='member_del(this)'><i class='layui-icon'>&#xe640;</i>删除</button></td>"+
                        "</tr>"
                }
                $("tbody").html(html);
                form.render();
                var pageNow="";
                for (var i = 1; i <=ePage ; i++) {
                    if (nowPage==i){
                        pageNow+="<button onclick='load("+i+")' class='layui-btn layui-btn-sm layui-btn-danger' >" + i + "</button>"
                    }else {
                        pageNow+="<button onclick='load("+i+")' class='layui-btn layui-btn-sm layui-btn-warm' >" + i + "</button>"
                    }

                }
                $("#pageNow").html(pageNow);

            }
        })
    }
    function sw(obj) {
        var goodsId=$(obj).parent().parent().find("td").eq(1).text();
        layer.confirm('确认要修改库存状态吗？',{btn:['确认','取消'],btn1:
            function(index) {
        if($(obj).attr('title') == '已入库'){
                $.ajax({
                url:"${pageContext.request.contextPath}/gc/updateSwitch.ajax",
                data:{"goodsId":goodsId,"state":1},
                type:"get",
                dataType:"json",
                success:function (info) {
                    if(info>0){
                        layer.msg('已出库!', {
                            icon: 6,
                            time: 1000
                        });
                        load(nowPage);
                    }

                }
            })
        }
        else {
            $.ajax({
                url:"${pageContext.request.contextPath}/gc/updateSwitch.ajax",
                data:{"goodsId":goodsId,"state":0},
                type:"get",
                dataType:"json",
                success:function (info) {
                    if(info>0){
                        layer.msg('已入库!', {
                            icon: 6,
                            time: 1000
                        });
                        load(nowPage);
                    }
                }
            })

        }
        },
        btn2:function (index) {
            load(nowPage);
        }})
    }
    var json;
    function selectPage(o){
        var goodsId=$(o).parent().parent().find("td").eq(1).text();
        var name=$(o).parent().parent().find("td").eq(2).text();
        var typeId=$(o).parent().parent().find("td").eq(3).text();
        var producerId=$(o).parent().parent().find("td").eq(5).text();
        var cost=$(o).parent().parent().find("td").eq(7).text();
        var storeId=$(o).parent().parent().find("td").eq(8).text();
        var produceDate=$(o).parent().parent().find("td").eq(9).text();
        var expireDate=$(o).parent().parent().find("td").eq(10).text();
        var gNum=$(o).parent().parent().find("td").eq(11).text();
        var state=$(o).parent().parent().find("td").eq(12).text();
        var data = {
            "goodsId":goodsId,
            "name":name,
            "typeId":typeId,
            "producerId":producerId,
            "cost":cost,
            "storeId":storeId,
            "produceDate":produceDate,
            "expireDate":expireDate,
            "gNum":gNum,
            "state":state
        }
        json=JSON.stringify(data);
        xadmin.open('查看','${pageContext.request.contextPath}/gc/selectPage.ajax');
    }
    /*用户-停用*/
    function member_stop(obj, id) {
        layer.confirm('确认要停用吗？',
            function(index) {

                if ($(obj).attr('title') == '启用') {

                    //发异步把用户状态进行更改
                    $(obj).attr('title', '停用');
                    $(obj).find('i').html('&#xe62f;');

                    $(obj).parents("tr").find(".td-status").find('span').addClass('layui-btn-disabled').html('已停用');
                    layer.msg('已停用!', {
                        icon: 5,
                        time: 1000
                    });

                } else {
                    $(obj).attr('title', '启用');
                    $(obj).find('i').html('&#xe601;');

                    $(obj).parents("tr").find(".td-status").find('span').removeClass('layui-btn-disabled').html('已启用');
                    layer.msg('已启用!', {
                        icon: 5,
                        time: 1000
                    });
                }

            });
    }

    /*用户-删除*/

    function member_del(o) {
        var goodsId=$(o).parent().parent().find("td").eq(1).text();
        layer.confirm('确认要删除吗？',
            function(index) {
                //发异步删除数据
                $.ajax({
                    url:"${pageContext.request.contextPath}/gc/delete.ajax",
                    type:"get",
                    data:{"goodsId":goodsId},
                    dataType: "json",
                    success:function(info){
                        if(info>0){
                            layer.msg('已删除!', {
                                icon: 1,
                                time: 1000
                            });
                            if(size==1){
                                load(ePage-1);
                            }else {
                                load(ePage);
                            }

                        }else {
                            layer.msg('删除失败!', {
                                icon: 2,
                                time: 1000
                            });
                        }

                    }


                })

            });
    }

    function delAll(argument) {

        var data = tableCheck.getData();

        layer.confirm('确认要删除吗？' + data,
            function(index) {
                //捉到所有被选中的，发异步进行删除
                layer.msg('删除成功', {
                    icon: 1
                });
                $(".layui-form-checked").not('.header').parents('tr').remove();
            });
    }</script>

</html>

