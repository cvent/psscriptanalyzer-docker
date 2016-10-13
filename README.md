# psscriptanalyzer-docker

## Build and Run

    docker build -t script-analyzer .
    docker run -t -v $(pwd):/powershell script-analyzer
