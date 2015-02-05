package com.softrack

import softrack.Priority
import softrack.Project
import softrack.Status
import softrack.TaskType

class TaskController {

    def index() {

        render "howdy partnern"
    }

    def newTask() {

        println(session.userId);
        println(session.userRoles)
        def user = User.get(session.userId)
        def project=Project.findAllByUser(user)
        def roles =[]
        session.userRoles.each{
            roles.add(it.toString())
        }

        def taskType=TaskType.findAllByRoleInList(Role.findAllByAuthorityInList(roles))
        def status = Status.findAll()
        def priority = Priority.findAll()

        [project:project,taskType:taskType,status:status,priority:priority]
    }

    def saveNewTask(){

    }
}
