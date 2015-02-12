package softrack

import com.softrack.User

class TaskDetails {

    String description
    User        assignedTo
    User        updatedBy
    Date        dateCreated
    Priority    priority
    Status      status
    Ver         ver
    String      remarks


    static hasMany = [attachment:Attachment]

    static belongsTo = [task:Task]

    static constraints = {
        attachment nullable: true
        updatedBy nullable: true
        remarks nullable: true

    }


    static mapping = {
        description sqlType: "text"
    }
}
