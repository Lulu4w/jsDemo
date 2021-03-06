<%--
  User: Lulu
  Date: 2018/5/19
  Time: 23:02
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
    <%@include file="/WEB-INF/header.jsp" %>
    <title>外链列表</title>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 外链管理  <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-20">

    <div class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l"> <a class="btn btn-primary radius" onclick="article_add('添加外链','<%=ctxPath%>/Link?action=linkAdd')" href="javascript:;"><i class="Hui-iconfont">&#xe600;</i> 添加外链</a></span> </div>
    <div class="mt-20">
        <table class="table table-border table-bordered table-bg table-hover table-sort">
            <thead>
            <tr class="text-c">
                <th width="100">ID</th>
                <th>名称</th>
                <th width="120">链接</th>

                <th width="120">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${links}" var="link">
                <tr class="text-c">
                    <td><c:out value="${link.id}"/></td>
                    <td><c:out value="${link.name}"/></td>
                    <td><c:out value="${link.url}"/></td>
                    <td class="f-14 td-manage">
                        <a style="text-decoration:none" class="ml-5" onClick="article_edit('外链编辑','<%=ctxPath%>/Link?action=edit&id=${link.id}','${link.id}')" href="javascript:;" title="编辑"><i class="Hui-iconfont">&#xe6df;</i></a>
                        <a style="text-decoration:none" class="ml-5" onClick="article_del(this,'${link.id}')" href="javascript:;" title="删除"><i class="Hui-iconfont">&#xe6e2;</i></a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script type="text/javascript">
    $('.table-sort').dataTable({
        "aaSorting": [[ 0, "asc" ]],//默认第几个排序
        "bStateSave": true,//状态保存
        "aoColumnDefs": [
            //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
            {"orderable":false,"aTargets":[3]}// 制定列不参与排序
        ]
    });

    /*资讯-添加*/
    function article_add(title,url,w,h){
        var index = layer.open({
            type: 2,
            title: title,
            content: url
        });
        layer.full(index);
    }
    /*资讯-编辑*/
    function article_edit(title,url,id,w,h){
        var index = layer.open({
            type: 2,
            title: title,
            content: url
        });
        layer.full(index);
    }
    /*资讯-删除*/
    function article_del(link,id){
        layer.confirm('确认要删除吗？',function(index){
            $.ajax({
                url:"<%=ctxPath%>/Link?action=delete",type:"post",
                data:{id:id},
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