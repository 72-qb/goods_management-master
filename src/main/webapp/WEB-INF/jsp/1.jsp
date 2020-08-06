<%--
  Created by IntelliJ IDEA.
  User: 文宏
  Date: 2020/8/3
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="x-admin-sm">
<head>
    <title>库存</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
    <link rel="stylesheet" href="/static/css/font.css">
    <link rel="stylesheet" href="/static/css/xadmin.css">
    <script type="text/javascript" src="/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="/static/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="/static/js/xadmin.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body onload="load(pageInfo)">
<div class="x-nav">
          <span class="layui-breadcrumb">
            <a href="">首页</a>
            <a href="">演示</a>
            <a>
              <cite>导航元素</cite></a>
          </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
       onclick="location.reload()" title="刷新">
        <i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-body ">
                    <form class="layui-form layui-col-space5">
                        <div class="layui-inline layui-show-xs-block">
                            <input type="text" name="storeId" placeholder="请输入商品编号" autocomplete="off"
                                   class="layui-input">
                        </div>
                        <div class="layui-inline layui-show-xs-block">
                            <input type="text" name="storeName" placeholder="请输入商品名称" autocomplete="off"
                                   class="layui-input">
                        </div>
                        <div class="layui-inline layui-show-xs-block">
                            <button class="layui-btn" lay-submit="" lay-filter="search"><i
                                    class="layui-icon">&#xe615;</i></button>
                        </div>
                    </form>
                </div>
                <div class="layui-card-header">
                    <button class="layui-btn layui-btn-danger" onclick="deleteStores()"><i class="layui-icon"></i>批量删除
                    </button>
                    <button class="layui-btn" onclick="xadmin.open('添加库存','/store/addStorePage.do',600,400)"><i
                            class="layui-icon"></i>添加
                    </button>
                </div>

                <div class="layui-card-body layui-table-body layui-table-main">
                    <table class="layui-table layui-form">
                        <thead>
                        <tr>
                            <th>
                                <input type="checkbox" lay-filter="checkAll" name="" lay-skin="primary">
                            </th>
                            <th>库存编号</th>
                            <th>商品名称</th>
                            <th>商品库存</th>
                            <th>库存上限</th>
                            <th>库存下限</th>
                            <th>状态</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody id="tbody">

                        </tbody>
                    </table>
                </div>
                <div class="layui-card-body ">
                    <div class="page">

                        <%--分页按钮--%>
                        <div class="col offset-3">
                            <a href="#" class="num" id="firstPage">首页</a>
                            <a href="#" class="num" id="prePage">上一页</a>
                            <div style="display: inline-block" id="pageBtns"></div>
                            <a href="#" class="num" id="nextPage">下一页</a>
                            <a href="#" class="num" id="endPage">尾页</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<script type="text/javascript">

    //页码信息
    var page = 1;
    var prePage;
    var nextPage;
    var firstPage;
    var endPage;
    var pageSize;

    var storeId = '';
    var storeName = '';
    var pageInfo = {
        page: page,
        storeId: storeId,
        storeName: storeName
    }

    layui.use(['laydate', 'form'], function () {
        var laydate = layui.laydate;
        var form = layui.form;

        // 监听全选
        form.on('checkbox(checkAll)', function (data) {

            if (data.elem.checked) {
                $("tbody input[type='checkbox']").prop('checked', true);
            } else {
                $("tbody input[type='checkbox']").prop('checked', false);
            }
            form.render('checkbox');
        });

        //监听查找
        form.on('submit(search)',
            function (data) {
                console.log(data);
                pageInfo.storeId = data.field.storeId;
                pageInfo.storeName = data.field.storeName;
                console.log(pageInfo);
                //发异步，把数据提交给后台
                load(pageInfo);
                return false;
            });
    });

    layui.use(['form'], function () {
        form = layui.form;
    });

    function load(pageInfo) {
        var da = eval('(' + parent.json + ')');
        $.ajax({
            url: "/store/storeList.ajax",
            type: "get",
            data: pageInfo,
            dataType: "json",
            success: function (data) {
                var html = "";
                var t1 = '';
                var t2 = '';
                var t3 = '';
                var t4 = '';
                for (var i = 0; i < data.list.length; i++) {
                    if (data.list[i].state == '0') {
                        t1 = '已启用';
                        t2 = '停用';
                        t3 = '&#xe601;';
                        t4 = '';
                    } else {
                        t1 = '已停用';
                        t2 = '启用';
                        t3 = '&#xe62f;';
                        t4 = 'layui-btn-disabled';
                    }
                    html += "<tr>\n" +
                        "        <td>\n" +
                        "            <input type='checkbox' name='storeIds' value='"+data.list[i].storeId+"' lay-skin='primary'> \n" +
                        "        </td>"+
                        "        <td>" + data.list[i].storeId + "</td>\n" +
                        "        <td>" + data.list[i].storeName + "</td>\n" +
                        "        <td>" + data.list[i].num + "</td>\n" +
                        "        <td>" + data.list[i].uNum + "</td>\n" +
                        "        <td>" + data.list[i].dNum + "</td>\n" +
                        "        <td class='td-status'>\n" +
                        "             <span class='layui-btn layui-btn-normal layui-btn-mini " + t4 + "'>" + t1 + "</span></td>\n" +
                        "        <td class='td-manage'>\n" +
                        "            <a onclick=member_stop(this,'10001') href='javascript:;' title=" + t2 + ">\n" +
                        "               <i class='layui-icon'>" + t3 + "</i>\n" +
                        "            </a>\n" +
                        "            <a title='修改' onclick=updateStore(this)\n" +
                        "               href='javascript:;'>\n" +
                        "                <i class='layui-icon'>&#xe642;</i>\n" +
                        "            </a>\n" +
                        "            <a title='删除' onclick=deleteStore(this) href='javascript:;'>\n" +
                        "                <i class='layui-icon'>&#xe640;</i>\n" +
                        "            </a>" +
                        "        </td>\n" +
                        "    </tr>"
                }

                $("#tbody").html(html);
                form.render();

                page = data.nowPage;
                prePage = data.prePage;
                nextPage = data.nextPage;
                firstPage = data.firstPage;
                endPage = data.endPage;
                pageSize = data.pageSize;

                html = "";
                for (i = 1; i <= endPage; i++) {
                    html += "&nbsp;<a href='#' onclick=pageBtnClick(" + i + ") class='num' id='pageid" + i + "'>" + i + "</a>"
                }
                $("#pageBtns").html(html);

                $("[id=pageid" + page + "]").prop("style", "color: #0000FF");
            }
        })
    }

    //首页
    $("#firstPage").click(function () {
        pageInfo.page = firstPage;
        load(pageInfo);
    });

    //上一页
    $("#prePage").click(function () {
        pageInfo.page = prePage;
        load(pageInfo);
    });

    //下一页
    $("#nextPage").click(function () {
        pageInfo.page = nextPage;
        load(pageInfo);
    });

    //尾页
    $("#endPage").click(function () {
        pageInfo.page = endPage;
        load(pageInfo);
    });

    //点击页码按钮
    function pageBtnClick(pageid) {
        pageInfo.page = pageid;
        load(pageInfo);
    }

    var store;

    function updateStore(btn) {
        store = JSON.stringify({
            storeId: $(btn).parent().parent().find("td").eq(1).text(),
            storeName: $(btn).parent().parent().find("td").eq(2).text(),
            num: $(btn).parent().parent().find("td").eq(3).text(),
            uNum: $(btn).parent().parent().find("td").eq(4).text(),
            dNum: $(btn).parent().parent().find("td").eq(5).text(),
        })
        xadmin.open('修改', '/store/updateStorePage.do', 600, 400);
    }

    function deleteStore(obj) {
        layer.confirm("确定要删除<span class='x-red'>"+$(obj).parent().parent().find("td").eq(2).text()+"</span>吗？", function (index) {
            $.ajax({
                url: "/store/deleteStore.ajax",
                type: "get",
                data: {
                    storeId: $(obj).parent().parent().find("td").eq(1).text()
                },
                dataType: "text",
                success: function (data) {
                    if (data == 'true') {
                        layer.msg('删除成功', {icon: 6, time: 1000});
                        load(pageInfo);
                    } else {
                        layer.msg('删除失败', {icon: 5, time: 1000});
                        load(pageInfo);
                    }
                }

            })
        })
    }

    function deleteStores () {
        var ids = [];

        // 获取选中的id
        $("tbody input[type='checkbox']").each(function(index, el) {
            if($(this).prop('checked')){
                ids.push($(this).val())
            }
        });

        layer.confirm('确认要删除吗？'+ids.toString(),function(index){
            //捉到所有被选中的，发异步进行删除
            $.ajax({
                url:"/store/deleteStores.ajax",
                type:"get",
                data:{
                    storeIds:ids.toString()
                },
                dataType:"text",
                success:function (data) {
                    if (data == 'true'){
                        layer.msg('删除成功', {icon: 1});
                    }else {
                        layer.msg('删除失败', {icon: 2});
                    }
                }

            })
            // $(".layui-form-checked").not('.header').parents('tr').remove();
        });
    }

    /*库存-停用*/
    function member_stop(obj, id) {


        if ($(obj).attr('title') == '停用') {
            layer.confirm('确认要停用吗？', function (index) {
                //发异步把状态进行更改
                $.ajax({
                    url: "/store/updateStore.ajax",
                    type: "get",
                    data: {
                        storeId: $(obj).parent().parent().find("td").eq(1).text(),
                        state: -1
                    },
                    dataType: "text",
                    success: function (data) {
                        if (data == 'true') {
                            $(obj).attr('title', '启用')
                            $(obj).find('i').html('&#xe62f;');

                            $(obj).parents("tr").find(".td-status").find('span').addClass('layui-btn-disabled').html('已停用');
                            layer.msg('已停用!', {icon: 5, time: 1000});
                            load(pageInfo);
                        } else {
                            layer.msg('失败', {icon: 5, time: 1000});
                        }
                    }

                })
            })
        } else {
            layer.confirm('确认要启用吗？', function (index) {
                $.ajax({
                    url: "/store/updateStore.ajax",
                    type: "get",
                    data: {
                        storeId: $(obj).parent().parent().find("td").eq(1).text(),
                        state: 0
                    },
                    dataType: "text",
                    success: function (data) {
                        if (data == 'true') {
                            $(obj).attr('title', '停用')
                            $(obj).find('i').html('&#xe601;');

                            $(obj).parents("tr").find(".td-status").find('span').removeClass('layui-btn-disabled').html('已启用');
                            layer.msg('已启用!', {icon: 6, time: 1000});
                            load(pageInfo);
                        } else {
                            layer.msg('失败', {icon: 5, time: 1000});
                        }
                    }

                })
            })
        }

    }
</script>
