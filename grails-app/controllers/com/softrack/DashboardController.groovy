package com.softrack

import softrack.Task
import softrack.TaskDetails

class DashboardController {

    def index() {
        session.removeAttribute("project")
        session.removeAttribute("projectName")
        def user = User.get(session.userId)
        def  tdAssignedToMe = TaskDetails.createCriteria().list(){
            eq("assignedTo",user)
            order("dateCreated","desc")
            maxResults(10)
            projections {
                groupProperty("task")
            }
        }

        def tdAssignedByMe= Task.createCriteria().list(){
            eq("createdBy",user)
            order("dateCreated","desc")
            maxResults(10)
        }

        [tdAssignedByMe:tdAssignedByMe,tdAssignedToMe:tdAssignedToMe]
    }
}