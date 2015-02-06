package com.softrack

class DashboardController {

    def index() {
        session.removeAttribute("project")
        session.removeAttribute("projectName")
    }
}
