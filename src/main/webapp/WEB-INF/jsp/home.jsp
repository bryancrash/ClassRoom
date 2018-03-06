<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="utf-8"/>
    <title>教室使用查询</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/bootstrap-table/css/bootstrap-table.min.css">
    <link href="${pageContext.request.contextPath }/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css"
          rel="stylesheet" media="screen">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/bootstrap-select/css/bootstrap-select.min.css">

    <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/jquery.min.js"
            charset="UTF-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/bootstrap/js/bootstrap.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/bootstrap-table/js/bootstrap-table.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/bootstrap-table/js/bootstrap-table-zh-CN.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/bootstrap-select/js/bootstrap-select.min.js"></script>
    <style type="text/css">
        .table th{
            text-align: center;
            vertical-align: middle!important;
        }
         .table td {
            font-size: 26px;
            text-align: center;
            vertical-align: middle!important;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            //初始化Input
            var oInputInit = new InputInit();
            oInputInit.init();
            //1.初始化Table
            var oTable = new TableInit();
            oTable.Init();

            $('#tb_bigclassroomlist').bootstrapTable({
                height:$(window).height() - 200,
            });
            $('#tb_subclassroomlist').bootstrapTable({
                height:$(window).height() - 200,
            });
        });
        var TableInit = function () {
            var oTableInit = new Object();
            //初始化Table
            oTableInit.Init = function () {
                $('#tb_bigclassroomlist').bootstrapTable({
                    url: '${pageContext.request.contextPath }/classroom/mergeList',         //请求后台的URL（*）
                    method: 'post',                      //请求方式（*）
                    contentType: 'application/json;charset=UTF-8',
                    dataType: 'json',
                    //toolbar: '#toolbar',                //工具按钮用哪个容器
                    striped: true,                      //是否显示行间隔色
                    cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                    pagination: false,                   //是否显示分页（*）
                    sortable: false,                     //是否启用排序
                    sortOrder: "asc",                   //排序方式
                    queryParams: oTableInit.queryParams,//传递参数（*）
//                    sidePagination: "client",           //分页方式：client客户端分页，server服务端分页（*）
//                    pageNumber: 1,                       //初始化加载第一页，默认第一页
//                    pageSize: 10,                       //每页的记录行数（*）
//                    pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
                    search: true,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
                    strictSearch: true,
                    showColumns: true,                  //是否显示所有的列
                    showRefresh: true,                  //是否显示刷新按钮
                    minimumCountColumns: 2,             //最少允许的列数
                    clickToSelect: true,                //是否启用点击选中行
                    height: 500,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
                    uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
                    showToggle: true,                    //是否显示详细视图和列表视图的切换按钮
                    cardView: false,                    //是否显示详细视图
                    detailView: false,                   //是否显示父子表
                    columns: [{
                        field: 'buildingName',
                        title: '楼号'
                    }, {
                        field: 'classroom',
                        title: '教室'
                    }, {
                        field: 'first',
                        title: '第一节',
                        formatter:function(value){
                            var e;
                            if(value == "空闲"){
                                e = '<img src="img/classroom-free.gif" /> ';
                            }else if(value == "有课"){
                                e = '<img src="img/classroom-inuse.gif" /> ';
                            }
                            return e;
                        }
                    }, {
                        field: 'second',
                        title: '第二节',
                        formatter:function(value){
                            var e;
                            if(value == "空闲"){
                                e = '<img src="img/classroom-free.gif" /> ';
                            }else if(value == "有课"){
                                e = '<img src="img/classroom-inuse.gif" /> ';
                            }
                            return e;
                        }
                    }, {
                        field: 'third',
                        title: '第三节',
                        formatter:function(value){
                            var e;
                            if(value == "空闲"){
                                e = '<img src="img/classroom-free.gif" /> ';
                            }else if(value == "有课"){
                                e = '<img src="img/classroom-inuse.gif" /> ';
                            }
                            return e;
                        }
                    }, {
                        field: 'fourth',
                        title: '第四节',
                        formatter:function(value){
                            var e;
                            if(value == "空闲"){
                                e = '<img src="img/classroom-free.gif" /> ';
                            }else if(value == "有课"){
                                e = '<img src="img/classroom-inuse.gif" /> ';
                            }
                            return e;
                        }
                    }, {
                        field: 'fifth',
                        title: '第五节',
                        formatter:function(value){
                            var e;
                            if(value == "空闲"){
                                e = '<img src="img/classroom-free.gif" /> ';
                            }else if(value == "有课"){
                                e = '<img src="img/classroom-inuse.gif" /> ';
                            }
                            return e;
                        }
                    }, {
                        field: 'sixth',
                        title: '第六节',
                        formatter:function(value){
                            var e;
                            if(value == "空闲"){
                                e = '<img src="img/classroom-free.gif" /> ';
                            }else if(value == "有课"){
                                e = '<img src="img/classroom-inuse.gif" /> ';
                            }
                            return e;
                        }
                    },]
                });
                $('#tb_subclassroomlist').bootstrapTable({
                    url: '${pageContext.request.contextPath }/classroom/allList',         //请求后台的URL（*）
                    method: 'post',                      //请求方式（*）
                    contentType: 'application/json;charset=UTF-8',
                    dataType: 'json',
                    //toolbar: '#toolbar',                //工具按钮用哪个容器
                    striped: true,                      //是否显示行间隔色
                    cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                    pagination: false,                   //是否显示分页（*）
                    sortable: false,                     //是否启用排序
                    sortOrder: "asc",                   //排序方式
                    queryParams: oTableInit.queryParams,//传递参数（*）
                    sidePagination: "client",           //分页方式：client客户端分页，server服务端分页（*）
//                    pageNumber: 1,                       //初始化加载第一页，默认第一页
//                    pageSize: 10,                       //每页的记录行数（*）
//                    pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
                    search: true,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
                    strictSearch: true,
                    showColumns: true,                  //是否显示所有的列
                    showRefresh: true,                  //是否显示刷新按钮
                    minimumCountColumns: 2,             //最少允许的列数
                    clickToSelect: true,                //是否启用点击选中行
                    height: 500,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
                    uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
                    showToggle: true,                    //是否显示详细视图和列表视图的切换按钮
                    cardView: false,                    //是否显示详细视图
                    detailView: false,                   //是否显示父子表
                    columns: [{
                        field: 'buildingName',
                        align: 'center',
                        title: '楼号'
                    }, {
                        field: 'classroom',
                        align: 'center',
                        title: '教室'
                    }, {
                        field: 'first',
                        align: 'center',
                        title: '第一节',
                        formatter:function(value){
                            var e;
                            if(value == "空闲"){
                                e = '<img src="img/classroom-free.gif" /> ';
                            }else if(value == "有课"){
                                e = '<img src="img/classroom-inuse.gif" /> ';
                            }
                            return e;
                        }
                    }, {
                        field: 'second',
                        title: '第二节',
                        formatter:function(value){
                            var e;
                            if(value == "空闲"){
                                e = '<img src="img/classroom-free.gif" /> ';
                            }else if(value == "有课"){
                                e = '<img src="img/classroom-inuse.gif" /> ';
                            }
                            return e;
                        }
                    }, {
                        field: 'third',
                        title: '第三节',
                        formatter:function(value){
                            var e;
                            if(value == "空闲"){
                                e = '<img src="img/classroom-free.gif" /> ';
                            }else if(value == "有课"){
                                e = '<img src="img/classroom-inuse.gif" /> ';
                            }
                            return e;
                        }
                    }, {
                        field: 'fourth',
                        title: '第四节',
                        formatter:function(value){
                            var e;
                            if(value == "空闲"){
                                e = '<img src="img/classroom-free.gif" /> ';
                            }else if(value == "有课"){
                                e = '<img src="img/classroom-inuse.gif" /> ';
                            }
                            return e;
                        }
                    }, {
                        field: 'fifth',
                        title: '第五节',
                        formatter:function(value){
                            var e;
                            if(value == "空闲"){
                                e = '<img src="img/classroom-free.gif" /> ';
                            }else if(value == "有课"){
                                e = '<img src="img/classroom-inuse.gif" /> ';
                            }
                            return e;
                        }
                    }, {
                        field: 'sixth',
                        title: '第六节',
                        formatter:function(value){
                            var e;
                            if(value == "空闲"){
                                e = '<img src="img/classroom-free.gif" /> ';
                            }else if(value == "有课"){
                                e = '<img src="img/classroom-inuse.gif" /> ';
                            }
                            return e;
                        }
                    }, {
                        field: 'seventh',
                        title: '第七节',
                        formatter:function(value){
                            var e;
                            if(value == "空闲"){
                                e = '<img src="img/classroom-free.gif" /> ';
                            }else if(value == "有课"){
                                e = '<img src="img/classroom-inuse.gif" /> ';
                            }
                            return e;
                        }
                    }, {
                        field: 'eighth',
                        title: '第八节',
                        formatter:function(value){
                            var e;
                            if(value == "空闲"){
                                e = '<img src="img/classroom-free.gif" /> ';
                            }else if(value == "有课"){
                                e = '<img src="img/classroom-inuse.gif" /> ';
                            }
                            return e;
                        }
                    }, {
                        field: 'ninth',
                        title: '第九节',
                        formatter:function(value){
                            var e;
                            if(value == "空闲"){
                                e = '<img src="img/classroom-free.gif" /> ';
                            }else if(value == "有课"){
                                e = '<img src="img/classroom-inuse.gif" /> ';
                            }
                            return e;
                        }
                    }, {
                        field: 'tenth',
                        title: '第十节',
                        formatter:function(value){
                            var e;
                            if(value == "空闲"){
                                e = '<img src="img/classroom-free.gif" /> ';
                            }else if(value == "有课"){
                                e = '<img src="img/classroom-inuse.gif" /> ';
                            }
                            return e;
                        }
                    }, {
                        field: 'eleventh',
                        title: '第十一节',
                        formatter:function(value){
                            var e;
                            if(value == "空闲"){
                                e = '<img src="img/classroom-free.gif" /> ';
                            }else if(value == "有课"){
                                e = '<img src="img/classroom-inuse.gif" /> ';
                            }
                            return e;
                        }
                    }, {
                        field: 'twelfth',
                        title: '第十二节',
                        formatter:function(value){
                            var e;
                            if(value == "空闲"){
                                e = '<img src="img/classroom-free.gif" /> ';
                            }else if(value == "有课"){
                                e = '<img src="img/classroom-inuse.gif" /> ';
                            }
                            return e;
                        }
                    },]
                });
            };
            //得到查询的参数
            oTableInit.queryParams = function (params) {
                var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                    buildingName: $("#buildingname").selectpicker('val'),
                    //    $("#buildingname").val(),
                    datetime: $("#txt_search_date").val()
                };
                return JSON.stringify(temp);
            };
            return oTableInit;
        };
        var InputInit = function () {
            var oInputInit = new Object();
            oInputInit.init = function () {
                var now = new Date();
                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);
                var today = now.getFullYear() + "-" + (month) + "-" + (day);
                $("#txt_search_date").val(today); //设置
                $("#txt_now_date").val(today); //设置
            };
            return oInputInit;
        }

        function searchInfo() {
            $('#tb_subclassroomlist').bootstrapTable('refresh');
            $('#tb_bigclassroomlist').bootstrapTable('refresh');
        }
    </script>
</head>
<body>
<div class="container-fluid">
    <nav class="navbar navbar-default navbar-fixed-top" role="navigation" style="background-color: #2aabd2;">
        <div class="navbar-header">
            <h class="navbar-brand" style="color:#ffffff;">教室信息查询系统</h>
        </div>
    </nav>
    <div class="panel-body" style="padding-bottom:0px; margin-top: 35px;">
        <div class="panel panel-default">
            <div class="panel-heading" style="background-color: #F6EED7;">查询条件</div>
            <div class="panel-body">
                <form class="form-inline" role="form" id="formSearch">
                    <div class="form-group col-sm-5">
                        <label class="col-sm-2 control-label"><p style="margin-top:5px; padding-right:0px;">楼号:</p> </label>
                        <div class="col-sm-10" style="padding-left: 0px;">
                            <select id="buildingname" name="buildingname" class= "form-control show-tick selectpicker form-control-static" multiple>
                                <option value="19楼"> 19楼</option >
                                <option value="教1楼"> 教1楼</option >
                                <option value="教3楼"> 教3楼</option >
                                <option value="教4楼"> 教4楼</option >
                                <option value="阶梯"> 阶梯</option >
                                <option value="科研楼"> 科研楼</option>
                                <option value="综合楼"> 综合楼</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>
                            <h for="txt_search_date" style="padding-right:16px;">日期:</h>
                        </label>
                        <div class="input-group date form_date col-md-8" data-date="" data-date-format="yyyy-mm-dd"
                             data-link-field="txt_search_date" data-link-format="yyyy-mm-dd">
                            <input class="form-control" id="txt_now_date" size="16" type="text" value="" readonly>
                            <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                            <span class="input-group-addon"><span
                                    class="glyphicon glyphicon-calendar"></span></span>
                        </div>
                        <input type="hidden" id="txt_search_date" value=""/><br/>
                    </div>
                    <button type="button" id="btn_query" class="btn btn-primary" onclick="searchInfo()">查询</button>
                </form>
            </div>
        </div>
        <ul id="myTab" class="nav nav-tabs">
            <li class="active">
                <a href="#big" data-toggle="tab">大节</a>
            </li>
            <li>
                <a href="#small" data-toggle="tab">
                    小节
                </a>
            </li>
        </ul>
        <div id="myTabContent" class="tab-content">
            <div class="tab-pane fade table-responsive in active" id="big">
                <table id="tb_bigclassroomlist" align='center'></table>
            </div>
            <div class="tab-pane fade table-responsive" id="small" >
                <table id="tb_subclassroomlist" align='center'></table>
            </div>
        </div>

    </div>
</div>
</div>
<div id="footer" class="container">
    <nav class="navbar navbar-default navbar-fixed-bottom" style="padding: 10px;">
        <div class="navbar-inner navbar-content-center">
            <p class="text-muted credit text-center">
                版权所有 © 2018 大地书廊
            </p>
        </div>
    </nav>
</div>
<script type="text/javascript"
        src="${pageContext.request.contextPath }/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"
        charset="UTF-8"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath }/bootstrap-datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"
        charset="UTF-8"></script>
<script type="text/javascript">
    $('.form_date').datetimepicker({
        language: 'zh-CN',
        weekStart: 1,
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        minView: 2,
        forceParse: 0,
        initialDate: new Date()
    });
</script>
</body>
</html>
