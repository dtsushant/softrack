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
    <g:set var="entityName" value="${message(code: 'user.requestMap', default: 'RequestMap')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>
<body>
<div class="content">
    <div class="mainbar">
        <div class="page-head">
            <h2 class="pull-left"><i class="icon-table"></i> <g:message code="default.list.label" args="[entityName]"/></h2>

            <!-- Breadcrumb -->
            <div class="bread-crumb pull-right">
                <g:form url='[controller: "user", action: "requestMap"]'
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
                                    <a class="btn add">Add New RequestMap <span class="glyphicon glyphicon-plus" aria-hidden="true"></span></a>
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
                                        <g:sortableColumn property="url" title="Identifier"/>
                                        <th>Roles</th>
                                        <th>Action</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <g:each in="${requestMapInstanceList}" status="i" var="requestMapInstance">
                                        <tr>
                                            <td class="requestMapUrl">${requestMapInstance.url}</td>
                                            <td class="requestMapConfigAttribute">${requestMapInstance.configAttribute}</td>
                                            <td>
                                                <a class="edit" data-requestmap="${requestMapInstance.url}"><span class="icon-edit" data-toggle="tooltip" data-placement="top" title="Edit"></span></a>

                                            </td>
                                        </tr>

                                    </g:each>
                                    </tbody>
                                </table>

                                <div class="clearfix"></div>

                                <div class="widget-foot">

                                    <div class="pagination pull-right">
                                        <g:paginate total="${requestMapInstanceTotal}" max="${params.max}" params="${params}"/>
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
    <g:form action="addEditRequestMap" >
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="myModalLabel"></h3>
        </div>
        <div class="modal-body">

            <fieldset class="form">
                <div class="fieldcontain">
                    <label for="name">
                        Url:
                        <span class="required-indicator">*</span>
                    </label>
                    <g:textField name="url" required="" value=""/>
                </div>
            </fieldset>

            <fieldset class="form">
                <div class="fieldcontain">
                    <g:checkBox name="configAttribute" value="IS_AUTHENTICATED_ANONYMOUSLY" checked="false"/> IS_AUTHENTICATED_ANONYMOUSLY
                    <g:each in="${roleInstanceList}" status="i" var="roleInstance">
                        <label class="checkbox">
                            <g:checkBox name="configAttribute" value="${roleInstance.authority}" checked="false"/> ${roleInstance.authority}
                        </label>
                    </g:each>

                    %{--<label for="name">
                        Url:
                        <span class="required-indicator">*</span>
                    </label>
                    <g:textField name="authority" required="" value=""/>--}%
                </div>
            </fieldset>
        </div>
        <g:hiddenField name="prevUrl" />
        <div class="modal-footer">
            <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
        <g:submitButton name="create" class="save btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
    </g:form>
</div>
</div>
<script>
    $(document).ready(function(){
        $(".edit").on("click",function(){

            $("#myModalLabel").html("Edit RequestMap");
            $("#create").val("Edit");
            $("#url").val($(this).data("requestmap"));
            $("input[name=configAttribute]").removeAttr('checked');
            var configAttributes = $(this).closest("tr").find(".requestMapConfigAttribute").html().split(",");
            for(var i =0; i<configAttributes.length;i++){
                //console.log(configAttributes[i]);
                $('input[name=configAttribute][value="'+configAttributes[i]+'"]').prop("checked", true);
            }
            $("#prevUrl").val($(this).data("requestmap"));
            $("#modalBox").modal("show");
        });

        $(".add").on("click",function(){

            $("#myModalLabel").html("Add New RequestMap");
            $("#create").val("Create RequestMap");
            $("input[name=configAttribute]").removeAttr('checked');
            $("#prevUrl").val("");
            $("#url").val("");
            $("#modalBox").modal("show");
        });
    });
</script>



</body>
</html>