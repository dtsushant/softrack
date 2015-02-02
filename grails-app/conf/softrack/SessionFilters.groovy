package softrack

class SessionFilters {

    def filters = {
        all(controller:'*', action:'*') {
            before = {
                println("before enterring a controller");
            }
            after = { Map model ->
                println(" after processing controller")
            }
            afterView = { Exception e ->

            }
        }
    }
}
