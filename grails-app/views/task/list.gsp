<%--
  Created by IntelliJ IDEA.
  User: spandey
  Date: 2/3/15
  Time: 12:01 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="softrack.Project" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainLayout">
    <title>Task List</title>
</head>
<body>
<div class="content">
    <div class="mainbar">
        <div class="page-head">
            <h2 class="pull-left"><i class="icon-table"></i>Task List</h2>
            <div class="clearfix"></div>
        </div>
        <div class="matter">
            <div class="container-fluid">
                <div class="row-fluid">
                    <div class="span12">
                        <div class="widget">

                            <div class="widget-content">

                                <table class="table table-striped table-bordered table-hover">

                                    <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Task Type</th>
                                        <th>Status</th>
                                        <th>Priority</th>
                                        <th>Subject</th>
                                        <th>Added By</th>
                                        <th>Assigned To</th>
                                        <th>Last Updated</th>
                                        <th>Version</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                        <g:each in="${taskList}" var="task">
                                            <tr>
                                                <td><g:link controller="task" action="index" params="[id:task.id]">${task.id}</g:link></td>
                                                <td>${task.taskType.name}</td>
                                                <td>${task.taskDetail?.last()?.status?.name}</td>
                                                <td>${task.taskDetail.last()?.priority?.priorityName}</td>
                                                <td><g:link controller="task" action="index" params="[id:task.id]">${task.heading}</g:link></td>
                                                <td>${task.createdBy?.fullName}</td>
                                                <td>${task.taskDetail?.last()?.assignedTo.fullName}</td>
                                                <td>${task.taskDetail.last()?.updatedBy?.fullName}</td>
                                                <td>${task.taskDetail.last()?.ver?.versionID}</td>
                                            </tr>
                                        </g:each>
                                    </tbody>
                                </table>

                                <div class="clearfix"></div>

                                <div class="widget-foot">

                                    <div class="pagination pull-right">
                                        <g:paginate total="${taskTotal}" max="${params.max}" params="${params}"/>
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




</body>
</html>