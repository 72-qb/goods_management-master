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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/xadmin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/xadmin.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
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
                        <input type="text" class="layui-input" placeholder="生厂商名称" id="producerName"/></div>
                    <div class="layui-input-inline layui-show-xs-block">
                        <button class="layui-btn" onclick="load(nowPage)" lay-filter="sreach">
                            <i class="layui-icon">&#xe615;</i></button>
                        <button class="layui-btn" onclick="xadmin.open('添加合作生产商','${pageContext.request.contextPath}/gc/insertProPage.ajax',800,600)">
                            <i class="layui-icon"></i>添加</button>
                    </div>

                </div>

                <div class="layui-card-body ">
                    <table class="layui-table layui-form">
                        <thead>
                        <tr>
                            <th>生产商编号</th>
                            <th>生厂商名称</th>
                            <th>生产商地址</th>
                            <th>联系方式</th>
                            <th>状态</th>
                            <th>操作</th></tr>
                        </thead>
                        <form>
                            <tbody id="html">
                            </tbody>
                        </form>
                    </table>
                </div>
                <div class="layui-card-body ">
                    <div class="page">

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
    /*定义分页信息*/
    var nPage;
    var pPage;
    var iPage;
    var ePage;
    var nowPage;
    var size;
    /*执行分页方法*/
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
    /*页面加载*/
    function load(p) {
        var name=$("#producerName").val();
        var params={
            "name":name,
            "page":p
        }
        /*获取页面信息的ajax请求*/
        $.ajax({
            url:"${pageContext.request.contextPath}/gc/producerList.ajax",
            data:params,
            type:"get",
            dataType:"json",
            success:function (info) {
                nPage=info.nextPage;
                pPage=info.prePage;
                iPage=info.indexPage;
                ePage=info.endPage;
                nowPage=info.nowPage;
                size=info.size;
                var html="";
                for (var i = 0; i < info.producerList.length; i++) {
                    if (info.producerList[i].state==0){
                        t="<input id='switch' type='checkbox' name='switch' lay-text='合作|未合作' checked='' lay-skin='switch'>";
                        t1="合作";
                    }else if (info.producerList[i].state==1){
                        t="<input id='switch' type='checkbox' name='switch' lay-text='合作|未合作' lay-skin='switch'>";
                        t1="未合作";
                    }
                    html+="<tr>"+
                        "<td>"+info.producerList[i].producerId+"</td>"+
                        "<td>"+info.producerList[i].name+"</td>"+
                        "<td>"+info.producerList[i].address+"</td>"+
                        "<td>"+info.producerList[i].tel+"</td>"+
                        "<td><a href='javascript:;' title='"+t1+"' onclick='sw(this)'>"+t+"</a></td>"+
                        "<td><button class='layui-btn layui-btn-xs layui-btn-radius layui-btn-normal' onclick='selectPage(this)'><i class='layui-icon'>&#xe63c;</i></button>"+
                        "<button class='layui-btn layui-btn-xs layui-btn-radius layui-btn-danger' onclick='member_del(this)'><i class='layui-icon'>&#xe640;</i></button></td>"+
                        "</tr>"
                }
                $("#html").html(html);
                form.render();
                var pageNow="";
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
    /*定义一个json对象*/
    var json;
    /*获取页面信息并且打开编辑窗口*/
    function selectPage(o){
        var producerId=$(o).parent().parent().find("td").eq(0).text();
        var name=$(o).parent().parent().find("td").eq(1).text();
        var address=$(o).parent().parent().find("td").eq(2).text();
        var tel=$(o).parent().parent().find("td").eq(3).text();
/*        var state=$(o).parent().parent().find("td").eq(4).text();*/
        var data = {
            "producerId":producerId,
            "name":name,
            "address":address,
            "tel":tel,
         /*   "state":state*/
            "nowPage":nowPage
        }
        json=JSON.stringify(data);
        xadmin.open('编辑','${pageContext.request.contextPath}/gc/selectProPage.ajax');
    }
    /*修改状态*/
    function sw(obj) {
        var producerId=$(obj).parent().parent().find("td").eq(0).text();
        layer.confirm('确认要修改合作关系吗？',{btn:['确认','取消'],btn1:
                function(index) {
                    if($(obj).attr('title') == '未合作'){
                        $.ajax({
                            url:"${pageContext.request.contextPath}/gc/updateProSwitch.ajax",
                            data:{"producerId":producerId,"state":0},
                            type:"get",
                            dataType:"json",
                            success:function (info) {
                                if(info>0){
                                    layer.msg('已合作!', {
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
                            url:"${pageContext.request.contextPath}/gc/updateProSwitch.ajax",
                            data:{"producerId":producerId,"state":1},
                            type:"get",
                            dataType:"json",
                            success:function (info) {
                                if(info>0){
                                    layer.msg('已取消合作!', {
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
    /*删除商品信息的方法*/
    function member_del(o) {
        var producerId=$(o).parent().parent().find("td").eq(0).text();
        var state=$(o).parent().parent().find("td").eq(4).text();
        layer.confirm('确认要删除吗？',
            function(index) {
                //发异步删除数据
                if(state == '未合作'){
                    $.ajax({
                        url:"${pageContext.request.contextPath}/gc/deletePro.ajax",
                        type:"get",
                        data:{"producerId":producerId},
                        dataType: "json",
                        success:function(info){
                            if(info>0){
                                layer.msg('已删除!', {
                                    icon: 1,
                                    time: 1000
                                });
                                if(size==1){
                                    load(iPage);
                                }else {
                                    load(nowPage);
                                }

                            }else {
                                layer.msg('删除失败!', {
                                    icon: 2,
                                    time: 1000
                                });
                            }

                        }

                    })

                }else {
                    layer.msg('与该公司还有合作关系，不能删除!', {
                        icon: 2,
                        time: 1000
                    });
                }
            });
    }
</script>

</html>
