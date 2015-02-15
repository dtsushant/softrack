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
    <title>Project Status Report</title>
</head>
<body>
<div class="content">
    <div class="mainbar">
        <div class="page-head">
            <h2 class="pull-left"><i class="icon-table"></i> Project Status Report</h2>

            <div class="clearfix"></div>
        </div>
        <div class="matter">
            <div class="container-fluid">
                <div class="row-fluid">
                    <div class="span6">
                            <g:form action="renderPsr" method="get">
                            <fieldset class="form">
                                <div class="fieldcontain">
                                    <label for="fromDate">
                                        From Date:
                                        <span class="required-indicator">*</span>
                                    </label>
                                    <g:textField name="fromDate" required="" value="" class="datePicker"/>
                                </div>

                                <div class="fieldcontain">
                                    <label for="toDate">
                                        To Date:
                                        <span class="required-indicator">*</span>
                                    </label>
                                    <g:textField name="toDate" required="" value="" class="datePicker"/>
                                </div>
                            </fieldset>
                            <fieldset class="buttons">
                                <g:submitButton name="generate" class="save" value="Generate" />
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