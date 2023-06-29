import jenkins.model.*
import hudson.model.*

Jenkins.instance.getAllItems(AbstractItem.class).each {
    println(it.fullName)
};