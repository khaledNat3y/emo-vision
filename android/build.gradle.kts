allprojects {
    repositories {
        google()
        mavenCentral()
        // Fix for ffmpeg_kit_flutter Maven not found error
        maven { url = uri("https://jitpack.io") }
        maven { url = uri("https://packagecloud.io/arthenica/maven/maven2") }
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}