#!/usr/bin/env nextflow

process highMemoryTask {
    tag "High memory task"
    pod = []
    memory '4 GB'

    output:
    file 'high_mem.txt' into highMemChannel

    script:
    """
    echo 'Hello World from high memory task!' > high_mem.txt
    """
}

process lowMemoryTask {
    tag "Low memory task"
    pod = []
    memory '512 MB'

    output:
    file 'low_mem.txt' into lowMemChannel

    script:
    """
    echo 'Hello World from low memory task!' > low_mem.txt
    """
}


workflow {
    highMemoryTask().subscribe {
        println "High memory task completed: $it"
    }
    lowMemoryTask().subscribe {
        println "Low memory task completed: $it"
    }
} 
