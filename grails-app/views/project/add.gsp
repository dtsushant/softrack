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
            <h2 class="pull-left"><i class="icon-table"></i> <g:message code="default.add.label" args="[entityName]"/>
            </h2>
            <div class="clearfix"></div>
        </div>
        <div class="matter">
            <div class="container-fluid">
                <div class="row-fluid">
                    <div class="span12">
                        <g:if test="${flash.message}">
                            <div class="alert alert-info" role="status">${flash.message}</div>
                        </g:if>


                        <g:form action="add" >
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
                            <fieldset class="buttons">
                                <g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                            </fieldset>
                        </g:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>