<!DOCTYPE html>
<html lang="en"><head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <!-- Title and other stuffs -->
    <title><g:layoutTitle default="Deerwalk Salary System"/></title>
    <r:require module="core"/>
    <g:layoutHead/>
    <r:layoutResources/>
    <script type="text/javascript">
        $(document).ready(function(){
            $(".datePicker").datepicker({dateFormat: 'yy-mm-dd'});
        });

    </script>
</head>

<body>

<div class="navbar navbar-fixed-top">
    <div class="navbar-inner">
        <div class="container">

            <!-- Navigation starts -->
            <div class="nav-collapse collapse row">

                <div class="span2 pull-left">
                    <div class="logo"><h3><a href="${createLink(uri: '/')}">Sof<span class="bold">Track</span></a></h3></div>
                </div>
                <!-- Links -->
                <div class="span8 pull-right">
                    <div class="span3">
                        <form class="form-search">
                            <input type="text" class="input-medium search-query" placeholder="Search">
                        </form>
                    </div>

                    <div class="span3">
                        <g:form class="form-search" method="get" name="changeProjectForm" controller="project" action="changeProject" >
                            <st:chooseProject/>
                        </g:form>
                    </div>

                    <div class="span2 pull-right">
                        <ul class="nav pull-right">
                            <li class="dropdown pull-right">
                                <a data-toggle="dropdown" class="dropdown-toggle" href="#">

                                    <sec:ifLoggedIn>
                                        <i class="icon-user"></i> <sec:username/>
                                    </sec:ifLoggedIn> <b class="caret"></b>
                                </a>

                                <!-- Dropdown menu -->
                                <ul class="dropdown-menu">

                                    <g:set var="loggedUserId"><sec:loggedInUserInfo field="id"/></g:set>
                                    <sec:ifAnyGranted roles="ROLE_ADMINISTRATOR">
                                        <li><g:link controller="user" action="show" id="${loggedUserId}"><i
                                                class="icon-user"></i> Profile</g:link></li>
                                    </sec:ifAnyGranted>
                                    <li></li>
                                    <li><g:link controller="user" action="changePassword"><i
                                            class="icon-cog"></i> Change Password</g:link></li>
                                    <li><g:link controller="logout" action="index"><i class="icon-off"></i> Logout</g:link></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- Header starts -->
<header>
    <div class="container-fluid">
        <div class="row-fluid">

            <!-- Logo section -->
            <div class="span12">



                <ul class="nav nav-pills">
                    %{--<li class="active"><a href="#">Regular link</a></li>--}%
                    <g:if test="${session.project}">
                    <li class=""><g:link controller="project" action="overview">Overview</g:link></li>
                    <li class=""><g:link controller="task" action="index">Task</g:link></li>
                    <li class=""><g:link controller="task" action="newTask">New Task</g:link></li>
                    </g:if>
                    <li class="dropdown active">
                        <a href="#" data-toggle="dropdown" role="button" id="drop4" class="dropdown-toggle">User <b class="caret"></b></a>
                        <ul aria-labelledby="drop4" role="menu" class="dropdown-menu" id="menu1">
                            <li role="presentation"><g:link controller="user" action="index">List Users</g:link></li>
                            <li role="presentation"><g:link controller="user" action="roles">Roles</g:link></li>
                            <li role="presentation"><g:link controller="user" action="requestMap">RequestMap</g:link></li>
                            %{--<li class="divider" role="presentation"></li>--}%
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" data-toggle="dropdown" role="button" id="drop5" class="dropdown-toggle">Project<b class="caret"></b></a>
                        <ul aria-labelledby="drop5" role="menu" class="dropdown-menu" id="menu2">
                            <li role="presentation"><g:link controller="project" action="index">List Project</g:link></li>
                            <li role="presentation"><g:link controller="project" action="priority">Project Priority</g:link></li>
                            <li role="presentation"><g:link controller="project" action="status">Project Status</g:link></li>
                            <li role="presentation"><g:link controller="project" action="taskType">Task Type</g:link></li>
                            <li role="presentation"><g:link controller="project" action="ver">Versions</g:link></li>
                        </ul>
                    </li>


                    <li class="dropdown">
                        <a href="#" data-toggle="dropdown" role="button" id="drop5" class="dropdown-toggle">Dropdown 3 <b class="caret"></b></a>
                        <ul aria-labelledby="drop5" role="menu" class="dropdown-menu" id="menu3">
                            <li role="presentation"><a href="#" tabindex="-1" role="menuitem">Action</a></li>
                            <li role="presentation"><a href="#" tabindex="-1" role="menuitem">Another action</a></li>
                            <li role="presentation"><a href="#" tabindex="-1" role="menuitem">Something else here</a></li>
                            <li class="divider" role="presentation"></li>
                            <li role="presentation"><a href="#" tabindex="-1" role="menuitem">Separated link</a></li>
                        </ul>
                    </li>
                </ul>
            </div>

            <div class="span4"></div>
        </div>
    </div>
</header>

<!-- Header ends -->

<!-- Main content starts -->

<div class="content1">



    <g:layoutBody/>
    <r:layoutResources/>
    <div class="clearfix"></div>

</div>
<!-- Content ends -->
<div class="clear"></div>
<!-- Footer starts -->
<footer>
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span12">
                <!-- Copyright info -->
                <p class="copy">Copyright © 2013 | <a href="#">copyright</a></p>
            </div>
        </div>
    </div>
</footer>

<!-- Footer ends -->
<!-- JS -->

</body>



