@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Otimizador Windows 10 e 11 - Manutencao Segura
color 0B

set "LOG=%~dp0Otimizacao_Windows.log"
set "SCRIPT=%~f0"

:: Verifica privilegios administrativos
net session >nul 2>&1
if not "%errorlevel%"=="0" (
    echo.
    echo [AVISO] Este script precisa ser executado como Administrador.
    echo Solicitando elevacao...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%SCRIPT%' -Verb RunAs"
    exit /b
)

call :Log "============================================================"
call :Log "Inicio do Otimizador Windows 10/11"
call :Log "Usuario: %USERNAME% | Computador: %COMPUTERNAME%"
for /f "tokens=4-5 delims=. " %%a in ('ver') do set "WINVER=%%a.%%b"
call :Log "Versao informada pelo comando VER: %WINVER%"

:MENU
cls
echo ============================================================
echo        OTIMIZADOR WINDOWS 10 / WINDOWS 11
echo             Manutencao segura e interativa
echo ============================================================
echo.
echo  [1] Limpar arquivos temporarios do usuario
echo  [2] Limpar arquivos temporarios do Windows
echo  [3] Limpar cache DNS
echo  [4] Executar verificacao SFC
echo  [5] Reparar imagem do Windows com DISM
echo  [6] Abrir Limpeza de Disco do Windows
echo  [7] Abrir configuracoes de aplicativos de inicializacao
echo  [8] Abrir configuracoes de desempenho visual
echo  [9] Desinstalar aplicativos opcionais (selecao individual)
echo [10] Exibir informacoes basicas do sistema
echo [11] Abrir configuracoes de armazenamento
echo [12] Abrir Windows Update
echo.
echo  [L] Abrir arquivo de log
echo  [0] Sair
echo.
set "OP="
set /p "OP=Escolha uma opcao: "

if "%OP%"=="1" goto TEMP_USER
if "%OP%"=="2" goto TEMP_WINDOWS
if "%OP%"=="3" goto DNS
if "%OP%"=="4" goto SFC
if "%OP%"=="5" goto DISM
if "%OP%"=="6" goto CLEANMGR
if "%OP%"=="7" goto STARTUP
if "%OP%"=="8" goto VISUAL
if "%OP%"=="9" goto APPS
if "%OP%"=="10" goto INFO
if "%OP%"=="11" goto STORAGE
if "%OP%"=="12" goto UPDATE
if /i "%OP%"=="L" goto OPENLOG
if "%OP%"=="0" goto END
echo.
echo Opcao invalida.
pause
goto MENU

:TEMP_USER
cls
echo Limpando arquivos temporarios do usuario...
call :Log "Solicitada limpeza dos temporarios do usuario."
call :CleanFolder "%TEMP%"
echo.
echo Concluido. Arquivos em uso podem ser mantidos pelo Windows.
call :Log "Limpeza de temporarios do usuario concluida."
pause
goto MENU

:TEMP_WINDOWS
cls
echo Limpando arquivos temporarios do Windows...
call :Log "Solicitada limpeza dos temporarios do Windows."
call :CleanFolder "%WINDIR%\Temp"
echo.
echo Concluido. Arquivos em uso podem ser mantidos pelo Windows.
call :Log "Limpeza de temporarios do Windows concluida."
pause
goto MENU

:DNS
cls
echo Limpando cache DNS...
ipconfig /flushdns
if errorlevel 1 (
    call :Log "ERRO ao limpar cache DNS."
) else (
    call :Log "Cache DNS limpo."
)
echo.
pause
goto MENU

:SFC
cls
echo A verificacao SFC pode demorar varios minutos.
echo.
set "CONF="
set /p "CONF=Executar sfc /scannow agora? (S/N): "
if /i not "%CONF%"=="S" goto MENU
call :Log "Inicio de sfc /scannow."
sfc /scannow
set "RC=%errorlevel%"
call :Log "sfc /scannow finalizado. Codigo: %RC%"
echo.
echo Verificacao finalizada. Consulte a mensagem acima e o log.
pause
goto MENU

:DISM
cls
echo O DISM verifica e repara componentes do Windows.
echo A operacao pode demorar e pode usar o Windows Update.
echo.
set "CONF="
set /p "CONF=Executar DISM /Online /Cleanup-Image /RestoreHealth? (S/N): "
if /i not "%CONF%"=="S" goto MENU
call :Log "Inicio de DISM RestoreHealth."
DISM /Online /Cleanup-Image /RestoreHealth
set "RC=%errorlevel%"
call :Log "DISM RestoreHealth finalizado. Codigo: %RC%"
echo.
pause
goto MENU

:CLEANMGR
cls
echo Abrindo a ferramenta nativa Limpeza de Disco...
call :Log "Aberta Limpeza de Disco (cleanmgr)."
start "" cleanmgr.exe
echo Selecione a unidade e revise os itens antes de confirmar.
pause
goto MENU

:STARTUP
call :Log "Aberta pagina de aplicativos de inicializacao."
start "" ms-settings:startupapps
goto MENU

:VISUAL
call :Log "Aberta configuracao de desempenho visual."
start "" SystemPropertiesPerformance.exe
goto MENU

:APPS
cls
echo ============================================================
echo      DESINSTALACAO DE APLICATIVOS OPCIONAIS
echo ============================================================
echo.
echo Esta funcao remove o pacote do usuario atual quando encontrado.
echo Leia cada item e confirme individualmente.
echo Aplicativos corporativos, drivers e componentes essenciais
echo nao sao incluidos. A disponibilidade varia por versao do Windows.
echo.
echo  [1] Clipchamp
echo  [2] Teams pessoal
echo  [3] Copilot (aplicativo independente)
echo  [4] Xbox e componentes de jogos selecionados
echo  [5] Microsoft Solitaire Collection
echo  [6] Noticias
echo  [7] Clima
echo  [8] Mapas
echo  [9] Microsoft To Do
echo [10] Outlook novo
echo [11] 3D Viewer
echo [12] Portal de Realidade Mista
echo.
echo  [A] Mostrar pacotes opcionais instalados que correspondem a esta lista
echo  [0] Voltar
echo.
set "APP="
set /p "APP=Escolha um aplicativo: "
if "%APP%"=="0" goto MENU
if "%APP%"=="1" call :RemoveApp "Clipchamp" "Clipchamp.Clipchamp"
if "%APP%"=="2" call :RemoveApp "Teams pessoal" "MSTeams"
if "%APP%"=="3" call :RemoveApp "Copilot" "Microsoft.Copilot"
if "%APP%"=="4" call :RemoveXbox
if "%APP%"=="5" call :RemoveApp "Solitaire" "Microsoft.MicrosoftSolitaireCollection"
if "%APP%"=="6" call :RemoveApp "Noticias" "Microsoft.BingNews"
if "%APP%"=="7" call :RemoveApp "Clima" "Microsoft.BingWeather"
if "%APP%"=="8" call :RemoveApp "Mapas" "Microsoft.WindowsMaps"
if "%APP%"=="9" call :RemoveApp "Microsoft To Do" "Microsoft.Todos"
if "%APP%"=="10" call :RemoveApp "Outlook novo" "Microsoft.OutlookForWindows"
if "%APP%"=="11" call :RemoveApp "3D Viewer" "Microsoft.Microsoft3DViewer"
if "%APP%"=="12" call :RemoveApp "Portal de Realidade Mista" "Microsoft.MixedReality.Portal"
if /i "%APP%"=="A" goto LISTAPPS
if not "%APP%"=="1" if not "%APP%"=="2" if not "%APP%"=="3" if not "%APP%"=="4" if not "%APP%"=="5" if not "%APP%"=="6" if not "%APP%"=="7" if not "%APP%"=="8" if not "%APP%"=="9" if not "%APP%"=="10" if not "%APP%"=="11" if not "%APP%"=="12" if /i not "%APP%"=="A" echo Opcao invalida.
pause
goto APPS

:LISTAPPS
echo.
echo Pacotes encontrados (a lista pode variar conforme a edicao):
powershell -NoProfile -ExecutionPolicy Bypass -Command "$patterns='Clipchamp','MSTeams','Microsoft.Copilot','Xbox','Microsoft.MicrosoftSolitaireCollection','Microsoft.BingNews','Microsoft.BingWeather','Microsoft.WindowsMaps','Microsoft.Todos','Microsoft.OutlookForWindows','Microsoft.Microsoft3DViewer','Microsoft.MixedReality.Portal'; Get-AppxPackage | Where-Object { $n=$_.Name; foreach($p in $patterns){ if($n -like ('*'+$p+'*')){ $_; break } } } | Select-Object Name, Version | Format-Table -AutoSize"
call :Log "Listados pacotes opcionais instalados."
pause
goto APPS

:INFO
cls
echo Informacoes basicas do sistema
echo ------------------------------------------------------------
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"System Type" /C:"Total Physical Memory"
echo.
echo Unidade do sistema:
powershell -NoProfile -Command "Get-Volume -DriveLetter $env:SystemDrive.TrimEnd(':') -ErrorAction SilentlyContinue | Select-Object DriveLetter,FileSystem,HealthStatus,Size,SizeRemaining | Format-Table -AutoSize"
call :Log "Exibidas informacoes basicas do sistema."
pause
goto MENU

:STORAGE
call :Log "Aberta configuracao de armazenamento."
start "" ms-settings:storagesense
goto MENU

:UPDATE
call :Log "Aberto Windows Update."
start "" ms-settings:windowsupdate
goto MENU

:OPENLOG
if exist "%LOG%" start "" notepad.exe "%LOG%"
goto MENU

:RemoveXbox
echo.
echo Este item tenta remover apenas os pacotes Xbox selecionados do usuario atual.
echo Pode afetar o aplicativo Xbox, Game Bar e recursos associados.
set "CONF="
set /p "CONF=Continuar com a remocao dos pacotes Xbox selecionados? (S/N): "
if /i not "%CONF%"=="S" exit /b
powershell -NoProfile -ExecutionPolicy Bypass -Command "$patterns=@('Microsoft.XboxApp','Microsoft.GamingApp','Microsoft.XboxGamingOverlay','Microsoft.XboxIdentityProvider','Microsoft.XboxSpeechToTextOverlay'); foreach($p in $patterns){ Get-AppxPackage -Name $p -ErrorAction SilentlyContinue | ForEach-Object { try { Remove-AppxPackage -Package $_.PackageFullName -ErrorAction Stop; Write-Output ('Removido: '+$_.Name) } catch { Write-Output ('Falha ao remover '+$_.Name+': '+$_.Exception.Message) } } }"
call :Log "Tentativa de remocao de pacotes Xbox selecionados."
echo.
echo Operacao finalizada. Alguns pacotes podem nao existir nesta versao.
exit /b

:RemoveApp
set "APPNAME=%~1"
set "PKG=%~2"
echo.
echo Aplicativo: %APPNAME%
echo Pacote: %PKG%
echo A remocao afeta o usuario atual e pode nao estar disponivel em todas as versoes.
set "CONF="
set /p "CONF=Tem certeza de que deseja tentar desinstalar este aplicativo? (S/N): "
if /i not "%CONF%"=="S" (
    echo Operacao cancelada.
    call :Log "Remocao cancelada pelo usuario: %APPNAME%."
    exit /b
)
powershell -NoProfile -ExecutionPolicy Bypass -Command "$p=Get-AppxPackage -Name '%PKG%' -ErrorAction SilentlyContinue; if($p){ try { $p | Remove-AppxPackage -ErrorAction Stop; Write-Output 'Solicitacao de remocao concluida.'; exit 0 } catch { Write-Output ('Nao foi possivel remover: '+$_.Exception.Message); exit 2 } } else { Write-Output 'Pacote nao encontrado para o usuario atual. Nenhuma alteracao realizada.'; exit 1 }"
set "RC=%errorlevel%"
call :Log "Aplicativo opcional: %APPNAME%. Codigo de retorno: %RC%"
echo.
echo Nota: este script nao remove provisionamento para novos usuarios.
exit /b

:CleanFolder
set "TARGET=%~1"
if not defined TARGET exit /b
if not exist "%TARGET%" (
    echo Pasta nao encontrada: "%TARGET%"
    exit /b
)
echo Limpando: "%TARGET%"
:: Apaga apenas o conteudo da pasta temporaria indicada; nao remove a pasta.
:: Arquivos bloqueados ou sem permissao sao ignorados.
del /f /s /q "%TARGET%\*" >nul 2>&1
for /d %%D in ("%TARGET%\*") do rd /s /q "%%~fD" >nul 2>&1
exit /b

:Log
>>"%LOG%" echo [%date% %time%] %~1
exit /b

:END
call :Log "Encerramento do Otimizador."
echo.
echo Otimizador encerrado.
echo Log salvo em: "%LOG%"
timeout /t 2 >nul
endlocal
exit /b
