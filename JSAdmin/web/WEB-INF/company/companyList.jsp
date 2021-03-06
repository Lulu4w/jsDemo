<%--
  Created by IntelliJ IDEA.
  User: Lulu
  Date: 2018/5/22
  Time: 13:19
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
    <%@include file="/WEB-INF/header.jsp"%>
    <title>用户管理</title>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 用户中心 <span class="c-gray en">&gt;</span> 用户管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-20">

    <div class="cl pd-5 bg-1 bk-gray mt-20"><span class="l"><a href="javascript:;" onclick="member_add('添加用户','<%=ctxPath%>/Company?action=add','','510')" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 添加用户</a></span>
    <span style="margin: 0 5px;" class="l"><a href="javascript:;" onclick="member_add('导入用户','<%=ctxPath%>/Company?action=add4xls','','510')" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 导入用户</a></span>  </div>
    <div class="mt-20">
        <table class="table table-border table-bordered table-hover table-bg table-sort">
            <thead>
            <tr class="text-c">
                <th width="80">ID</th>
                <th width="200">公司名</th>
                <th width="200">公司地址</th>
                <th width="80">公司人数</th>
                <th width="200">月最大用水量</th>
                <th width="200">联系方式</th>
                <th width="100">公司管理员</th>
                <th width="200">登录名</th>
                <th width="100">操作</th>
            </tr>
            </thead>
            <tbody>
                <c:forEach items="${companies}" var="company">
                <tr class="text-c">
                    <td><c:out value="${company.id}"/></td>
                    <td><c:out value="${company.name}"/></td>
                    <td><c:out value="${company.location}"/></td>
                    <td><c:out value="${company.peopleNum}"/></td>
                    <td><c:out value="${company.maxWaterMonth}"/></td>
                    <td><c:out value="${company.tel}"/></td>
                    <td><c:out value="${company.companyAdminName}"/></td>
                    <td><c:out value="${company.phoneNum}"/></td>

                    <td class="td-manage">
                        <a title="发送通知" href="javascript:;" onclick="member_edit('发送通知','<%=ctxPath%>/Notice?action=addnew&companyId=${company.id}')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe603;</i></a>
                        <a title="编辑" href="javascript:;" onclick="member_edit('编辑','<%=ctxPath%>/Company?action=edit&id=${company.id}','','','510')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>
                        <a style="text-decoration:none" class="ml-5" onClick="change_password('修改密码','<%=ctxPath%>/Company?action=updatePwd&id=${company.id}','','600','270')" href="javascript:;" title="修改密码"><i class="Hui-iconfont">&#xe63f;</i></a>
                        <a title="删除" href="javascript:;" onclick="member_del(this,'${company.id}')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a>
                    </td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script type="text/javascript">
    $(function(){
        $('.table-sort').dataTable({
            "aaSorting": [[ 0, "asc" ]],//默认第几个排序
            "bStateSave": true,//状态保存
            "aoColumnDefs": [
                //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
                {"orderable":false,"aTargets":[8]}// 制定列不参与排序
            ]
        });
        $('.table-sort tbody').on( 'click', 'tr', function () {
            if ( $(this).hasClass('selected') ) {
                $(this).removeClass('selected');
            }
            else {
                table.$('tr.selected').removeClass('selected');
                $(this).addClass('selected');
            }
        });
    });
    /*用户-添加*/
    function member_add(title,url,w,h){
        layer_show(title,url,w,h);
    }

    /*用户-编辑*/
    function member_edit(title,url,id,w,h){
        layer_show(title,url,w,h);
    }
    /*密码-修改*/
    function change_password(title,url,id,w,h){
        layer_show(title,url,w,h);
    }
    /*用户-删除*/
    function member_del(link,id){
        layer.confirm('确认要删除吗？',function(index){
            $.ajax({
                url:"<%=ctxPath%>/Company",type:"post",
                data:{action:"delete",id:id},
                success:function(obj) {
                    if(obj.status=="ok") {
                        $(link).parents("tr").remove();
                        layer.msg('已删除!',{icon:1,time:1000});
                    }
                    else {
                        alert("删除失败");
                    }
                },
                error:function(){alert("删除处理失败");}
            })
        });
    }
</script>
</body>
</html>
