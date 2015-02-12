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
            order("dateCreated","desc")
        }


        def firstAttachments = Attachment.createCriteria().list(){
            eq("taskDetails",taskDetail.last())
        }
        [task:task,taskDetail:taskDetail,firstAttachment:firstAttachments]
        //render "howdy partnern"+task
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

        def latestTaskDetail = taskDetails.last();

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

        def projectVersion = Ver.findAllByProject(project)


        println("the project ======>>>>>>>"+project)
        def userList = User.createCriteria().list{
            project{
                eq("id",project1.id)
            }
        }

        [task:task,taskDetail: latestTaskDetail,taskType:taskType,status:status,priority:priority,project:project,projectVersion:projectVersion,userList:userList]
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
                attachment = new Attachment(name: originalFileName,project: Project.get(session.project),addedBy: User.get(session.userId),location: dest,"type":"task").save();
            }
        }
        render JSON.parse("{ 'attachedId' : ${attachment.id} }") as JSON
    }

    def uploadedFile(){
        def attachment = Attachment.get(params.id);
        println(attachment.location)
        File file = new File(attachment.location);
        if(file.exists())
        {
            //println("hello")

        }

        render "test test";
    }


}
