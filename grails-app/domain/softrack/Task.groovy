package softrack

import com.softrack.User

class Task {

    String      heading
    String      description
    User        createdBy
    User        assignedTo
    softrack.TaskType       taskType
    Date        dateCreated
    Date        taskStartDate
    Date        taskDeadline
    Priority    priority
    Date        lastUpdated
    Status      status
    Project     project


    static constraints = {
    }

    static mapping = {
        description sqlType: "text"
    }
}
