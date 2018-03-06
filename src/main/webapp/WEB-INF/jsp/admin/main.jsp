<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>后台管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/bootstrap/css/bootstrap.css">
    <script type="text/javascript" src="${pageContext.request.contextPath }/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/bootstrap/js/bootstrap.js"></script>
</head>
<body>
<nav class="navbar navbar-inverse" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#">教室信息后台管理系统</a>
        </div>
    </div>
</nav>
<div class="container">
    <div class="row row-centered" style="margin-top: 80px;">
        <div class="well col-md-4 col-md-offset-4 col-centered">
            <form role="form" action="${pageContext.request.contextPath}/classroom/addList" method="post">
                <div class="form-group">
                    <label class="col-md-3 control-label" style="margin-top:8px; padding:0px;">选择年份:</label>
                    <div class="col-md-9">
                        <select class="form-control" name="year">
                            <option>2017</option>
                            <option>2018</option>
                            <option>2019</option>
                            <option>2020</option>
                            <option>2021</option>
                            <option>2022</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-4 col-sm-4" style="margin-top: 30px;">
                        <button type="submit" class="btn btn-default">更新数据库</button>
                    </div>

                </div>

            </form>
        </div>
    </div>
</div>
<nav class="navbar navbar-default navbar-fixed-bottom" style="margin-top: 100px;">
    <div class="container text-center">
        <p>教室查询后台系统</p>
    </div>
</nav>
</body>
</html>
