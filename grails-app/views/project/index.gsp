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
    <g:set var="entityName" value="${message(code: 'user.project', default: 'Project')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>
<body>
<div class="content">
    <div class="mainbar">
        <div class="page-head">
            <h2 class="pull-left"><i class="icon-table"></i> <g:message code="default.list.label" args="[entityName]"/></h2>

            <!-- Breadcrumb -->
            <div class="bread-crumb pull-right">
                <g:form url='[controller: "project", action: "index"]'
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
                                    %{--<g:link controller="project" action="add" class="btn">Add New Project <span class="glyphicon glyphicon-plus" aria-hidden="true"></span></g:link>--}%
                                    <a class="btn add">Add New Project <span class="glyphicon glyphicon-plus" aria-hidden="true"></span></a>
                                </div>
                            </div>
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
                                        <g:sortableColumn property="name" title="name"/>
                                        <th>Owner</th>
                                        <th>Action</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <g:each in="${projectInstanceList}" status="i" var="projectInstance">
                                        <tr>
                                            <td class="projectName">${projectInstance.name}</td>
                                            <td class="projectOwner">${projectInstance.owner}</td>
                                            <td>
                                                <a class="edit" data-project="${projectInstance.id}"><span class="icon-edit" data-toggle="tooltip" data-placement="top" title="Edit"></span></a>

                                            </td>
                                        </tr>

                                    </g:each>
                                    </tbody>
                                </table>

                                <div class="clearfix"></div>

                                <div class="widget-foot">

                                    <div class="pagination pull-right">
                                        <g:paginate total="${projectInstanceTotal}"/>
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
    <g:form action="add" >
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="myModalLabel"></h3>
    </div>
    <div class="modal-body">

            <fieldset class="form">
                <div class="fieldcontain">
                    <label for="name">
                        Project Name:
                        <span class="required-indicator">*</span>
                    </label>
                    <g:textField name="name" required="" value=""/>
                </div>

                <div class="fieldcontain">
                    <label for="name">
                        Project Owner:
                        <span class="required-indicator">*</span>
                    </label>
                    <g:textField name="owner" required="" value=""/>
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

            $("#myModalLabel").html("Edit Project");
            $("#create").val("Edit");
            $("#id").val($(this).data("project"));
            $("#name").val($(this).closest("tr").find(".projectName").html());
            $("#owner").val($(this).closest("tr").find(".projectOwner").html());
            $("#modalBox").modal("show");
        });

        $(".add").on("click",function(){

            $("#myModalLabel").html("Add New Project");
            $("#create").val("Create Project");
            $("#id").val("");
            $("#name").val("");
            $("#owner").val("");
            $("#modalBox").modal("show");
        });
    });
</script>



</body>
</html>