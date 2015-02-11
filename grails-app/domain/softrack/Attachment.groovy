package softrack

import com.softrack.User

class Attachment {

    String name
    Project project
    User    addedBy
    String  description
    String  location
    String  type


    static constraints = {
        description nullable: true
    }
}
