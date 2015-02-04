package com.softrack

import softrack.Project
import softrack.Priority
import softrack.Status
import softrack.TaskType

class ProjectController {

    static String WILDCARD = "*"
    def searchableService


    def index(Integer max) {
        def projectInstanceList
        def projectInstanceTotal

        params.max = Math.min(max ?: 3, 100)
        if (params.q?.trim()) {
            String searchTerm = WILDCARD+params.q+WILDCARD
            def searchResult = Project.search(searchTerm, params)
             projectInstanceList = searchResult?.results
            projectInstanceTotal=searchResult?.total
        }else{
            projectInstanceList =  Project.list(params)
            projectInstanceTotal= Project.count();
        }
        [projectInstanceList: projectInstanceList, projectInstanceTotal: projectInstanceTotal]
    }

    def add(){
        if(request.method=="POST"){
            Project project;
            project = Project.findById(params.id);
            try {
                if(!project){
                    project = new Project(params);
                    flash.message = "New Project Created!!!"
                }
                else{
                    project.name=params.name
                    project.owner=params.owner
                    flash.message = "Project Edited Successfully!!!"
                }
                project.save(flush: true);

            }
            catch (Exception e) {
                flash.message = "Something went wrong!!!"
            }
            redirect(action: index())
            return ;
        }
    }

    def priority(Integer max){
        params.max = Math.min(max ?: 10, 100)
        [priorityInstanceList: Priority.list(params), priorityInstanceTotal: Priority.count()]
    }

    def addEditPriority(){
        if(request.method=="POST"){
            println("the params $params")
            Priority priority1;
            priority1 = Priority.findById(params.id);
            try {
                if(!priority1){
                    priority1 = new Priority(params);
                    flash.message = "New Priority Added!!!"
                }
                else{
                    priority1.priorityName=params.priorityName
                    priority1.description=params.description
                    flash.message = "Priority Edited Successfully!!!"
                }
                priority1.save(flush: true);

            }
            catch (Exception e) {
                flash.message = "Something went wrong!!! "+e.toString()
            }
            redirect(action: "priority")
            return ;
        }
    }


    def status(Integer max){
        params.max = Math.min(max ?: 10, 100)
        [statusInstanceList: Status.list(params), statusInstanceTotal: Status.count()]
    }

    def addEditStatus(){
        if(request.method=="POST"){
            println("the params $params")
            Status status1;
            status1 = Status.findById(params.id);
            try {
                if(!status1){
                    status1 = new Status(params);
                    flash.message = "New status Added!!!"
                }
                else{
                    status1.name=params.name
                    status1.description=params.description
                    flash.message = "Status Edited Successfully!!!"
                }
                status1.save(flush: true);

            }
            catch (Exception e) {
                flash.message = "Something went wrong!!! "+e.toString()
            }
            redirect(action: "status")
            return ;
        }
    }

    def taskType(Integer max){
        params.max = Math.min(max ?: 10, 100)
        [taskTypeInstanceList: TaskType.list(params), taskTypeInstanceTotal: TaskType.count()]
    }

    def addEditTaskType(){
        if(request.method=="POST"){
            println("the params $params")
            TaskType taskType1;
            taskType1 = TaskType.findById(params.id);
            try {
                if(!taskType1){
                    taskType1 = new TaskType(params);
                    flash.message = "New TaskType Added!!!"
                }
                else{
                    taskType1.name=params.name
                    taskType1.description=params.description
                    flash.message = "TaskType Edited Successfully!!!"
                }
                taskType1.save(flush: true);

            }
            catch (Exception e) {
                flash.message = "Something went wrong!!! "+e.toString()
            }
            redirect(action: "taskType")
            return ;
        }
    }
}
