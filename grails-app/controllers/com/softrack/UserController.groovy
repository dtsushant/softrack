package com.softrack

import org.springframework.dao.DataIntegrityViolationException
import org.springframework.security.core.Authentication
import org.springframework.security.core.context.SecurityContextHolder

class UserController {

    transient springSecurityService
    //MailService mailService
    def userService


    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [userInstanceList: User.list(params), userInstanceTotal: User.count()]
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
        def userInstance = new User(params)

        if (userInstance.id == User.findByUsername(getCurrentLoggedInUser()).id) {
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
        }
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
