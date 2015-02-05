<%--
  Created by IntelliJ IDEA.
  User: spandey
  Date: 2/3/15
  Time: 12:01 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="com.softrack.StringUtils; com.softrack.Role" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainLayout">
    <g:set var="entityName" value="${message(code: 'user.role', default: 'Role')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>
<body>
<div class="content">
    <div class="mainbar">
        <div class="page-head">
            <h2 class="pull-left"><i class="icon-table"></i> <g:message code="default.list.label" args="[entityName]"/></h2>

            <!-- Breadcrumb -->
            <div class="bread-crumb pull-right">
                <g:form url='[controller: "user", action: "roles"]'
                        id="searchableForm"
                        name="searchableForm"
                        method="get"
                        class="navbar-search">
                    <g:textField name="q" value="${params.q}" size="50" class="search-query" placeholder="Search Project"/>
                </g:form>

                <g:set var="haveQuery" value="${params.q?.trim()}"/>

            </div>

            <div class="clearfix"></div>
        </div>
        <div class="matter">
            <div class="container-fluid">
                <div class="row-fluid">
                    <div class="span12">
                        <g:if test="${flash.message}">
                            <div class="alert alert-info" role="status">${flash.message}</div>
                        </g:if>

                        <div class="widget-foot">
                            <div class="control-group">
                                <div class="controls">
                                    <a class="btn add">Add New Role <span class="glyphicon glyphicon-plus" aria-hidden="true"></span></a>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="widget">

                            <div class="widget-head">
                                <div class="pull-left">Tables </div>
                                <div class="clearfix"></div>
                            </div>

                            <div class="widget-content">

                                <table class="table table-striped table-bordered table-hover">

                                    <thead>
                                    <tr>
                                        <g:sortableColumn property="authority" title="Identifier"/>
                                        <th>Accessible TaskType</th>
                                        <th>Action</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <g:each in="${roleInstanceList}" status="i" var="roleInstance">
                                        <tr>
                                            <g:set var="taskVar"  value="${isSearch?Role.get(roleInstance.id)?.taskType:roleInstance?.taskType}" />
                                            <td class="roleAuthority">${roleInstance.authority}</td>
                                            <td>
                                                ${StringUtils.ListToString(taskVar?.name)}
                                                <input type="hidden" class="roleTasks" value="${ StringUtils.ListToString(taskVar?.id)}"/>
                                            </td>
                                            <td>
                                                <a class="edit" data-role="${roleInstance.authority}"><span class="icon-edit" data-toggle="tooltip" data-placement="top" title="Edit"></span></a>

                                            </td>
                                        </tr>

                                    </g:each>
                                    </tbody>
                                </table>

                                <div class="clearfix"></div>

                                <div class="widget-foot">

                                    <div class="pagination pull-right">
                                        <g:paginate total="${roleInstanceTotal}" max="${params.max}" params="${params}"/>
                                    </div>

                                    <div class="clearfix"></div>

                                </div>
                            </div>


                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>




<div id="modalBox" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <g:form action="addEditRole" >
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="myModalLabel"></h3>
        </div>
        <div class="modal-body">

            <fieldset class="form">
                <div class="fieldcontain">
                    <label for="name">
                        Role:
                        <span class="required-indicator">*</span>
                    </label>
                    <g:textField name="authority" required="" value=""/>
                </div>

                <g:each in="${taskTypeInstanceList}" status="i" var="taskTypeInstance">
                    <label class="checkbox">
                        <g:checkBox name="taskType" value="${taskTypeInstance.id}" checked="false"/> ${taskTypeInstance.name}
                    </label>
                </g:each>
            </fieldset>
        </div>
        <g:hiddenField name="prevAuthority" />
        <div class="modal-footer">
            <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
        <g:submitButton name="create" class="save btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
    </g:form>
</div>
</div>
<script>
    $(document).ready(function(){
        $(".edit").on("click",function(){

            $("#myModalLabel").html("Edit Role");
            $("#create").val("Edit");
            $("#authority").val($(this).data("role"));
            $("#prevAuthority").val($(this).data("role"));
            $("input[name=taskType]").removeAttr('checked');
            var taskType = $(this).closest("tr").find(".roleTasks").val().split(",");
            for(var i =0; i<taskType.length;i++){
                //console.log(configAttributes[i]);
                $('input[name=taskType][value="'+taskType[i]+'"]').prop("checked", true);
            }
            $("#modalBox").modal("show");
        });

        $(".add").on("click",function(){

            $("#myModalLabel").html("Add New Role");
            $("#create").val("Create Role");
            $("#authority").val("");
            $("#prevAuthority").val("");
            $("input[name=taskType]").removeAttr('checked');
            $("#modalBox").modal("show");
        });
    });
</script>



</body>
</html>