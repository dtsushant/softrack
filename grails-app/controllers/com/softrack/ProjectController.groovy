package com.softrack

import softrack.Project
import softrack.Priority
import softrack.Status
import softrack.TaskType
import softrack.Ver

class ProjectController {

    static String WILDCARD = "*"
    def searchableService


    def index(Integer max) {
        def projectInstanceList
        def projectInstanceTotal
        def isSearch = false;

        params.max = Math.min(max ?: 10, 100)
        if (params.q?.trim()) {
            String searchTerm = WILDCARD+params.q+WILDCARD
            def searchResult = Project.search(searchTerm, params)
            isSearch = true;
            projectInstanceList = searchResult?.results
            projectInstanceTotal=searchResult?.total
        }else{
            projectInstanceList =  Project.list(params)
            projectInstanceTotal= Project.count();
        }
        [projectInstanceList: projectInstanceList, projectInstanceTotal: projectInstanceTotal, isSearch:isSearch]
    }

    def add(){
        if(request.method=="POST"){
            Project project;
            project = Project.findById(params.id);
            try {
                if(!project){
                    println("The params===>>> $params")
                    project = new Project();
                    project.name = params.name;
                    project.owner = params.owner;
                    println("the project ===>>> "+project.name)
                    project.save(failOnError: true,flush: true);
                    println("the project ===>>> "+project)
                    Ver ver = new Ver(versionID:"0.1",project:project).save(failOnError: true);
                    println("the project ===>>> $ver")
                    project.currentVersion = ver;
                    flash.message = "New Project Created!!!"
                }
                else{
                    project.name=params.name
                    project.owner=params.owner
                    project.currentVersion = Ver.findById(params.projectVersion)
                    flash.message = "Project Edited Successfully!!!"
                }
                project.save(flush: true);

            }
            catch (Exception e) {
                flash.message = "Something went wrong!!!"+e.toString();
            }
            redirect(action: index())
            return ;
        }
    }

    def projectVersion(){
        def attrs = [:]
        attrs.name="projectVersion"
        attrs.from = Ver.findAllByProject(Project.get(params.projectId))
        attrs.optionKey = "id"
        attrs.optionValue=   "versionID"
        attrs.value = params.projectVersion
        render g.select(attrs)
    }

    def priority(Integer max){

        def priorityInstanceList
        def priorityInstanceTotal

        params.max = Math.min(max ?: 3, 100)
        if (params.q?.trim()) {
            String searchTerm = WILDCARD+params.q+WILDCARD
            def searchResult = Priority.search(searchTerm, params)
            priorityInstanceList = searchResult?.results
            priorityInstanceTotal=searchResult?.total
        }else{


            priorityInstanceList =  Priority.list(params)
            priorityInstanceTotal= Priority.count();
        }
        [priorityInstanceList: priorityInstanceList, priorityInstanceTotal: priorityInstanceTotal]
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
        def statusInstanceList
        def statusInstanceTotal

        params.max = Math.min(max ?: 3, 100)
        if (params.q?.trim()) {
            String searchTerm = WILDCARD+params.q+WILDCARD
            def searchResult = Status.search(searchTerm, params)
            statusInstanceList = searchResult?.results
            statusInstanceTotal=searchResult?.total
        }else{


            statusInstanceList =  Status.list(params)
            statusInstanceTotal= Status.count();
        }

        [statusInstanceList: statusInstanceList, statusInstanceTotal: statusInstanceTotal]
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
        def taskTypeInstanceList
        def taskTypeInstanceTotal

        params.max = Math.min(max ?: 3, 100)
        if (params.q?.trim()) {
            String searchTerm = WILDCARD+params.q+WILDCARD
            def searchResult = TaskType.search(searchTerm, params)
            taskTypeInstanceList = searchResult?.results
            taskTypeInstanceTotal=searchResult?.total
        }else{


            taskTypeInstanceList =  TaskType.list(params)
            taskTypeInstanceTotal= TaskType.count();
        }

        [taskTypeInstanceList: taskTypeInstanceList, taskTypeInstanceTotal: taskTypeInstanceTotal]
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
                taskType1.save(flush: true, failOnError: true);

            }
            catch (Exception e) {
                flash.message = "Something went wrong!!! "+e.toString()
            }
            redirect(action: "taskType")
            return ;
        }
    }

    def ver(Integer max){
        def versionList =  Ver.findAll()
        def versionTotal= Ver.count();
        def projectInstanceList = Project.list();

        [versionList: versionList, versionTotal: versionTotal,projectInstanceList: projectInstanceList]
    }

    def addVersion(){
        Ver ver
        ver = Ver.findById(params.id)
        if (!ver){
            ver = new Ver();
        }
        ver.versionID = params.versionID
        ver.project = Project.findById(params.project)
        ver.tentativeStartDate = DateUtils.parseStringToDate(params.tentativeStartDate)
        ver.tentativeEndDate = DateUtils.parseStringToDate(params.tentativeEndDate)
        ver.save();
        redirect(action: "ver")
    }

    def changeProject(){
        def project = Project.findById(Long.parseLong(params.chooseProject));
        if(project)
        {
            session.project = project.id
            session.projectName = project.name
            redirect(action: "overview")
            return;
        }else{
            session.removeAttribute("project")
            session.removeAttribute("projectName")
            redirect(controller: "dashboard", action: "index")
            return;
        }
    }

    def overview(){
    }
}
