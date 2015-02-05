package com.softrack

class TaskController {

    def index() {

        render "howdy partnern"
    }

    def newTask() {

        println(session.userId);
        println()

        []
    }

    def saveNewTask(){

    }
}
