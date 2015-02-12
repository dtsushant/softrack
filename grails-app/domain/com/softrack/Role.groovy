package com.softrack

import softrack.TaskType

class Role {
    static searchable = [only:['authority']]
	String authority

    static hasMany = [taskType:TaskType]

	static mapping = {
		cache true
	}

	static constraints = {
		authority blank: false, unique: true
	}

    def saveTaskType(def taskType) {
        if (taskType instanceof String){
            this.addToTaskType(TaskType.get(taskType));
        }else{
            taskType.each{
                this.addToTaskType(TaskType.get(it));
                //new UserRole(role: it, user: userInstance).save(flush: true)
            }
        }
        this.saveAll();
    }
}
