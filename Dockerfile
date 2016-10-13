FROM trevorsullivan/powershell:jessie

RUN apt-get update && apt-get install -y wget ;\
    wget https://raw.githubusercontent.com/PowerShell/PowerShell/master/src/Modules/Shared/PowerShellGet/PSModule.psm1 -O /opt/microsoft/powershell/6.0.0-alpha.9/Modules/PowerShellGet/PSModule.psm1

RUN powershell Set-PSRepository PSGallery -InstallationPolicy Trusted;\
    powershell Install-Module -Name PSScriptAnalyzer > /dev/null

RUN echo '#!/usr/bin/env sh\n\
powershell "\$results = Invoke-ScriptAnalyzer -Path . -Recurse $@; \$results; Exit \$results.Count" \n\
' >> /usr/local/bin/script-analyzer.sh && chmod +x /usr/local/bin/script-analyzer.sh

WORKDIR /powershell

ENTRYPOINT ["script-analyzer.sh"]
