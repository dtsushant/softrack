package com.softrack

import org.springframework.dao.DataIntegrityViolationException
import org.springframework.security.core.Authentication
import org.springframework.security.core.context.SecurityContextHolder
import softrack.Project
import softrack.TaskType

class UserController {

    static String WILDCARD = "*"
    def searchableService
    transient springSecurityService
    def mailService
    def userService


    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        def userInstanceList
        def userInstanceTotal
        def isSearch
        params.max = Math.min(max ?: 10, 100)
        if (params.q?.trim()) {
            String searchTerm = WILDCARD+params.q+WILDCARD
            def searchResult = User.search(searchTerm, params)
            userInstanceList = searchResult?.results
            userInstanceTotal=searchResult?.total
            isSearch = true;
        }else{

            isSearch = false;
            userInstanceList =  User.list(params)
            userInstanceTotal= User.count();
        }

        [userInstanceList: userInstanceList, userInstanceTotal: userInstanceTotal,isSearch:isSearch]
    }

    def roles(Integer max) {
        def roleInstanceList
        def roleInstanceTotal
        def isSearch

        params.max = Math.min(max ?: 3, 100)
        if (params.q?.trim()) {
            String searchTerm = WILDCARD+params.q+WILDCARD
            def searchResult = Role.search(searchTerm, params)
            roleInstanceList = searchResult?.results
            roleInstanceTotal=searchResult?.total
            isSearch = true;
        }else{

            isSearch = false;
            roleInstanceList =  Role.list(params)
            roleInstanceTotal= Role.count();
        }

        [roleInstanceList: roleInstanceList, roleInstanceTotal: roleInstanceTotal, taskTypeInstanceList:TaskType.findAll(),isSearch: isSearch]
    }

    def addEditRole(){
        if(request.method=="POST"){
            Role role;
            role = Role.findByAuthority(params.prevAuthority);
            println("the params ===>> $params")
            println("the role ===>>>> $role")
            try {
                if(!role){
                    role = new Role(params)
                    /*role.save(flush: true);
                    role.taskType.clear();*/
                    if (params.taskType instanceof String){
                        role.addToTaskType(TaskType.get(params.taskType));

                    }else{
                        params.taskType.each{
                            role.addToTaskType(TaskType.get(it))
                        }
                    }
                    //role.saveAll();
                    flash.message = "New Role Created!!!"
                }
                else{
                    role.authority=params.authority
                    role.taskType.clear();
                    if (params.taskType instanceof String){
                        role.addToTaskType(TaskType.get(params.taskType));

                    }else{
                        params.taskType.each{
                            role.addToTaskType(TaskType.get(it))
                        }
                    }
                    flash.message = "Role Edited Successfully!!!"
                }

                role.save(flush: true);
            }
            catch (Exception e) {
                flash.message = "Something went wrong!!! " + e.toString();
            }
            redirect(action: "roles")
            return ;
        }
    }


    def requestMap(Integer max){
        def requestMapInstanceList
        def requestMapInstanceTotal

        params.max = Math.min(max ?: 10, 100)
        if (params.q?.trim()) {
            String searchTerm = WILDCARD+params.q+WILDCARD
            def searchResult = RequestMap.search(searchTerm, params)
            requestMapInstanceList = searchResult?.results
            requestMapInstanceTotal=searchResult?.total
        }else{


            requestMapInstanceList =  RequestMap.list(params)
            requestMapInstanceTotal= RequestMap.count();
        }

        [requestMapInstanceList: requestMapInstanceList, requestMapInstanceTotal: requestMapInstanceTotal,roleInstanceList:Role.findAll()]
    }

    def addEditRequestMap(){
        if(request.method=="POST"){
            RequestMap requestMap;
            requestMap = RequestMap.findByUrl(params.prevUrl);
            println("the params ===>> $params")
            println("the role ===>>>> $requestMap")
            try {
                if(!requestMap){
                    requestMap = new RequestMap(params);
                    flash.message = "New Role Created!!!"
                }
                else{
                    requestMap.url=params.url
                    if (params.configAttribute instanceof String)
                        requestMap.configAttribute = params.configAttribute
                    else{
                        requestMap.configAttribute = StringUtils.ListToString(params.configAttribute)
                    }
                    flash.message = "Role Edited Successfully!!!"
                }
                requestMap.save(flush: true);

            }
            catch (Exception e) {
                flash.message = "Something went wrong!!! " + e.toString();
            }
            redirect(action: "requestMap")
            return ;
        }
    }


    def loadForm(){
        def userInstance = User.get(params?.id);
        def selectedRoles = UserRole.findAllByUser(userInstance);
        render(template: "form",model: [userInstance: userInstance, roleInstance: Role.findAll(), projectInstance: Project.findAll(),selectedRoles:selectedRoles]);
    }

    def create() {
        try {
            [userInstance: new User(params), roleInstance: new Role(params)]
        }
        catch (Exception e) {
            flash.message = message(message: "Unexpected error occurred. Please try again later!!!")
        }

    }

    def save() {
        println("the params ====>>>> $params")
        try{
            def userInstance = User.get(params.id);
            if(!userInstance){
                userInstance = new User(params)
                userInstance.save(flush:true);

                if(params.authorities instanceof String){
                    new UserRole(role: Role.findByAuthority(params.authorities), user: userInstance).save(flush: true)
                }
                else{
                    params.authorities.each{
                        new UserRole(role: Role.findByAuthority(it), user: userInstance).save(flush: true)
                        //new UserRole(role: it, user: userInstance).save(flush: true)
                    }
                }
                flash.message = "Successfully Added A User!!!"

                //mailTo(params)
            }else{
                userInstance.properties = params
                userInstance.save(flush:true);
                UserRole.removeAll(userInstance);
                if(params.authorities instanceof String){
                    new UserRole(role: Role.findByAuthority(params.authorities), user: userInstance).save(flush: true)
                }
                else{
                    params.authorities.each{
                        new UserRole(role: Role.findByAuthority(it), user: userInstance).save(flush: true)
                        //new UserRole(role: it, user: userInstance).save(flush: true)
                    }
                }

                flash.message = "Successfully Edited the User!!!"

            }
        }catch(e){
            println(e.toString());
            flash.message = "Something went wrong !!!<br/> ${e.toString()}"
        }


        /*if (userInstance.id == User.findByUsername(getCurrentLoggedInUser()).id) {
            flash.message = "User not found"
            redirect(action: "list")
            return
        }

        if (params.firstName == '' || params.lastName == '' || params.username == '' || params.password == '') {
            flash.message = "User could not be saved. One or more required fields are missing."
            redirect(action: "create")
        } else if (User.findByUsername(params.username)) {
            flash.message = "Username already exist!!! Please try with different name."
            redirect(action: "create")
        } else {
            try {
                userInstance.save(flush: true)
                new UserRole(role: Role.findByDisplayName(params.role), user: User.findByUsername(params.username)).save(flush: true)
                try {
                    sendMail
                            {
                                to params.username
                                subject "User Created"
                                multipart false
                                body(view: "/email/newUser",
                                        model: [username: params.username, password: params.password]
                                )

                            }
                    flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.username])
                }
                catch (Exception e) {
                    flash.message = 'Problem Sending email. User has been created, however'
                }

                redirect(action: "show", id: userInstance.id)
            }
            catch (Exception e) {
                flash.message = 'Unexpected error occurred. Please try again later!!!'
            }
        }*/
        redirect(action: "list")
    }


    def mailTo(params){

        try {
            sendMail
                    {
                        to params.email
                        subject "User Created"
                        multipart false
                        body(view: "/email/newUser",
                                model: [username: params.username, password: params.password]
                        )

                    }
            flash.message = flash.message + " Mail Sent successfully";
        }
        catch (Exception e) {
            flash.message = flash.message + ' Problem Sending email. User has been created, however' + e.toString()
        }
        render flash.message

    }

    def show(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        [userInstance: userInstance]
    }

    def edit(Long id) {
        def userInstance = User.get(id)

        if (userInstance.id == User.findByUsername(getCurrentLoggedInUser()).id) {
            flash.message = "User not found"
            redirect(action: "list")
            return
        }

        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        [userInstance: userInstance]
    }

    def update(Long id, Long version) {
        def userInstance = User.get(id)
        def roleInstance = Role.findByDisplayName(params.role)
        def userRoleInstance = UserRole.findAllByUser(userInstance)

        if (userInstance.id == User.findByUsername(getCurrentLoggedInUser()).id) {
            flash.message = "User not found"
            redirect(action: "list")
            return
        }

        if (params.firstName == '' || params.lastName == '' || params.username == '') {
            flash.message = "User could not be saved. One or more required fields are missing."
            redirect(action: "create")
        }

        if (!userInstance || !roleInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (userInstance.version > version) {
                userInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'user.label', default: 'User')] as Object[],
                        "Another user has updated this User while you were editing")
                render(view: "edit", model: [userInstance: userInstance])
                return
            }
        }
        if (params.password == ''){
            userInstance?.firstName = params.firstName
            userInstance?.lastName = params.lastName
            userInstance?.middleName = params.middleName ?: ''
            userInstance?.username = params.username
            userInstance?.dateCreated = params.dateCreated
            userInstance?.enabled = params.enabled ?: false
            userInstance?.passwordExpired = params.passwordExpired ?: false
        } else {
            userInstance.properties = params
        }

        println userInstance.properties
        try {
            userRoleInstance?.each { it?.delete(flush: true) }
            userInstance.save(flush: true)
            new UserRole(role: Role.findByDisplayName(params.role), user: User.findByUsername(params.username)).save(flush: true)
            flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.username])
            redirect(action: "show", id: userInstance.id)
        }
        catch (Exception e) {
            render(view: "edit", model: [userInstance: userInstance])
            flash.message = "Unexpected error occured!!! Please try again later."
        }
    }

    def delete(Long id) {
        def userInstance = User.get(id)
        def userRoleInstance = UserRole.findAllByUser(userInstance)

        if (userInstance.id == User.findByUsername(getCurrentLoggedInUser()).id) {
            flash.message = "You can not delete yourself"
            redirect(action: "list")
            return
        }

        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), userInstance.username])
            redirect(action: "list")
            return
        }

        try {
            userRoleInstance?.each { it?.delete(flush: true) }
            userInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), userInstance.username])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), userInstance.username])
            redirect(action: "list")
        }
    }

    def enableUser() {
        def userInstance = User.findById(params?.id)
        //3 lines below are actually irrelevant but kept for safety purpose

        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }
        if (userInstance.id == User.findByUsername(getCurrentLoggedInUser()).id) {
            flash.message = "You can not enable yourself"
            redirect(action: "list")
            return
        }
        try {
            userInstance.enabled = true
            userInstance.save(flush: true)
            flash.message = message(code: 'user.enabled.message', args: [message(code: 'user.label', default: 'User'), userInstance.username])
        }
        catch (Exception e) {
            flash.message = message(message: "Unexpected error occurred. Please try again later!!!")
        }
        redirect(action: "list")
    }

    def disableUser() {
        def userInstance = User.findById(params?.id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }
        if (userInstance.id == User.findByUsername(getCurrentLoggedInUser()).id) {
            flash.message = "You can not disable yourself"
            redirect(action: "list")
            return
        }
        try {
            userInstance.enabled = false
            userInstance.save(flush: true)
            flash.message = message(code: 'user.disabled.message', args: [message(code: 'user.label', default: 'User'), userInstance.username])
        }
        catch (Exception e) {
            flash.message = message(message: "Unexpected error occurred. Please try again later!!!")
        }
        redirect(action: "list")
    }

    def passwordExpired() {
        //[username: session['SPRING_SECURITY_LAST_USERNAME']]
        String username = session['SPRING_SECURITY_LAST_USERNAME'].toString()
        if (!username) {
            redirect controller: 'login', action: 'auth'
        }
        render view: '/user/changePassword', model: [username: username]
    }
    def changePassword() {
        String username = getCurrentLoggedInUser()

        if (!username) {
            redirect controller: 'login', action: 'auth'
            flash.message = "Session expired. Please login again."
            return
        }
        render view: '/user/updatePassword', model: [username: username]
    }

    def getCurrentLoggedInUser() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication()
        String name = auth.getName()
        return name
    }

    def updateExpiredPassword = {
        String username = session['SPRING_SECURITY_LAST_USERNAME']
        if (!username) {
            flash.message = 'Sorry, an error has occurred'
            redirect controller: 'login', action: 'auth'
            return
        }

        String current_password = params.password
        String newPassword = params.password_new
        String newPassword2 = params.password_new_2

        if (!current_password || !newPassword || !newPassword2) {
            flash.message = 'Please enter your current password and a valid new password'
            render view: '/user/changePassword', model: [username: session['SPRING_SECURITY_LAST_USERNAME']]
            return
        }

        if (newPassword != newPassword2) {
            flash.message = 'New passwords do not match'
            render view: '/user/changePassword', model: [username: session['SPRING_SECURITY_LAST_USERNAME']]
            return
        }

        User user = User.findByUsername(username)

        if (!springSecurityService.passwordEncoder.isPasswordValid(user.password, current_password, user.salt)) {
            flash.message = 'Please enter correct current password'
            render view: '/user/changePassword', model: [username: session['SPRING_SECURITY_LAST_USERNAME']]
            return
        }

        if (springSecurityService.passwordEncoder.isPasswordValid(user.password, newPassword, user.salt)) {
            flash.message = 'Please choose a different password from your current one'
            render view: '/user/changePassword', model: [username: session['SPRING_SECURITY_LAST_USERNAME']]
            return
        }


        if (!userService.validatePassword(newPassword)) {
            flash.message = 'Please choose a strong password (8 chars at least with at least one Capital letter, one numeric and one special character)'
            render view: '/user/changePassword', model: [username: session['SPRING_SECURITY_LAST_USERNAME']]
            return
        }
        try {
            userService.changePassword(user, newPassword)
        } catch (Exception e) {
            redirect controller: 'login', action: 'auth'
            flash.message = "Unexpected error occurred. Please try again later."
            return
        }
        redirect controller: 'login', action: 'auth'
        flash.message = "Password Changed Successfully!!!"
    }

    def updatePassword = {
        String username = getCurrentLoggedInUser()

        if (!username) {
            flash.message = 'Sorry, an error has occurred'
            redirect controller: 'login', action: 'auth'
            return
        }

        String current_password = params.password
        String newPassword = params.password_new
        String newPassword2 = params.password_new_2

        if (!current_password || !newPassword || !newPassword2) {
            flash.message = 'Please enter your current password and a valid new password'
            render view: '/user/updatePassword', model: [username: session['SPRING_SECURITY_LAST_USERNAME']]
            return
        }

        if (newPassword != newPassword2) {
            flash.message = 'New passwords do not match'
            render view: '/user/updatePassword', model: [username: session['SPRING_SECURITY_LAST_USERNAME']]
            return
        }

        User user = User.findByUsername(username)

        if (!springSecurityService.passwordEncoder.isPasswordValid(user.password, current_password, user.salt)) {
            flash.message = 'Please enter correct current password'
            render view: '/user/updatePassword', model: [username: session['SPRING_SECURITY_LAST_USERNAME']]
            return
        }

        if (springSecurityService.passwordEncoder.isPasswordValid(user.password, newPassword, user.salt)) {
            flash.message = 'Please choose a different password from your current one'
            render view: '/user/updatePassword', model: [username: session['SPRING_SECURITY_LAST_USERNAME']]
            return
        }


        if (!userService.validatePassword(newPassword)) {
            flash.message = 'Please choose a strong password (8 chars at least with at least one Capital letter, one numeric and one special character)'
            render view: '/user/updatePassword', model: [username: session['SPRING_SECURITY_LAST_USERNAME']]
            return
        }
        try {
            userService.changePassword(user, newPassword)
        } catch (Exception e) {
            flash.message = "Unexpected error occurred. Please try again later."
            render view: '/user/updatePassword', model: [username: session['SPRING_SECURITY_LAST_USERNAME']]
            return
        }
        render view: '/user/updatePassword', model: [username: session['SPRING_SECURITY_LAST_USERNAME']]
        flash.message = "Password Changed Successfully!!!"
    }
}
