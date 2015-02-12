<%--
  Created by IntelliJ IDEA.
  User: spandey
  Date: 2/9/15
  Time: 11:01 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainLayout">
    <g:set var="entityName" value="${message(code: 'user.project', default: 'Version')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>
<body>
<div class="content">
    <div class="mainbar">
        <div class="page-head">
            <h2 class="pull-left"><i class="icon-table"></i> <g:message code="default.list.label" args="[entityName]"/></h2>
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
                                    <a class="btn add">Add New Version <span class="glyphicon glyphicon-plus" aria-hidden="true"></span></a>
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
                                        <th>Project</th>
                                        <th>Versions</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    %{--<g:each in="${versionList}" status="i" var="versionInstance">
                                        <tr>
                                            <td class="versionID">${versionInstance.versionID}</td>
                                            <td class="versionProject">
                                                ${versionInstance.project.name}
                                                <span class="projectId" style="display:none;">${versionInstance.project.id}</span>
                                            </td>
                                            <td class="versionStartDate">${versionInstance.tentativeStartDate}</td>
                                            <td class="versionEndDate">${versionInstance.tentativeEndDate}</td>
                                            <td>
                                                <a class="edit" data-version="${versionInstance.id}"><span class="icon-edit" data-toggle="tooltip" data-placement="top" title="Edit"></span></a>
                                            </td>
                                        </tr>

                                    </g:each>--}%
                                    <g:each in="${projectInstanceList}" var="projectInstance">
                                        <tr>
                                            <td>${projectInstance.name}</td>
                                            <td><%
                                                versionList.findAll{it.project.id==projectInstance.id}?.each {  %>
                                                <span>
                                                    <span style="display: none;" class="projectId">${projectInstance.id}</span>
                                                    <span style="display: none;" class="versionStartDate">${it.tentativeStartDate}</span>
                                                    <span style="display: none;" class="versionEndDate">${it.tentativeEndDate}</span>

                                                <u><a class="edit" data-version="${it.id}">${it.versionID}</a></u>
                                                </span>
                                                <% } %>
                                            </td>
                                        </tr>
                                    </g:each>
                                    </tbody>
                                </table>

                                <div class="clearfix"></div>

                                <div class="widget-foot">

                                    <div class="pagination pull-right">
                                        <g:paginate total="${versionTotal}" max="${params.max}" params="${params}"/>
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
    <g:form action="addVersion" >
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="myModalLabel"></h3>
        </div>
        <div class="modal-body">

            <fieldset class="form">
                <div class="fieldcontain">
                    <label for="versionID">
                        Version Id:
                        <span class="required-indicator">*</span>
                    </label>
                    <g:textField name="versionID" required="" value=""/>
                </div>

                <div class="fieldcontain">
                    <label for="project">
                        Project:
                        <span class="required-indicator">*</span>
                    </label>
                    <g:select name="project" from="${projectInstanceList}" optionValue="name" optionKey="id" value="" />
                </div>

                <div class="fieldcontain">
                    <label for="tentativeStartDate">
                        Tentative Start Date:
                        <span class="required-indicator">*</span>
                    </label>
                    <g:textField name="tentativeStartDate" required="" value="" class="datePicker"/>
                </div>

                <div class="fieldcontain">
                    <label for="tentativeEndDate">
                        Tentative End Date:
                        <span class="required-indicator">*</span>
                    </label>
                    <g:textField name="tentativeEndDate" required="" value="" class="datePicker"/>
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

            $("#myModalLabel").html("Edit Version");
            $("#create").val("Edit");
            $("#id").val($(this).data("version"));
            //$("#versionID").val($(this).closest("span").find(".versionID").html());
            $("#versionID").val($(this).html());
            $("#project").val($(this).closest("span").find(".projectId").html());
            $("#tentativeStartDate").datepicker( "setDate" , new Date($(this).closest("span").find(".versionStartDate").html().split(" ")[0]));
            $("#tentativeEndDate").datepicker( "setDate" , new Date($(this).closest("span").find(".versionEndDate").html().split(" ")[0]));
            $("#modalBox").modal("show");
        });

        $(".add").on("click",function(){

            $("#myModalLabel").html("Add New Version");
            $("#create").val("Add Version");
            $("#id").val("");
            $("#versionID").val("");
            $("#project").val("");
            $("#tentativeStartDate").val("");
            $("#tentativeEndDate").val("");
            $("#modalBox").modal("show");
        });
    });
</script>



</body>
</html>