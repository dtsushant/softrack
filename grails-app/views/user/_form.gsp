<%@ page import="com.softrack.User" %>

<div class="control-group fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')} required">
    <label for="username" class="control-label">
        <g:message code="user.username.label" default="Username" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textField name="username" required="" value="${userInstance?.username}" placeholder="Username"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required">
    <label class="control-label" for="password">
        <g:message code="user.password.label" default="Password" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:passwordField name="password" "${userInstance?:"required=''"}" value="" placeholder="Password"/>
    </div>
</div>


<div class="control-group fieldcontain ${hasErrors(bean: userInstance, field: 'firstName', 'error')} required">
    <label class="control-label" for="firstName">
        First Name
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textField name="firstName" required="" value="${userInstance?.firstName}" placeholder="FirstName"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: userInstance, field: 'middleName', 'error')} required">
    <label class="control-label" for="middleName">
        Middle Name
    </label>
    <div class="controls">
        <g:textField name="middleName" required="" value="${userInstance?.middleName}" placeholder="MiddleName"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: userInstance, field: 'lastName', 'error')} required">
    <label class="control-label" for="lastName">
        Last Name
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textField name="lastName" required="" value="${userInstance?.lastName}" placeholder="LastName"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: userInstance, field: 'email', 'error')} required">
    <label class="control-label" for="lastName">
        Email
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textField name="email" required="" value="${userInstance?.email}" placeholder="Email(abc@abc.com)"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: userInstance, field: 'contactNo', 'error')} required">
    <label class="control-label" for="lastName">
        Contact No.

    </label>
    <div class="controls">
        <g:textField name="contactNo" value="${userInstance?.contactNo}" placeholder="+xxx-xxxxxxxxxx"/>
    </div>
</div>


<div class="control-group fieldcontain ${hasErrors(bean: userInstance, field: 'accountExpired', 'error')} ">

    <label class="control-label checkbox inline" for="accountExpired" >
        <g:message code="user.accountExpired.label" default="Account Expired" />

    </label>
    <div class="controls">
        <g:checkBox name="accountExpired" value="${userInstance?.accountExpired}" />
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: userInstance, field: 'accountLocked', 'error')} ">
    <label class="control-label checkbox inline" for="accountLocked" >
        <g:message code="user.accountLocked.label" default="Account Locked" />

    </label>
    <div class="controls">
        <g:checkBox name="accountLocked" value="${userInstance?.accountLocked}" />
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: userInstance, field: 'enabled', 'error')} ">
    <label class="control-label checkbox inline" for="enabled" >
        <g:message code="user.enabled.label" default="Enabled" />

    </label>
    <div class="controls">
        <g:checkBox name="enabled" value="${userInstance?.enabled}" />
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: userInstance, field: 'passwordExpired', 'error')} ">
    <label class="control-label checkbox inline" for="passwordExpired" >
        <g:message code="user.passwordExpired.label" default="Password Expired" />

    </label>
    <div class="controls">
        <g:checkBox name="passwordExpired" value="${userInstance?.passwordExpired}" />
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: userInstance, field: 'authorities', 'error')} required">
    <label class="control-label" for="authorities">
        Authorities
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:select name="authorities" from="${roleInstance}" multiple="multiple" optionValue="authority" optionKey="authority" value="${selectedRoles?.role?.authority}" />
    </div>
</div>


<div class="control-group fieldcontain ${hasErrors(bean: userInstance, field: 'project', 'error')} required">
    <label class="control-label" for="project">
        Project Access
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:select name="project" from="${projectInstance}" multiple="multiple" optionValue="name" optionKey="id" value="${userInstance?.project?.id}"/>
    </div>
</div>

<g:hiddenField name="id" value="${userInstance?.id}" />
