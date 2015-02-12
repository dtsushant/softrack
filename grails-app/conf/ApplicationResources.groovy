modules = {
    application {
        resource url:'js/application.js'
    }

    core{
        dependsOn "jquery"
        dependsOn "jquery-ui"
        resource url: "css/bootstrap-responsive.css"
        resource url: "css/bootstrap.css"
        resource url: "css/mobile.css"
        resource url:"css/style.css"

        resource url:"js/bootstrap.js"
        resource url:"js/custom.js"
        //resource url:"js/dss.js"
    }
}