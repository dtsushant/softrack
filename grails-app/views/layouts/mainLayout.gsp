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
            <div class="nav-collapse collapse">

                <div class="span4">
                    <div class="logo"><h3><a href="${createLink(uri: '/')}">Sof<span class="bold">Track</span></a></h3></div>
                </div>
                <!-- Links -->
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

<!-- Header starts -->
<header>
    <div class="container-fluid">
        <div class="row-fluid">

            <!-- Logo section -->
            <div class="span4">
                 menu Item goes here
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



