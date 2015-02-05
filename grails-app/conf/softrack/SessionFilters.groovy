package softrack

import com.softrack.User

class SessionFilters {


    def springSecurityService
    def grailsApplication

    def filters = {
        all(controller:'*', action:'*') {
            before = {

                if (controllerName == 'logout') return true
                if (controllerName == 'error') return true
                if (controllerName == 'login') return true
                if(!session.userId){
                    println "----------PRINCIPAL-------------------"
                    println springSecurityService?.principal
                    println "Is user logged in ?? " + (springSecurityService.isLoggedIn())

                    def id = springSecurityService?.principal?.id
                    session.userId = springSecurityService?.principal?.id
                    session.user = User.get(session.userId)
                    session.userRoles = springSecurityService.getPrincipal().getAuthorities()

                }


            }
            after = { Map model ->
                println(" after processing controller")
            }
            afterView = { Exception e ->

            }
        }
    }
}
