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
                    </div>

                </div>

                <div class="layui-card-header">
                    <button class="layui-btn layui-btn-danger" onclick="delAll()">
                        <i class="layui-icon"></i>批量删除</button>
                    <button class="layui-btn" onclick="xadmin.open('添加用户','./order-add.html',800,600)">
                        <i class="layui-icon"></i>添加</button></div>
                <div class="layui-card-body ">
                    <table class="layui-table">
                        <thead>
                        <tr>
                            <th>
                                <input type="checkbox" name="">
                            </th>
                            <th>生产商编号</th>
                            <th>生厂商名称</th>
                            <th>生产商地址</th>
                            <th>生产商联系方式</th>
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
                            <a href="#" class="num" onclick="indexPage()">首页</a>
                            <a href="#" class="num" onclick="prePage()">上一页</a>
                            <div style="display: inline-block" id="pageNow"></div>
                            <a href="#" class="num" onclick="nextPage()">下一页</a>
                            <a href="#" class="num" onclick="endPage()">尾页</a>
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
    var nPage;
    var pPage;
    var iPage;
    var ePage;
    var nowPage;
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
    function load(p) {
        var name=$("#producerName").val();
        var params={
            "name":name,
            "page":p
        }
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
                var html="";
                for (var i = 0; i < info.producerList.length; i++) {
                    html+="<tr>"+
                        "<td><input type='checkbox'/></td>"+
                        "<td>"+info.producerList[i].producerId+"</td>"+
                        "<td>"+info.producerList[i].name+"</td>"+
                        "<td>"+info.producerList[i].address+"</td>"+
                        "<td>"+info.producerList[i].tel+"</td>"+
                        "<td>"+info.producerList[i].state+"</td>"+
                        "<td><button onclick='selectPage(this)'><i class='layui-icon'>&#xe63c;</i></button>"+
                        "<button><i class='layui-icon'>&#xe640;</i></button></td>"+
                        "</tr>"
                }
                $("#html").html(html);
                var pageNow="";
                for (var i = 1; i <=ePage ; i++) {
                    pageNow+="&nbsp;<a href='#' onclick='load("+i+")' class='num'>" + i + "</a>"
                }
                $("#pageNow").html(pageNow);
            }
        })
    }
    var json;
    function selectPage(o){
        var goodsId=$(o).parent().parent().find("td").eq(1).text();
        var name=$(o).parent().parent().find("td").eq(2).text();
        var typeId=$(o).parent().parent().find("td").eq(3).text();
        var producerId=$(o).parent().parent().find("td").eq(4).text();
        var cost=$(o).parent().parent().find("td").eq(5).text();
        var storeId=$(o).parent().parent().find("td").eq(6).text();
        var produceDate=$(o).parent().parent().find("td").eq(7).text();
        var expireDate=$(o).parent().parent().find("td").eq(8).text();
        var gNum=$(o).parent().parent().find("td").eq(9).text();
        var state=$(o).parent().parent().find("td").eq(10).text();
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
</script>

</html>
