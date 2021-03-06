<%--
  Created by IntelliJ IDEA.
  User: Lulu
  Date: 2018/5/18
  Time: 21:59
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
    <%@include file="/WEB-INF/header.jsp" %>
    <script type="text/javascript">
        $(function(){
            $("#btn1").click(function(){
                var arr = $("#form-role-add").serializeArray();
            });
        });
    </script>
    <title>添加角色</title>
</head>
<body>
<div class="pd-20">
    <form action="" method="post" class="form form-horizontal" id="form-role-add">
        <input type="hidden" name="action" value="addSubmit"/>
        <div class="row cl">
            <label class="form-label col-2"><span class="c-red">*</span>角色名：</label>
            <div class="formControls col-10">
                <input type="text" class="input-text" value="" placeholder="" id="member-name" name="rolename" datatype="*2-16" nullmsg="角色名不能为空">
            </div>
            <div class="col-4"> </div>
        </div>




        <div class="row cl">
            <label class="form-label col-2">权限：</label>
            <div class="formControls col-10">
                <dl class="permission-list">
                    <dt>
                        <label>权限列表</label>
                    </dt>
                    <dd>
                        <dl class="cl permission-list2">
                            <c:forEach items="${perms }" var="perm">
                                <div class="col-3"><input type="checkbox" name="permId" value="${perm.id }" id="permId${perm.id}" /><label for="permId${perm.id}"><c:out value="${perm.desc }"/></label></div>
                            </c:forEach>
                        </dl>
                    </dd>
                </dl>
            </div>
        </div>


        <div class="row cl">
            <div class="col-9 col-offset-3">
                <input class="btn btn-primary radius" type="button" id="btnSave" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
            </div>
        </div>
    </form>
</div>


<script type="text/javascript">
    $(function(){

        //必须放到页面初始化的时候，不能放到按钮点击里面
        var validForm = $("#form-role-add").Validform({tiptype:2});//初始化校验器
        $("#btnSave").click(function(){
            if(validForm.check(false)==false)//表单校验不通过
            {
                return;
            }

            var data = $("#form-role-add").serializeArray();//<input type="hidden" name="action" value="addSubmit"/>
            $.ajax({
                url:"<%=ctxPath%>/Role",type:"post",
                data:data,
                success:function(result){
                    if(result.status=="ok")
                    {
                        parent.location.reload();//刷新父窗口
                    }
                    else
                    {
                        alert("保存失败");
                    }
                },
                error:function(){alert("保存网络请求失败");}
            });
        });
    });
</script>
</body>
</html>
