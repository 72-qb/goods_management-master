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
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/xadmin.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]--></head>

<body>
<div class="layui-fluid">
    <div class="layui-row">
        <form>
           <%-- <div class="layui-form-item">
                <label for="producerId" class="layui-form-label">
                    <span class="x-red">*</span>生产商编号</label>
                <div class="layui-input-inline">

            </div>--%>
               <input type="hidden" id="producerId" name="producerId" required="" lay-verify="required" autocomplete="off" class="layui-input">
            <div class="layui-form-item">
                <label for="name" class="layui-form-label">
                    <span class="x-red">*</span>生产商名称</label>
                <div class="layui-input-inline">
                    <input type="text" id="name"  name="name" required="" lay-verify="required" autocomplete="off" class="layui-input"></div>
            </div>
            <div class="layui-form-item">
                <label for="address" class="layui-form-label">
                    <span class="x-red">*</span>生产商地址</label>
                <div class="layui-input-inline layui-show-xs-block layui-form">
                    <input type="text" id="address" name="address" required="" lay-verify="phone" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label for="tel" class="layui-form-label">
                    <span class="x-red">*</span>联系方式</label>
                <div class="layui-input-inline layui-show-xs-block layui-form">
                    <input type="text" id="tel" name="tel" required="" lay-verify="phone" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label for="btn" class="layui-form-label"></label>
                <button id="btn" class="layui-btn" onclick="save()">保存</button></div>
        </form>
    </div>
</div>
<script>
    layui.use(['form'], function(){
        form = layui.form;
        form.render('select',"test1");
    });
    var data = eval('('+parent.json+')');
    $("#producerId").val(data.producerId);
    $("#name").val(data.name);
    $("#address").val(data.address);
    $("#tel").val(data.tel);
    function save(){
        $.ajax({
            type:"get",
            url:"${pageContext.request.contextPath}/gc/updateProSave.ajax",
            dataType:"text",
            data:$("form").serialize(),
            contentType:"charset=UTF-8",
            success:function (info) {
                /* layer.close(layer.index);
                 window.parent.location.reload();*/
                var index=parent.layer.getFrameIndex(window.name); //获取当前窗口的name
                /*window.parent.location.reload();*/
                window.parent.load(data.nowPage);
                parent.layer.close(index);		//关闭窗口

            },
            error:function () {
                alert("失败222") ;
            }
        })
    }
    layui.use(['form', 'layer'],
        function() {
            $ = layui.jquery;
            var form = layui.form,
                layer = layui.layer;

            //自定义验证规则
            form.verify({
                nikename: function(value) {
                    if (value.length < 5) {
                        return '昵称至少得5个字符啊';
                    }
                },
                pass: [/(.+){6,12}$/, '密码必须6到12位'],
                repass: function(value) {
                    if ($('#L_pass').val() != $('#L_repass').val()) {
                        return '两次密码不一致';
                    }
                }
            });

            //监听提交
            form.on('submit(add)',
                function(data) {
                    console.log(data);
                    //发异步，把数据提交给php
                    layer.alert("增加成功", {
                            icon: 6
                        },
                        function() {
                            // 获得frame索引
                            var index = parent.layer.getFrameIndex(window.name);
                            //关闭当前frame
                            parent.layer.close(index);
                        });
                    return false;
                });

        });</script>
<script>var _hmt = _hmt || []; (function() {
    var hm = document.createElement("script");
    hm.src = "https://hm.baidu.com/hm.js?b393d153aeb26b46e9431fabaf0f6190";
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(hm, s);
})();</script>
</body>

</html>
