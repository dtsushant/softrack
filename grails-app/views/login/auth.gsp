<!DOCTYPE html>
<html style="height: 100%"><head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title><g:message code="springSecurity.login.title"/></title>
    <link rel="shortcut icon" href="../images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="../css/login.css">

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

                            <form action='${postUrl}' method='POST' id='loginForm' class='cssform' autocomplete='off'>
                                <ul>
                                    <li><g:message code="springSecurity.login.username.label"/></li>
                                    <li><input autofocus="autofocus" name="j_username" id="username" type="text"></li>
                                    <li><g:message code="springSecurity.login.password.label"/></li>
                                    <li><input type="password" name="j_password" id="password"></li>
                                    %{--<li><label for='remember_me'><g:message--}%
                                    %{--code="springSecurity.login.remember.me.label"/></label>--}%
                                    %{--<input type='checkbox' class='chk' name='${rememberMeParameter}'--}%
                                    %{--id='remember_me' <g:if test='${hasCookie}'>checked='checked'</g:if>/>--}%
                                    %{--</li>--}%

                                    <li><button name="submit">${message(code: "springSecurity.login.button")}</button></li>
                                </ul>
                            </form>
                            <div class="dss_login_footer">
                                <g:link controller="login" action="passwordReset">Forget Password</g:link>
                            </div>
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