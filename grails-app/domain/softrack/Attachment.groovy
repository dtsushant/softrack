package softrack

import com.softrack.User

class Attachment {

    String name
    Project project
    User    addedBy
    String  description
    String  location
    String  contentType
    String  type


    static belongsTo = [taskDetails:TaskDetails]


    static constraints = {
        description nullable: true
        taskDetails nullable: true
        contentType nullable: true
    }
}
