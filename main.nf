#!/usr/bin/env nextflow

process highMemoryTask {
    tag "High memory task"
    memory '4 GB'
    container 'ubuntu:20.04'

    output:
    file 'high_mem.txt' 

    script:
    """
    echo 'Hello World from high memory task!' > high_mem.txt
    """
}

process lowMemoryTask {
    tag "Low memory task"
    memory '512 MB'
    container 'ubuntu:20.04'
    
    output:
    file 'low_mem.txt'

    script:
    """
    echo 'Hello World from low memory task!' > low_mem.txt
    """
}


workflow {
    // perform both tasks in parallel and print the results
    highMemChannel = highMemoryTask()
    lowMemChannel = lowMemoryTask()

    highMemChannel.subscribe { println "High memory task result: $it" }
    lowMemChannel.subscribe { println "Low memory task result: $it" }

    // wait for both tasks to complete
    highMemChannel.combine(lowMemChannel).subscribe { println "All tasks completed" }
} 
