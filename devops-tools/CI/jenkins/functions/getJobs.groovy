import com.cloudbees.hudson.plugins.folder.*

// USE jenkins_url/script to execute the groovy function directly

void processFolder(Item folder) {
    folder.getItems().each {
        if (it instanceof Folder) {
            processFolder(it)
}else {
            processJob(it)
        }
    }
}
void processJob(Item job) {
    println job.name
}

Jenkins.instance.getItems().each {
    if (it instanceof Folder) {
        processFolder(it)
}else {
        processJob(it)
    }
}
