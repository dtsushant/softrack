<%--
  Created by IntelliJ IDEA.
  User: spandey
  Date: 2/3/15
  Time: 12:01 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="softrack.TaskDetails; softrack.Attachment; com.softrack.DateUtils" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainLayout">
    <title>#${task.taskType.name}${task.id}</title>
</head>
<body>
<div class="content">
    <div class="mainbar">
        <div class="page-head">
            <h2 class="pull-left"><i class="icon-table"></i> #${task.taskType.name}${task.id} ${task.heading}</h2>

            <div class="clearfix"></div>
        </div>
        <div class="matter">
            <div class="container-fluid">
                <div class="row-fluid">
                    <div class="span12">
                        <div class="widget">
                            <div class="widget-content">

                                <div class="row-fluid">
                                    <div class="span6 pull-left">
                                        <div class="control-group">
                                            <div class="controls">
                                                <b>Assigned To: </b> ${taskDetail.last().assignedTo.fullName}
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span6">
                                        <div class="control-group">
                                            <div class="controls">
                                                <b>Assigned By: </b> ${task.createdBy.fullName}
                                            </div>
                                        </div>
                                    </div>

                                </div>

                                <div class="row-fluid">
                                    <div class="span6 pull-left">
                                        <div class="control-group">
                                            <div class="controls">
                                                <b>Priority: </b> ${taskDetail.last().priority.priorityName}
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span6">
                                        <div class="control-group">
                                            <div class="controls">
                                                <b>Status: </b> ${taskDetail.last().status.name}
                                            </div>
                                        </div>
                                    </div>

                                </div>


                                <div class="row-fluid">
                                    <div class="span6 pull-left">
                                        <div class="control-group">
                                            <div class="controls">
                                                <b>Target Version: </b> ${taskDetail.last().ver.versionID}
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span6">
                                        <div class="control-group">
                                            <div class="controls">

                                            </div>
                                        </div>
                                    </div>

                                </div>


                                <div class="row-fluid">
                                    <div class="span6 pull-left">
                                        <div class="control-group">
                                            <div class="controls">
                                                <b>Date Created: </b> ${com.softrack.DateUtils.getFormattedDate(task.dateCreated)}
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span6">
                                        <div class="control-group">
                                            <div class="controls">
                                            </div>
                                        </div>
                                    </div>

                                </div>

                                <div class="row-fluid">
                                    <div class="span6 pull-left">
                                        <div class="control-group">
                                            <div class="controls">
                                                <b>Tentative Start Date: </b> ${DateUtils.getFormattedDate(task.taskStartDate)}
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span6">
                                        <div class="control-group">
                                            <div class="controls">
                                                <b>Tentative Start Date: </b> ${DateUtils.getFormattedDate(task.taskDeadline)}
                                            </div>
                                        </div>
                                    </div>

                                </div>

                                <div class="row-fluid">
                                    <div class="span12">
                                        <div class="control-group">
                                            <div class="controls">
                                                <b>Description</b>
                                            </div>
                                            <div class="controls">
                                                ${firstTask.description}
                                            </div>

                                            <g:each in="${firstAttachment}" var="attachment">
                                                <div class="controls">
                                                    <g:link controller="task" action="uploadedFile" params="[id:attachment.id]">${attachment.name}</g:link>
                                                </div>
                                            </g:each>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <g:each in="${taskDetail}" var="tdetail">
                            <g:if test="${tdetail.remarks}">
                                <div class="widget">
                                    <div class="widget-content">
                                        <div class="row-fluid">
                                            <div class="span12">
                                                <div class="control-group">
                                                    <div class="controls">
                                                        <b>${tdetail.remarks}</b>
                                                    </div>
                                                    <div class="controls">
                                                        ${tdetail.description}
                                                    </div>


                                                    <g:each in="${TaskDetails.get(tdetail.id).attachment}" var="attachment">
                                                        <div class="controls">
                                                            <a href="${createLink(controller: "task",action: "uploadedFile")}/${attachment.id}">${attachment.name}</a>
                                                        </div>
                                                    </g:each>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </g:if>
                        </g:each>


                        <div class="clearfix"></div>

                        <div class="widget-foot">

                            <div class="row-fluid">
                                <div class="span1 pull-right">
                                    <div class="controls">
                                        <g:link controller="task" action="updateTask" params="[id:task.id]">Update</g:link>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>









</body>
</html>