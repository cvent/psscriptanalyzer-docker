FROM trevorsullivan/powershell:jessie

RUN apt-get update && apt-get install -y wget ;\
    wget https://raw.githubusercontent.com/PowerShell/PowerShell/master/src/Modules/Shared/PowerShellGet/PSModule.psm1 -O /opt/microsoft/powershell/6.0.0-alpha.9/Modules/PowerShellGet/PSModule.psm1

RUN powershell Set-PSRepository PSGallery -InstallationPolicy Trusted;\
    powershell Install-Module -Name PSScriptAnalyzer > /dev/null

WORKDIR /powershell

ENTRYPOINT ["powershell", "Invoke-ScriptAnalyzer"]
CMD ["-Recurse", "/powershell"]
