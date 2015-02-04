package softrack

class Project {

    static searchable = [except: ['version']]
    String      name
    String      owner
    Date        dateCreated


    static constraints = {
    }
}
