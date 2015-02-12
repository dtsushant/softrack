package softrack

import com.softrack.User

class   Task {
    static searchable = true
    String      heading
    User        createdBy
    softrack.TaskType       taskType
    Date        dateCreated
    Date        taskStartDate
    Date        taskDeadline
    Date        lastUpdated
    Project     project

    static  hasMany = [taskDetail:TaskDetails]


    static constraints = {
        taskStartDate nullable: true
        taskDeadline  nullable: true
    }

}
