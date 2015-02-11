package softrack

import com.softrack.User

class TaskDetails {

    String description
    User        assignedTo
    Date        dateCreated
    Priority    priority
    Status      status
    Ver         ver


    static hasMany = [attachment:Attachment]

    static belongsTo = [task:Task]

    static constraints = {
        attachment nullable: true
    }


    static mapping = {
        description sqlType: "text"
    }
}
