import com.softrack.RequestMap
import com.softrack.Role
import com.softrack.User
import com.softrack.UserRole

class BootStrap {

    def init = { servletContext ->
        if(1){
            new RequestMap(url: '/js/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true)
            new RequestMap(url: '/css/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true)
            new RequestMap(url: '/images/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true)
            new RequestMap(url: '/', configAttribute: 'ROLE_ADMINISTRATOR,ROLE_PROJECT_MANAGER,ROLE_DEVELOPER,ROLE_QA,ROLE_VIEW').save(flush: true)
            new RequestMap(url: '/login/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true)


            new Role(authority: "ROLE_ADMINISTRATOR").save(flush:true);
            new Role(authority: "ROLE_PROJECT_MANAGER").save(flush:true);
            new Role(authority: "ROLE_DEVELOPER").save(flush:true);
            new Role(authority: "ROLE_QA").save(flush:true);
            new Role(authority: "ROLE_VIEW").save(flush:true);
            new User(username: 'admin', password: 'admin', firstName: 'Sam', lastName: 'Sammy', middleName: 'D',email: "abc@abc.com",enabled: true, accountExpired: false, accountLocked: false, passwordExpired: false).save(flush: true)
            new UserRole(role: Role.findByAuthority('ROLE_ADMINISTRATOR'), user: User.findByUsername('admin')).save(flush: true)
            new UserRole(role: Role.findByAuthority('ROLE_PROJECT_MANAGER'), user: User.findByUsername('admin')).save(flush: true)
        }
    }
    def destroy = {
    }
}
