FROM microsoft/windowsservercore:1803

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV NGINX_VERSION 1.15.5

RUN $url = ('http://nginx.org/download/nginx-{0}.zip' -f $env:NGINX_VERSION); \
	      Write-Host ('Downloading {0} ...' -f $url); \
	      [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
	      Invoke-WebRequest -Uri $url -OutFile 'nginx.zip'; \
       	\
        Write-Host 'Installing ...'; \
        Expand-Archive -Path nginx.zip -DestinationPath C:/ -Force; \
        Move-Item C:/nginx-${NGINX_VERSION} C:/nginx; \
        \
        Write-Host 'Updating PATH ...'; \
	      $env:PATH = 'C:\nginx' + $env:PATH; \
        [Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine); \
        \
        Write-Host 'Verifying install ...'; \
        Write-Host 'nginx -v'; nginx -v; \
        \
        Write-Host 'Removing ...'; \
        Remove-Item nginx.zip -Force; \
        \
        Write-Host 'Complete.';

WORKDIR C:\\nginx

EXPOSE 80 443

CMD ["nginx"]
