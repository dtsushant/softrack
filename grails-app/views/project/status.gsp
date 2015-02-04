<%--
  Created by IntelliJ IDEA.
  User: spandey
  Date: 2/3/15
  Time: 12:01 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainLayout">
    <g:set var="entityName" value="${message(code: 'user.status', default: 'Status')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>
<body>
<div class="content">
    <div class="mainbar">
        <div class="page-head">
            <h2 class="pull-left"><i class="icon-table"></i> <g:message code="default.list.label" args="[entityName]"/></h2>

            <!-- Breadcrumb -->
            <div class="bread-crumb pull-right">
                <g:form url='[controller: "project", action: "status"]'
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
                                    <a class="btn add">Add New Status <span class="glyphicon glyphicon-plus" aria-hidden="true"></span></a>
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
                                        <g:sortableColumn property="name" title="Identifier"/>
                                        <th>Description</th>
                                        <th>Action</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <g:each in="${statusInstanceList}" status="i" var="statusInstance">
                                        <tr>
                                            <td class="statusName">${statusInstance.name}</td>
                                            <td class="statusDescription">${statusInstance.description}</td>
                                            <td>
                                                <a class="edit" data-status="${statusInstance.id}"><span class="icon-edit" data-toggle="tooltip" data-placement="top" title="Edit"></span></a>

                                            </td>
                                        </tr>

                                    </g:each>
                                    </tbody>
                                </table>

                                <div class="clearfix"></div>

                                <div class="widget-foot">

                                    <div class="pagination pull-right">
                                        <g:paginate total="${statusInstanceTotal}"/>
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
    <g:form action="addEditStatus" >
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="myModalLabel"></h3>
        </div>
        <div class="modal-body">

            <fieldset class="form">
                <div class="fieldcontain">
                    <label for="name">
                        Status Name:
                        <span class="required-indicator">*</span>
                    </label>
                    <g:textField name="name" required="" value=""/>
                </div>

                <div class="fieldcontain">
                    <label for="name">
                        Status Description:
                        <span class="required-indicator">*</span>
                    </label>
                    <g:textArea name="description" required="" value=""/>
                </div>
            </fieldset>
            <g:hiddenField name="id" value=""/>




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

            $("#myModalLabel").html("Edit Status");
            $("#create").val("Edit");
            $("#id").val($(this).data("status"));
            $("#name").val($(this).closest("tr").find(".statusName").html());
            $("#description").val($(this).closest("tr").find(".statusDescription").html());
            $("#modalBox").modal("show");
        });

        $(".add").on("click",function(){

            $("#myModalLabel").html("Add New Status");
            $("#create").val("Create Status");
            $("#id").val("");
            $("#name").val("");
            $("#description").val("");
            $("#modalBox").modal("show");
        });
    });
</script>



</body>
</html>