package softrack

import com.softrack.User
import softrack.Project;

class SoftrackCustomTagLib {

    static namespace = "st"

    def chooseProject={attrs->
        attrs.value = session.project
        attrs.name="chooseProject"
        def user = User.get(session.userId)
        attrs.from = user.project
        attrs.optionKey="id"
        attrs.optionValue="name"
        //noSelection="['':'---Chose a Project---']"
        attrs.noSelection = ['':'---Chose a Project---']

        out << g.select(attrs)

    }


}
