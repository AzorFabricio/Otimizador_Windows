@echo off
setlocal EnableExtensions
title Otimizador Seguro - Windows 10 e 11
color 0A

:: ============================================================
:: Otimizador seguro para Windows 10/11
:: Nao desativa Windows Update, Defender, firewall ou servicos.
:: Execute como Administrador para usar todas as funcoes.
:: ============================================================

set "LOG=%~dp0Otimizacao_Windows.log"

:: Solicita elevacao administrativa quando necessario
net session >nul 2>&1
if not "%errorlevel%"=="0" (
    echo Solicitando permissao de Administrador...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

:MENU
cls
echo ============================================================
echo         OTIMIZADOR SEGURO - WINDOWS 10 / WINDOWS 11
echo ============================================================
echo.
echo Este script executa tarefas de manutencao sem desativar
echo recursos de seguranca, atualizacoes ou servicos essenciais.
echo.
echo [1] Limpar arquivos temporarios do usuario
echo [2] Limpar arquivos temporarios do Windows
echo [3] Limpar cache DNS
echo [4] Verificar e reparar arquivos do sistema (SFC)
echo [5] Reparar imagem do Windows (DISM)
echo [6] Executar limpeza completa (1, 2, 3 e 4)
echo [7] Abrir Limpeza de Disco do Windows (se disponivel)
echo [8] Mostrar informacoes basicas do sistema
echo [0] Sair
echo.
set /p "OPCAO=Escolha uma opcao: "

if "%OPCAO%"=="1" goto TEMP_USUARIO
if "%OPCAO%"=="2" goto TEMP_WINDOWS
if "%OPCAO%"=="3" goto DNS
if "%OPCAO%"=="4" goto SFC
if "%OPCAO%"=="5" goto DISM
if "%OPCAO%"=="6" goto COMPLETA
if "%OPCAO%"=="7" goto DISK_CLEANUP
if "%OPCAO%"=="8" goto INFO
if "%OPCAO%"=="0" goto FIM
echo.
echo Opcao invalida.
pause
goto MENU

:TEMP_USUARIO
echo [%date% %time%] Limpando temporarios do usuario...>>"%LOG%"
echo.
echo Limpando arquivos temporarios do usuario...
if defined TEMP (
    del /f /s /q "%TEMP%\*" >nul 2>&1
    for /d %%D in ("%TEMP%\*") do rd /s /q "%%~fD" >nul 2>&1
)
echo Concluido. Arquivos em uso podem ser mantidos pelo Windows.
echo [%date% %time%] Limpeza de temporarios do usuario concluida.>>"%LOG%"
pause
goto MENU

:TEMP_WINDOWS
echo [%date% %time%] Limpando temporarios do Windows...>>"%LOG%"
echo.
echo Limpando arquivos temporarios do Windows...
if exist "%SystemRoot%\Temp" (
    del /f /s /q "%SystemRoot%\Temp\*" >nul 2>&1
    for /d %%D in ("%SystemRoot%\Temp\*") do rd /s /q "%%~fD" >nul 2>&1
)
echo Concluido. Arquivos em uso ou protegidos serao ignorados.
echo [%date% %time%] Limpeza de temporarios do Windows concluida.>>"%LOG%"
pause
goto MENU

:DNS
echo [%date% %time%] Limpando cache DNS...>>"%LOG%"
echo.
ipconfig /flushdns
echo [%date% %time%] Comando de limpeza DNS executado.>>"%LOG%"
pause
goto MENU

:SFC
echo [%date% %time%] Iniciando SFC...>>"%LOG%"
echo.
echo A verificacao pode levar varios minutos.
sfc /scannow
echo [%date% %time%] SFC finalizado com codigo %errorlevel%.>>"%LOG%"
pause
goto MENU

:DISM
echo [%date% %time%] Iniciando DISM RestoreHealth...>>"%LOG%"
echo.
echo O processo pode demorar e requer internet em alguns casos.
DISM /Online /Cleanup-Image /RestoreHealth
echo [%date% %time%] DISM finalizado com codigo %errorlevel%.>>"%LOG%"
pause
goto MENU

:COMPLETA
echo.
echo A limpeza completa remove temporarios e executa SFC.
echo Ela nao apaga documentos, fotos ou downloads pessoais.
echo.
choice /c SN /m "Deseja continuar"
if errorlevel 2 goto MENU
call :LIMPAR_USUARIO
call :LIMPAR_WINDOWS
echo [%date% %time%] Limpando cache DNS...>>"%LOG%"
ipconfig /flushdns
echo [%date% %time%] Executando SFC...>>"%LOG%"
sfc /scannow
echo.
echo Limpeza completa finalizada. Para reparar a imagem do Windows,
echo execute tambem a opcao 5 se ainda houver problemas.
pause
goto MENU

:LIMPAR_USUARIO
if defined TEMP (
    del /f /s /q "%TEMP%\*" >nul 2>&1
    for /d %%D in ("%TEMP%\*") do rd /s /q "%%~fD" >nul 2>&1
)
echo [%date% %time%] Temporarios do usuario limpos.>>"%LOG%"
exit /b

:LIMPAR_WINDOWS
if exist "%SystemRoot%\Temp" (
    del /f /s /q "%SystemRoot%\Temp\*" >nul 2>&1
    for /d %%D in ("%SystemRoot%\Temp\*") do rd /s /q "%%~fD" >nul 2>&1
)
echo [%date% %time%] Temporarios do Windows limpos.>>"%LOG%"
exit /b

:DISK_CLEANUP
echo.
if exist "%SystemRoot%\System32\cleanmgr.exe" (
    start "" cleanmgr.exe
) else (
    echo A Limpeza de Disco (cleanmgr) nao esta disponivel nesta instalacao.
    echo Use Configuracoes ^> Sistema ^> Armazenamento ^> Arquivos temporarios.
)
pause
goto MENU

:INFO
echo.
echo Nome do computador: %COMPUTERNAME%
echo Usuario atual: %USERNAME%
ver
echo.
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"System Type" /C:"Nome do sistema operacional" /C:"Versao do sistema operacional" /C:"Tipo do sistema"
echo.
echo Arquivo de registro: "%LOG%"
pause
goto MENU

:FIM
echo.
echo Obrigado por usar o Otimizador Seguro.
echo Registro salvo em: "%LOG%"
timeout /t 2 >nul
endlocal
exit /b
