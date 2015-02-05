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
    </div>

    <div class="span5 pull-right">
        <div class="span5 pull-left">
            <div class="control-group fieldcontain required">
                <label for="heading" class="control-label">
                    Task Type
                    <span class="required-indicator">*</span>
                </label>
                <div class="controls">
                    <g:select name="status1" from="${status}" optionKey="id" optionValue="name"  required="" value="" placeholder="" class="input-medium" noSelection="['':'---- Select A task ----']"/>
                </div>
            </div>
        </div>
    </div>
</div>