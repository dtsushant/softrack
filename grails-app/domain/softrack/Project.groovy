package softrack

import com.softrack.User

class Project {

    static searchable = true
    String      name
    String      owner
    Date        dateCreated

    static belongsTo = [user:User]


    static constraints = {
    }

    Set<Versions> getVersions() {
        //UserRole.findAllByUser(this).collect { it.role } as Set
        Versions.findAllByProject(this)
    }
}
