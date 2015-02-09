package softrack

class Ver {

    String versionID
    Project project
    Date dateCreated
    Date tentativeStartDate
    Date tentativeEndDate



    static constraints = {
        versionID blank: false
        tentativeStartDate nullable: true
        tentativeEndDate nullable: true
        composite: ['versionId', 'project']
    }
}
