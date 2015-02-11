<div class="control-group fieldcontain required">
    <label for="heading" class="control-label">
        Task Type
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:select name="taskType" from="${taskType}" optionKey="id" optionValue="name"  required="" value="" placeholder="" class="input-medium" noSelection="['':'---- Select A task ----']"/>
    </div>
</div>

<div class="control-group fieldcontain required">
    <label for="heading" class="control-label">
        Title
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textField name="heading" required="" value="" placeholder="" class="input-block-level"/>
    </div>
</div>

<div class="control-group fieldcontain required">
    <label for="heading" class="control-label">
        Description
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textArea name="description" required="" value="" placeholder="" class="input-block-level" rows="8"/>
    </div>
</div>

<div class="container-fluid">
    <div class="span5 pull-left">
        <div class="control-group fieldcontain required">
            <label for="heading" class="control-label">
                Status
                <span class="required-indicator">*</span>
            </label>
            <div class="controls">
                <g:select name="status" from="${status}" optionKey="id" optionValue="name"  required="" value="" placeholder="" class="input-medium" noSelection="['':'---- Select A Status ----']"/>
            </div>
        </div>

        <div class="control-group fieldcontain required">
            <label for="heading" class="control-label">
                Priority
                <span class="required-indicator">*</span>
            </label>
            <div class="controls">
                <g:select name="priority" from="${priority}" optionKey="id" optionValue="priorityName"  required="" value="" placeholder="" class="input-medium" noSelection="['':'---- Select A Priority ----']"/>
            </div>
        </div>

        <div class="control-group fieldcontain required">
            <label for="heading" class="control-label">
                Assigned To
                <span class="required-indicator">*</span>
            </label>
            <div class="controls">
                <g:select name="assignedTo" from="${userList}" optionKey="id" optionValue="fullName"  required="" value="" placeholder="" class="input-medium" noSelection="['':'---- Select Assignee ----']"/>
            </div>
        </div>

        <div class="control-group fieldcontain required">
            <label for="projectVersion" class="control-label">
                Target Version
                <span class="required-indicator">*</span>
            </label>
            <div class="controls">
                <g:select name="projectVersion" from="${projectVersion}" optionKey="id" optionValue="versionID"  required="" value="" placeholder="" class="input-medium" noSelection="['':'---- Select A Version ----']"/>
            </div>
        </div>
    </div>

    <div class="span5 pull-right">
        <div class="span5 pull-left">

            <div class="control-group fieldcontain required">
                <label for="taskStartDate" class="control-label">
                    Start Date
                    <span class="required-indicator">*</span>
                </label>
                <div class="controls">
                    <g:textField name="taskStartDate" placeholder="" value="" class="input-medium futureDate"/>
                </div>
            </div>

            <div class="control-group fieldcontain required">
                <label for="taskDeadline" class="control-label">
                    End Date
                    <span class="required-indicator">*</span>
                </label>
                <div class="controls">
                    <g:textField name="taskDeadline" placeholder="" value="" class="input-medium futureDate"/>
                </div>
            </div>


        </div>
    </div>
</div>

<div class="control-group fieldcontain required">
    <label for="taskDeadline" class="control-label">
        File Attachment
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        %{--<input id="fileupload" type="file" multiple>--}%
        %{--<g:textField name="attachment" placeholder="" value="" class="input-medium futureDate"/>--}%
    </div>

    <g:render template="fileAttachmentForm" />


</div>

<div class="control-group fieldcontain required">
    <div class="controls">
        <g:hiddenField name="projectId" value="${session.project}" />
        <g:submitButton name="submit" />
    </div>
</div>