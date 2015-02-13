package com.softrack

import grails.converters.JSON
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartRequest
import softrack.Attachment
import softrack.Priority
import softrack.Project
import softrack.Status
import softrack.Task
import softrack.TaskDetails
import softrack.TaskType
import softrack.Ver

import javax.servlet.http.HttpServletRequest

class TaskController {
    /*Project project
    def beforeInterceptor = {
        project = Project.get(session.project);
        if(!project){
            //redirect(controller: "dashboard", action: "index")
            //return false;
        }
    }*/

    def index() {
        def task = Task.get(params.id)
        if(!task){
            redirect(controller: "dashboard",action: "index")
            return false;
        }
        if(!session.project){
            session.project = task.project.id
        }

        def taskDetail = TaskDetails.createCriteria().list(){
            eq("task",task)
            order("dateCreated","asc")
        }

        def firstTask = taskDetail.first();


        def firstAttachments = Attachment.createCriteria().list(){
            eq("taskDetails",taskDetail.first())
        }
        [task:task,taskDetail:taskDetail,firstAttachment:firstAttachments,firstTask:firstTask]
        //render "howdy partnern"+task
    }

    def list(Integer max){

        Project project1 = Project.get(session.project);

        if(!project1){
            redirect(controller: "dashboard", action: "index")
            return false;
        }

        /*def task1 = TaskDetails.createCriteria().list {
            *//*eq "dateCreated", new grails.gorm.DetachedCriteria(TaskDetails).build {
                projections {
                    max "dateCreated"

                }
            }*//*

            task{
                eq("project",project1)
            }
            order("dateCreated","desc")
            projections{
                property("id")
                groupProperty("task")
              //  groupProperty("taskDetail.id")
            }
        }*/

        params.max = Math.min(max ?: 10, 100)
        def taskTotal = Task.countByProject(project1)
        def task = Task.createCriteria().list(params){
            eq("project",project1)
        }

        [taskList:task,taskTotal:taskTotal]

    }

    def newTask() {
        Project project1 = Project.get(session.project);

        if(!project1){
            redirect(controller: "dashboard", action: "index")
            return false;
        }

        /*println(session.userId);
        println(session.userRoles)*/
        def user = User.get(session.userId)
        //def project=Project.findAllByUser(user)
        def roles =[]
        session.userRoles.each{
            roles.add(it.toString())
        }

        def tracker=Role.createCriteria().list {
            'in'('authority', roles)
            projections {
                taskType {
                    distinct("id")
                    //property("id")
                }
            }
        }
        def taskType = TaskType.findAllByIdInList(tracker)

        //def taskType = tracker?tracker.get(0):[];


        println taskType
        def status = Status.findAll()
        def priority = Priority.findAll()

        def projectVersion = Ver.findAllByProject(project1)

        def userList = User.createCriteria().list{
            project{
                eq("id",project1.id)
            }
        }

        [taskType:taskType,status:status,priority:priority,project:project1,projectVersion:projectVersion,userList:userList]
    }

    def updateTask(){
        def task = Task.get(params.id)

        if(!task){
            redirect(controller: "dashboard",action: "index")
            return false;
        }

        if(!session.project){
            session.project = task.project.id
        }
        Project project1 = task.project

        def taskDetails = TaskDetails.createCriteria().list(){
            eq("task",task)
            order("dateCreated","desc")
        }

        def latestTaskDetail = taskDetails.first();

        def user = User.get(session.userId)
        //def project=Project.findAllByUser(user)
        def roles =[]
        session.userRoles.each{
            roles.add(it.toString())
        }

        def tracker=Role.createCriteria().list {
            'in'('authority', roles)
            projections {
                taskType {
                    distinct("id")
                    //property("id")
                }
            }
        }
        def taskType = TaskType.findAllByIdInList(tracker)

        //def taskType = tracker?tracker.get(0):[];


        println taskType
        def status = Status.findAll()
        def priority = Priority.findAll()

        def projectVersion = Ver.findAllByProject(project1)


        def userList = User.createCriteria().list{
            project{
                eq("id",project1.id)
            }
        }

        [task:task,taskDetail: latestTaskDetail,taskType:taskType,status:status,priority:priority,project:project1,projectVersion:projectVersion,userList:userList]
    }


    def saveNewTask(){
        Task task
        Task.withTransaction {
            task = new Task()
            task.project = Project.get(params.projectId)
            task.createdBy = User.get(session.userId)
            task.heading = params.heading
            task.taskType = TaskType.get(params.taskType)
            if(params.taskDeadline)
                task.taskDeadline = DateUtils.parseStringToDate(params.taskDeadline, "MM/dd/yyyy")
            if(params.taskStartDate)
                task.taskStartDate = DateUtils.parseStringToDate(params.taskStartDate, "MM/dd/yyyy")
            task.save(failOnError: true)
            TaskDetails taskDetails = new TaskDetails();
            taskDetails.assignedTo = User.get(params.assignedTo)
            taskDetails.description = params.description
            taskDetails.priority = Priority.get(params.priority)
            taskDetails.task = task;
            taskDetails.status = Status.get(params.status)
            taskDetails.ver = Ver.get(params.projectVersion)
            taskDetails.save(failOnError: true);
            if (params.attachedIds) {

                println("the attachment ====>>>> ${params.attachedIds}")
                StringUtils.StringToList(params.attachedIds).each {
                    def attachment = Attachment.get(it)
                    attachment.taskDetails = taskDetails
                    attachment.save(failOnError: true);
                }


            }

        }
        redirect(action: "index",params: [id:task.id])


    }

    def saveUpdatedTask(){
        Task task = Task.get(params.taskId);
        TaskDetails lastTaskDetail = TaskDetails.get(params.lastTaskDetail)
        Task.withTransaction {
            task.heading = params.heading
            task.taskType = TaskType.get(params.taskType)
            if(params.taskDeadline)
                task.taskDeadline = DateUtils.parseStringToDate(params.taskDeadline, "MM/dd/yyyy")
            if(params.taskStartDate)
                task.taskStartDate = DateUtils.parseStringToDate(params.taskStartDate, "MM/dd/yyyy")
            task.save(failOnError: true)

            def user = User.get(params.assignedTo)
            def status = Status.get(params.status)
            def priority =  Priority.get(params.priority)
            def ver =  Ver.get(params.projectVersion)

            println(lastTaskDetail)
            if (user.id == lastTaskDetail.assignedTo.id && status.id == lastTaskDetail.status.id && priority.id == lastTaskDetail.priority.id && ver.id == lastTaskDetail.ver.id && params.description =="" && params.attachedIds=="")
            {
                redirect(action: "index",params: [id:task.id])
                return false;
            }else{
                TaskDetails taskDetails = new TaskDetails();
                taskDetails.updatedBy = User.get(session.userId)
                if (status.id!=lastTaskDetail.status.id)
                    taskDetails.remarks = "Status Updated from ${lastTaskDetail.status.name} to ${status.name} by ${taskDetails.updatedBy.fullName}"
                else if(user.id != lastTaskDetail.assignedTo.id)
                    taskDetails.remarks = "Assignee changed from ${lastTaskDetail.assignedTo.fullName} to ${user.fullName}  by ${taskDetails.updatedBy.fullName}"
                else if (priority.id != lastTaskDetail.priority.id)
                    taskDetails.remarks = "Priority Updated from ${lastTaskDetail.priority.priorityName} to ${priority.priorityName}  by ${taskDetails.updatedBy.fullName}"
                else if (ver.id!=lastTaskDetail.ver.id)
                    taskDetails.remarks = "Version Updated from ${lastTaskDetail.ver.versionID} to ${ver.versionID}  by ${taskDetails.updatedBy.fullName}"
                else
                    taskDetails.remarks = "Updated By ${taskDetails.updatedBy.fullName}"

                taskDetails.assignedTo = user
                taskDetails.description = params.description
                taskDetails.priority = priority
                taskDetails.task = task;
                taskDetails.status = status
                taskDetails.ver = ver
                taskDetails.save(failOnError: true);
                if (params.attachedIds) {

                    println("the attachment ====>>>> ${params.attachedIds}")
                    StringUtils.StringToList(params.attachedIds).each {
                        def attachment = Attachment.get(it)
                        attachment.taskDetails = taskDetails
                        attachment.save(failOnError: true);
                    }


                }
                redirect(action: "index",params: [id:task.id])
            }

        }
        //


    }

    def uploadFile(){
        Attachment attachment
        def destinationFolder = new File("/data/softrack/")
        boolean checkFolderExist = destinationFolder.exists();
        if (!checkFolderExist) {
            println("hello hello hello")
            destinationFolder.mkdirs();
        }

        def multipartMapArray = []
        MultipartRequest mRequest = (MultipartRequest)request
        mRequest.getFileNames().each{it->
            MultipartFile multipartFile = mRequest.getFile(it)
            String originalFileName = multipartFile.getOriginalFilename();
            def dest = "/data"+System.getProperty("file.separator")+"softrack" + System.getProperty("file.separator") +System.nanoTime().toString()+multipartFile.getOriginalFilename()
            /*File destination = new File("/data/softrack/" + System.getProperty("file.separator") +
                    System.nanoTime().toString()+multipartFile.getOriginalFilename());*/
            File destination = new File(dest);
            def fileSize = multipartFile.size
            multipartFile.transferTo(destination);
            if (multipartFile.size>0)
            {
                attachment = new Attachment(name: originalFileName,project: Project.get(session.project),addedBy: User.get(session.userId),location: dest,"type":params.type?:"task",contentType: multipartFile.contentType).save();
            }
        }

        render JSON.parse("{ 'attachedId' : ${attachment.id},'refreshPage':${params.type=="project"?1:0;} }") as JSON
    }

    def uploadedFile(){
        def attachment = Attachment.get(params.id);
        println(attachment.location)
        File file = new File(attachment.location);
        if(file.exists())
        {
            if(attachment.contentType){
                println(attachment.contentType)
                println(attachment.name)
                response.setContentType(attachment.contentType)
            }
            else{
                response.setContentType("application/octet-stream") // or or image/JPEG or text/xml or whatever type the file is
            }
            response.setHeader("Content-disposition", "attachment;filename=${attachment.name}")
            response.outputStream << file.bytes

        }
    }

    def documents(){
        Project project1 = Project.get(session.project);

        if(!project1){
            redirect(controller: "dashboard", action: "index")
            return false;
        }
        def attachment = Attachment.findAllByProjectAndType(project1,"project")
        [attachments:attachment]
    }

    def search(){
        try {
            def task =  Task.get(params.query);
            def userAccess = User.createCriteria().list{
                eq("id",session.userId)
                project{
                    eq("id",task.project.id)
                }
            }
            println(userAccess)
            if(task  && userAccess) {
                redirect(action: "index", params: [id: task.id])
                return false;
            }
        }catch(e){
            println(e.toString())
        }

        def user = User.get(session.userId)
        def projects = user.project

        def task = Task.createCriteria().list(){
            'in'('project',projects)
            ilike('heading',"%${params.query}%")
        }

       [tasks:task]
    }


}
