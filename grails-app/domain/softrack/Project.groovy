package softrack

import com.softrack.User

class Project {

    static searchable = true
    String      name
    String      owner
    Date        dateCreated
    Ver         currentVersion


    static constraints = {
        currentVersion nullable: true
    }

    /*Set<Ver> getVersions() {
        //UserRole.findAllByUser(this).collect { it.role } as Set
        Ver.findAllByProject(this)
    }*/
}
