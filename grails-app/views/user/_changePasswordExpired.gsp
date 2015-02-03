<!DOCTYPE html>
<html style="height: 100%"><head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>Password Reset</title>
    <link rel="shortcut icon" href="../images/favicon.ico" type="image/x-icon">
    <link href="${resource(dir: 'css', file: 'login.css')}" rel="stylesheet">

<body>

<div class="dss dss_webclient_container">
    <table class="dss_webclient">
        <tbody>
        <tr>

            <td class="dss_application">
                <div>
                    <div class="dss_login dss_login_invalid">
                        <div class="dss_login_bottom"></div>
                        <g:if test='${flash.message}'>
                            <div class="dss_login_error_message">${flash.message}</div>
                        </g:if>


                        <div style="display: block;" class="dss_login_pane">
                            <div class="dss_login_logo"><img src=""></div>
                            <label class="" for="username">Hello ${username} Please reset your password!!!</label>

                            <g:form action='updatePassword' class='cssform' autocomplete='off'>
                                <ul>
                                    <li></li>
                                    <li></li>
                                    <li>Current Password</li>
                                    <li><g:passwordField name="password" /></li>
                                    <li>New Password</li>
                                    <li><g:passwordField name="password_new" /></li>
                                    <li>Enter New Password</li>
                                    <li><g:passwordField name="password_new_2" /></li>
                                    <li><button type="submit" value="Reset">Reset Password</button></li>
                                </ul>
                            </g:form>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
        </tbody>
    </table>
</div>
</body>
</html>