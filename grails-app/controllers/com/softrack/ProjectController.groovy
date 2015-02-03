package com.softrack

import softrack.Project

class ProjectController {

    def index(Integer max) {
        params.max = Math.min(max ?: 3, 100)
        [projectInstanceList: Project.list(params), projectInstanceTotal: Project.count()]
    }

    def add(){
        if(request.method=="POST"){
            try {
                Project project = new Project(params);
                project.save(flush: true);
                flash.message = "New Project Created!!!"
            }
            catch (Exception e) {
                flash.message = "Something went wrong!!!"
            }
            redirect(action: index())
            return ;
        }
    }

    def edit(){

    }

    def delete(){

    }
}
