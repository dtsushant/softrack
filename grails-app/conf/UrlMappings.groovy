class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		//"/"(view:"/index")
        //"/"(controller:'login', action:"index")
        "/"(controller:'dashboard', action:"index")
		"500"(view:'/error')
	}
}
