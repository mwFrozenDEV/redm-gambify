@echo off
setlocal enabledelayedexpansion
set "config=config.ini"
set "default_redmpath=%AppData%\CitizenFX\rdr3_settings"
set "current_dir=%~dp0"
set "default_exchange_name=RedMSettingsExchange"
set "filename=system.xml"
if not exist "%config%" (
    goto :initial_configuration
)
    :main_menu
    call :read_config
    call :verify_paths
    :main_menu_verified
    cls
    color 0D
    echo                                              ,                                                                       
    echo                                              Et                     :                                                
    echo                                              E#t                   t#,                               ,;L.            
    echo                                              E##t     j.          ;##W.                            f#i EW:        ,ft
    echo             ..       :           ;           E#W#t    EW,        :#L:WE                          .E#t  E##;       t#E
    echo            ,W,     .Et         .DL           E#tfL.   E##j      .KG  ,#D   ,##############Wf.   i#W,   E###t      t#E
    echo           t##,    ,W#t f.     :K#L     LWL   E#t      E###D.    EE    ;#f   ........jW##Wt     L#D.    E#fE#f     t#E
    echo          L###,   j###t EW:   ;W##L   .E#f ,ffW#Dffj.  E#jG#W;  f#.     t#i        tW##Kt     :K#Wfff;  E#t D#G    t#E
    echo        .E#j##,  G#fE#t E#t  t#KE#L  ,W#;   ;LW#ELLLf. E#t t##f :#G     GK       tW##E;       i##WLLLLt E#t  f#E.  t#E
    echo       ;WW; ##,:K#i E#t E#t f#D.L#L t#K:      E#t      E#t  :K#E:;#L   LW.     tW##E;          .E#L     E#t   t#K: t#E
    echo      j#E.  ##f#W,  E#t E#jG#f  L#LL#G        E#t      E#KDDDD###it#f f#:   .fW##D,              f#E:   E#t    ;#W,t#E
    echo    .D#L    ###K:   E#t E###;   L###j         E#t      E#f,t#Wi,,, f#D#;  .f###D,                 ,WW;  E#t     :K#D#E
    echo   :K#t     ##D.    E#t E#K:    L#W;          E#t      E#t  ;#W:    G#t .f####Gfffffffffff;        .D#; E#t      .E##E
    echo   ...      #G      ..  EG      LE.           E#t      DWi   ,KK:    t .fLLLLLLLLLLLLLLLLLi          tt ..         G#E
    echo            j           ;       ;@            ;#t                                                                   fE
    echo                          ::::::::      :::    :; :::   :::   ::::::::: ::::::::::: :::::::::: :::   :::             ,
    echo                        :+:    :+:   :+: :+:    :+:+: :+:+:  :+:    :+:    :+:     :+:        :+:   :+:  
    echo                       +:+         +:+   +:+  +:+ +:+:+ +:+ +:+    +:+    +:+     +:+         +:+ +:+    
    echo                      :#:        +#++:++#++: +#+  +:+  +#+ +#++:++#+     +#+     :#::+::#     +#++:      
    echo                     +#+   +#+# +#+     +#+ +#+       +#+ +#+    +#+    +#+     +#+           +#+        
    echo                    #+#    #+# #+#     #+# #+#       #+# #+#    #+#    #+#     #+#           #+#         
    echo                    ########  ###     ### ###       ### ######### ########### ###           ###          
    echo                   ============================================================================
    echo                   1. create custom RedM config
    echo                   2. swap RedM config
    echo                   3. initial config
    echo                   4. exit
    echo                   ============================================================================
    set /p choice="choose (1-4): "
        if "!choice!"=="1" goto create_custom_redm_config
        if "!choice!"=="2" goto swap_redm_config
        if "!choice!"=="3" goto initial_configuration
        if "!choice!"=="4" goto exiting
    pause

    :create_custom_redm_config
    cls
    color 04
    echo     dMMMMb  dMMMMMP dMMMMb  dMMMMMMMMb        .aMMMb  .aMMMb  dMMMMb  dMMMMMP dMP .aMMMMP 
    echo    dMP.dMP dMP     dMP VMP dMP dMP dMP       dMP VMP dMP dMP dMP dMP dMP     amr dMP     
    echo   dMMMMK  dMMMP   dMP dMP dMP dMP dMP       dMP     dMP dMP dMP dMP dMMMP   dMP dMP MMP  
    echo  dMP AMF dMP     dMP.aMP dMP dMP dMP       dMP.aMP dMP.aMP dMP dMP dMP     dMP dMP.dMP    
    echo dMP dMP dMMMMMP dMMMMP  dMP dMP dMP        VMMMP   VMMMP  dMP dMP dMP     dMP  VMMMP     
    echo ====================================================================================
    echo \
    echo \                              xxx DISCLAIMER xxx
    echo \ This tool will create a copy of your current system.xml file and manipulate it.
    echo \ Please make sure there is no other %filename% inside the following path: 
    echo \
    echo \ !exchange_folder_path!
    echo \
    echo \ Otherwise it will go straight to the editor and edit the %filename% inside the path.
    echo \
    echo ====================================================================================
    pause
    echo \
    if exist "!exchange_folder_path!\%filename%" (
        goto :config_editor
    ) 
     else (
        copy "!redm_config_path!\%filename%" "!exchange_folder_path!\%filename%" >nul
        if %errorlevel% equ 0 (
            echo \
            echo \ copied !redm_config_path!\%filename%.
            echo \
            goto :config_editor
        ) else (
            color 40
            echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
            echo \ Error. Failed copying !redm_config_path!\%filename% to !exchange_folder_path!.
            echo \                              Please try again                                  
            echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
            pause
            goto :main_menu
        ) 
    )

    :config_editor
    cls
    echo    _______  ______________  ___ 
    echo   / __/ _ \/  _/_  __/ __ \/ _ \
    echo  / _// // // /  / / / /_/ / , _/
    echo /___/____/___/ /_/  \____/_/\_\ 
    echo ===================================
    echo \
    echo \ DISCLAIMER: These options will be instantly applied when selecting
    echo \ except if clearly stated otherwise
    echo \
    echo \ Options:
    echo \ 1. Change all settings to low 
    echo \ 2. Disable grass
    echo \ 3. Up gamma / brightness
    echo \ 4. change display ratio \\ options displayed after selecting
    echo \ 0. Back to menu
    echo \
    echo ===================================
    set /p choice="choose (1-4): "
        if "!choice!"=="1" goto change_settings_to_low
        if "!choice!"=="2" goto disable_grass
        if "!choice!"=="3" goto up_gamma
        if "!choice!"=="4" goto change_display_ratio       
        if "!choice!"=="0" goto main_menu                    

    :change_settings_to_low
    pause
    :disable_grass
    pause
    :up_gamma
    pause
    :change_display_ratio
    pause

    :swap_redm_config
    cls
    echo      ___           ___           ___           ___   
    echo     /  /\         /__/\         /  /\         /  /\  
    echo    /  /:/_       _\_ \:\       /  /::\       /  /::\ 
    echo   /  /:/ /\     /__/\ \:\     /  /:/\:\     /  /:/\:\
    echo  /  /:/ /::\   _\_ \:\ \:\   /  /:/~/::\   /  /:/~/:/
    echo /__/:/ /:/\:\ /__/\ \:\ \:\ /__/:/ /:/\:\ /__/:/ /:/ 
    echo \  \:\/:/~/:/ \  \:\ \:\/:/ \  \:\/:/__\/ \  \:\/:/  
    echo  \  \::/ /:/   \  \:\ \::/   \  \::/       \  \::/   
    echo   \__\/ /:/     \  \:\/:/     \  \:\        \  \:\   
    echo     /__/:/       \  \::/       \  \:\        \  \:\  
    echo     \__\/         \__\/         \__\/         \__\/ 
    goto :verify_if_systemxml_exists 
    :verified_sysxml
    move "!redm_config_path!\%filename%" "%TEMP%\%filename%" >nul
    if %errorlevel% equ 0 (
        echo \
        echo \      moved %filename% from !redm_config_path! to %TEMP%
    ) else (
        echo Error. Failed moving %filename% from !redm_config_path! to %TEMP%.
        goto end_swap_settings
    )

    move "!exchange_folder_path!\%filename%" "!redm_config_path!\%filename%" >nul
    if %errorlevel% equ 0 (
        echo \      moved %filename% from !exchange_folder_path! to !redm_config_path!
    ) else (
        echo Error. Failed moving %filename% from !exchange_folder_path! to !redm_config_path!
        goto end_swap_settings
    )
    move "%TEMP%\%filename%" "!exchange_folder_path!\%filename%" >nul
    if %errorlevel% equ 0 (
        echo \      moved %filename% from %TEMP% to !exchange_folder_path!
    ) else (
        echo Error. Failed moving %filename% from %TEMP% to !exchange_folder_path!
        goto end_swap_settings
    )
    color 0A
    echo =================================================================================
    echo \
    echo \                              SETTINGS SWAP SUCCESS
    echo \
    echo =================================================================================
    pause
    goto :main_menu

    :end_swap_settings
    color 40
    echo $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
    echo $$$$$$$$$$$$$$$$$$$$$$$$$$$$ Error! Aborted swapper. $$$$$$$$$$$$$$$$$$$$$$$$$$$$$
    echo $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$   
    pause
    goto :main_menu

    :batch_settings
    cls
    echo batch settings
    pause

    :exiting
    exit

    :initial_configuration
    color 0D
    cls
    echo #### ##    ## #### ######## ####    ###    ##           ######   #######  ##    ## ######## ####  ######   
    echo  ##  ###   ##  ##     ##     ##    ## ##   ##          ##    ## ##     ## ###   ## ##        ##  ##    ##  
    echo  ##  ####  ##  ##     ##     ##   ##   ##  ##          ##       ##     ## ####  ## ##        ##  ##        
    echo  ##  ## ## ##  ##     ##     ##  ##     ## ##          ##       ##     ## ## ## ## ######    ##  ##   #### 
    echo  ##  ##  ####  ##     ##     ##  ######### ##          ##       ##     ## ##  #### ##        ##  ##    ##  
    echo  ##  ##   ###  ##     ##     ##  ##     ## ##          ##    ## ##     ## ##   ### ##        ##  ##    ##  
    echo #### ##    ## ####    ##    #### ##     ## ########     ######   #######  ##    ## ##       ####  ######   
    if exist %default_redmpath% (
        echo ==========================================================================================================
        echo \
        echo \      RedM Settings folder detected.
        echo \      path: %default_redmpath%
        echo \
        set redm_config_path=%default_redmpath%
    ) else (
        :failed_rdr3_settings_path
        echo ==========================================================================================================
        echo \
        echo \      No RedM Settings folder detected. Specify custom path.
        echo \      Example Path: C:\Users\mwFrozen\AppData\Roaming\CitizenFX\rdr3_settings
        echo \
        echo ==========================================================================================================
        set /p redm_config_path="specify path: "
        if exist "!redm_config_path!" (
            echo ==========================================================================================================
            echo \
            echo \      Verified Path: !redm_config_path!
            echo \
            echo ==========================================================================================================
        ) else (
            color 40
            echo ==========================================================================================================
            echo \
            echo \      !redm_config_path! is not a valid path.
            echo \      Please try again.
            echo \
            echo ==========================================================================================================
            pause
            cls
            goto :failed_rdr3_settings_path
        )
    )
    echo ==========================================================================================================
    echo \
    echo \      Exchange folder needed. This is where your alternative config will be stored.
    echo \      1. automatic creation \\ will be at the location of this .bat file
    echo \      2. manual creation \\ specify a custom path
    echo \
    echo ==========================================================================================================
    set /p choice_creation="choose (1-2): "
    if "!choice_creation!"=="1" goto auto_creation
    if "!choice_creation!"=="2" goto manual_creation

    :auto_creation
    if not exist %current_dir%%default_exchange_name% (
        mkdir %current_dir%%default_exchange_name%
        set "exchange_folder_path=%current_dir%%default_exchange_name%"
    ) else (
        set "exchange_folder_path=%current_dir%%default_exchange_name%"
    )
    echo ==========================================================================================================
    echo \       
    echo \      exchange folder path:
    echo \      !exchange_folder_path!
    echo \      
    echo ==========================================================================================================
    pause
    goto :finish_initial_config

    :manual_creation
    color 0D
    echo ==========================================================================================================
    echo \       
    echo \      manual creation
    echo \      please specify your custom path
    echo \      
    echo ==========================================================================================================
    set /p exchange_folder_path="specify path: "
    if not exist !exchange_folder_path! (
        color 40
        echo ==========================================================================================================
        echo \       
        echo \      !exchange_folder_path! does not exist.
        echo \      please try again.
        echo \      
        echo ==========================================================================================================
        pause
        cls
        goto :manual_creation
    ) else (
        echo ==========================================================================================================
        echo \       
        echo \      exchange folder path:
        echo \      !exchange_folder_path!
        echo \      
        echo ==========================================================================================================
        pause
        call :write_config
    )
)

:finish_initial_config
    cls
    color 0A
    call :write_config
    echo   .d8888b.   .d88888b.  888b    888 8888888888 8888888 .d8888b.  
    echo  d88P  Y88b d88P" "Y88b 8888b   888 888          888  d88P  Y88b 
    echo  888    888 888     888 88888b  888 888          888  888    888 
    echo  888        888     888 888Y88b 888 8888888      888  888        
    echo  888        888     888 888 Y88b888 888          888  888  88888 
    echo  888    888 888     888 888  Y88888 888          888  888    888 
    echo  Y88b  d88P Y88b. .d88P 888   Y8888 888          888  Y88b  d88P 
    echo    Y8888P     Y88888P   888    Y888 888        8888888  Y8888P88 
    echo ==========================================================================================================
    echo \       
    echo \      redm settings path:
    echo \      !redm_config_path!
    echo \      exchange folder path:
    echo \      !exchange_folder_path!
    echo \      
    echo ==========================================================================================================
    pause
    goto :main_menu

:write_config
(
    echo [Config]
    echo redmpath=!redm_config_path!
    echo exchange_folder_path=!exchange_folder_path!
) > %config%
GOTO :eof

:read_config
for /f "tokens=1,2 delims==" %%a in (%config%) do (
    set "line=%%b"
    for /l %%i in (1,1,31) do if "!line:~-1!"==" " set "line=!line:~0,-1!"
    if "%%a"=="redmpath" set "redm_config_path=!line!"
    if "%%a"=="exchange_folder_path" set "exchange_folder_path=!line!"
)
goto :eof

:verify_paths
if exist !redm_config_path! (
    if exist !exchange_folder_path! (
    echo verified paths
    goto :main_menu_verified
    ) else (
        goto :failed_verify_paths
    )
) else (
    :failed_verify_paths
    cls
    color 40
    echo ==========================================================================================================
    echo \       
    echo \      paths in config or exchange folder does not exist anymore.
    echo \      please go through inital config again.
    echo \      
    echo ==========================================================================================================
    pause 
    goto :initial_configuration
)
goto :eof

:verify_if_systemxml_exists
echo ========================================================
echo \
if exist "!redm_config_path!\%filename%" (
    set isError=0
    echo \      !redm_config_path!\%filename% exists
    if exist "!exchange_folder_path!\%filename%" (
        set isError=0
        echo \      !exchange_folder_path!\%filename% exists
    ) else (
        color 40
        echo \      !exchange_folder_path!\%filename% does not exist. Error.
        echo \      Create custom config in menu.
        set isError=1
    )
) else (
    color 40
    echo \      !redm_config_path!\%filename% does not exist. Error.
    set isError=1
)
echo \
echo ========================================================
if "!isError!"=="1" (
    pause
    goto :main_menu
) else (
    goto :verified_sysxml
)

