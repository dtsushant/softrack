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
    <g:set var="entityName" value="${message(code: 'user.project', default: 'Overview')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>
<body>
<div class="content">
    <div class="mainbar">
        <div class="page-head">
            <h2 class="pull-left"><i class="icon-table"></i> Overview</h2>

            <div class="clearfix"></div>
        </div>
        <div class="matter">
            <div class="container-fluid">
                <div class="row-fluid">
                    <div class="span6 pull-left">
                        <div class="control-group">
                            <div class="controls">
                                <b>Project: ${project.name}</b>
                            </div>
                        </div>

                        <div class="control-group">
                            <div class="controls">
                                <b>Current Version: ${project.version}</b>
                            </div>
                        </div>


                        <div class="control-group">
                            <div class="controls">
                                <b>Task Trackers:</b>

                            </div>
                            <g:each in="${trackers}" var="track">
                                <div class="controls">
                                <b>${track.getKey()}:</b> ${track.getValue()}
                                </div>
                            </g:each>
                        </div>
                    </div>
                    <div class="span6">
                        <div class="controls">
                            <b>Members:</b>

                        </div>
                        <g:each in="${userList}" var="user">
                            <div class="controls">
                            ${user.fullName}
                            </div>
                        </g:each>
                    </div>
                </div>
            </div>
        </div>
    </div>









</body>
</html>