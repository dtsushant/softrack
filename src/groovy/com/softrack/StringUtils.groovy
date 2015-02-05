package com.softrack

/**
 * Created with IntelliJ IDEA.
 * User: spandey
 * Date: 2/4/15
 * Time: 3:08 PM
 * To change this template use File | Settings | File Templates.
 */
class StringUtils {

    static def ListToString(def list,def delimiter=","){
        if(list){
            def str=null
            list.each{
                if(str==null)
                    str=it.toString().trim()
                else
                    str=str+delimiter+it.toString().trim()
            }
            return str
        }
        else
            return null
    }

    static def StringToList(String str,def delimeter=","){
        if(str){
//            str=str.replace("[","").replace("]","")
            def elements=str.split(delimeter)
            def list=[]
            elements.each{
//                list.add(it.trim().replace("'","").replace('"',""))
                list.add(quoteAndSpaceTrimmer(it.trim()))
            }
            return list
        }else
            return null
    }

    static String quoteAndSpaceTrimmer(String str) {
        String ret = str.trim()
        def len = ret.length()

        if (ret.startsWith('[\'') || ret.startsWith("[\"")) {
            ret = ret.substring(2,len)
            len = ret.length()
        }else if (ret.startsWith('\'') || ret.startsWith('\"') || ret.startsWith('[')) {
            ret = ret.substring(1, len)
            len = ret.length()
        }

        if (ret.endsWith("\']")||ret.endsWith("\"]")){
            ret = ret.substring(0,len-2)
            len = ret.length();
        }else if (ret.endsWith('\'') || ret.endsWith('\"') || ret.endsWith(']')) ret = ret.substring(0, len - 1)



        ret = ret.trim()
        return ret
    }
}
