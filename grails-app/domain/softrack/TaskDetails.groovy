package softrack

import com.softrack.User

class TaskDetails {

    String Description
    User        assignedTo
    Date        dateCreated
    Priority    priority
    Status      status
    Attachment  attachment

    static belongsTo = [task:Task]

    static constraints = {
        attachment nullable: true
    }


    static mapping = {
        description sqlType: "text"
    }
}
