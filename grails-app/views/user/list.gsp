<%@ page import="com.softrack.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="mainLayout">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<!-- Main content starts -->

<div class="content">

    <!-- Main bar -->
    <div class="mainbar">
        <!-- Page heading -->
        <div class="page-head">
            <h2 class="pull-left"><i class="icon-table"></i> <g:message code="default.list.label" args="[entityName]"/>
            </h2>

            <g:render template="searchForm"/>

            <div class="clearfix"></div>

        </div>
        <!-- Page heading ends -->

        <!-- Matter -->

        <div class="matter">
            <div class="container-fluid">
                <div class="row-fluid">
                    <div class="span12">
                        <g:if test="${flash.message}">
                            <div class="alert alert-info" role="status">${flash.message}</div>
                        </g:if>
                        <div class="widget-foot">
                            %{--<g:link controller="user" action="create" class="btn">Create User</g:link>--}%
                            <a class="btn add">Create User <span class="glyphicon glyphicon-plus" aria-hidden="true"></span></a>
                            <div class="clearfix"></div>
                        </div>
                        <div class="widget">

                            <div class="widget-head">
                                <div class="pull-left">Tables</div>

                                <div class="clearfix"></div>
                            </div>

                            <div class="widget-content">

                                <table class="table table-striped table-bordered table-hover">

                                    <thead>

                                    <tr>

                                        <th>#</th>

                                        <g:sortableColumn property="firstName"
                                                          title="${message(code: 'user.name.label', default: 'Name')}"/>

                                        <g:sortableColumn property="username"
                                                          title="${message(code: 'user.username.label', default: 'Username')}"/>

                                        <th>${message(code: 'role.authorities.label', default: 'User Groups')}</th>

                                        <th>${message(code: 'user.enabled.label', default: 'Enabled')}</th>

                                        <g:sortableColumn property="dateCreated"
                                                          title="${message(code: 'user.enabled.label', default: 'Registration Date')}"/>

                                        <th>${message(code: 'user.passwordExpired.label', default: 'Password Expired')}</th>

                                        <th>Control</th>

                                    </tr>

                                    </thead>

                                    <tbody>

                                    <g:each in="${userInstanceList}" status="i" var="userInstance">

                                        <tr>
                                            <td>${i + 1}</td>

                                            <td><g:link action="show"
                                                        id="${userInstance.id}">${fieldValue(bean: userInstance, field: "firstName")} ${fieldValue(bean: userInstance, field: "middleName")} ${fieldValue(bean: userInstance, field: "lastName")}</g:link></td>

                                            <td>${fieldValue(bean: userInstance, field: "username")}</td>

                                            <td>${userInstance.authorities.authority}</td>

                                            <td><span
                                                    class="${userInstance.enabled ? 'label label-success' : 'label label-important'}">
                                                <g:formatBoolean boolean="${userInstance.enabled}"/></span></td>

                                            <td><g:formatDate format="yyyy-MM-dd">{fieldValue(bean: userInstance, field: "dateCreated")}</g:formatDate></td>

                                            <td><span
                                                    class="${!userInstance.passwordExpired ? 'label label-success' : 'label label-important'}">
                                                <g:formatBoolean boolean="${userInstance.passwordExpired}"/></span></td>

                                            <td>
                                                %{--<g:isHiddenForLoggedInUser value="${userInstance?.id}">
                                                    <g:link class="btn btn-mini btn-warning" controller="user" action="edit"
                                                            id="${userInstance?.id}"><i
                                                            class="icon-pencil"></i></g:link>
                                                </g:isHiddenForLoggedInUser>
                                                <g:isHiddenForLoggedInUser value="${userInstance?.id}">
                                                    <g:link class="btn btn-mini btn-success" name="enabled"
                                                            controller="user" action="enableUser"
                                                            id="${userInstance?.id}"><i class="icon-ok"></i></g:link>
                                                </g:isHiddenForLoggedInUser>
                                                <g:isHiddenForLoggedInUser value="${userInstance?.id}">
                                                    <g:link class="btn btn-mini btn-danger" name="disabled"
                                                            controller="user" action="disableUser"
                                                            id="${userInstance?.id}"><i class="icon-minus"></i></g:link>
                                                </g:isHiddenForLoggedInUser>--}%
                                            </td>

                                        </tr>

                                    </g:each>

                                    </tbody>

                                </table>

                                <div class="widget-foot">

                                    <div class="pagination pull-right">
                                        <g:paginate total="${userInstanceTotal}"/>
                                    </div>

                                    <div class="clearfix"></div>

                                </div>

                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Matter ends -->
    </div>
    <!-- Mainbar ends -->
</div>


<div id="modalBox" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <g:form action="save" >
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="myModalLabel"></h3>
        </div>
        <div class="modal-body" id="myModalBody">

        </div>
        <div class="modal-footer">
            <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
        <g:submitButton name="create" class="save btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
    </g:form>
</div>
</div>

<script>
    $(document).ready(function(){
        $(".edit").on("click",function(){

            $("#myModalLabel").html("Edit Priority");
            $("#create").val("Edit");
            $("#id").val($(this).data("priority"));
            $("#priorityName").val($(this).closest("tr").find(".priorityName").html());
            $("#description").val($(this).closest("tr").find(".priorityDescription").html());
            $("#modalBox").modal("show");
        });

        $(".add").on("click",function(){

            $("#myModalLabel").html("Add New User");
            $("#create").val("Create User");
            $.ajax({
                url: "${createLink(controller: "user",action:"loadForm")}",
                method:"post",
                data:{},
                success:function(data){
                    $("#myModalBody").html(data);
                    $("#modalBox").modal("show");
                }

            });
        });
    });
</script>

</body>