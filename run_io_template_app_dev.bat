@echo off

rem ----------------------------------------------------------------------------
rem
rem run_io_template_app_dev.bat: Process IO-TEMPLATE-APP tasks.
rem
rem ----------------------------------------------------------------------------

setlocal EnableDelayedExpansion

set ENV_FOR_DYNACONF=dev

set ERRORLEVEL=
set IO_AERO_TASK=
set IO_AERO_TASK_DEFAULT=version

set PYTHONPATH=.

if ["%1"] EQU [""] (
    echo =======================================================================
    echo version - Show the IO-TEMPLATE-APP version
    echo -----------------------------------------------------------------------
    set /P IO_AERO_TASK="Enter the desired task [default: %IO_AERO_TASK_DEFAULT%] "

    if ["!IO_AERO_TASK!"] EQU [""] (
        set IO_AERO_TASK=%IO_AERO_TASK_DEFAULT%
    )
) else (
    set IO_AERO_TASK=%1
)

echo.
echo Script %0 is now running
echo.

set IO_AERO_TEMPLATE_APP_LOG=run_io_template_app_dev_%IO_AERO_TASK%.log

echo You can find the run log in the file %IO_AERO_TEMPLATE_APP_LOG%
echo.
echo Please wait ...
echo.

rem Check if logging_io_aero.log exists and delete it
if exist logging_io_aero.log (
    del /f /q logging_io_aero.log
)

rem Check if the file specified in IO_AERO_TEMPLATE_APP_LOG exists and delete it
if exist %IO_AERO_TEMPLATE_APP_LOG% (
    del /f /q %IO_AERO_TEMPLATE_APP_LOG%
)

> %IO_AERO_TEMPLATE_APP_LOG% 2>&1 (

    echo ===========================================================================
    echo Start %0
    echo ---------------------------------------------------------------------------
    echo IO_TEMPLATE_APP - Template for Application Repositories.
    echo ---------------------------------------------------------------------------
    echo ENV_FOR_DYNACONF         : %ENV_FOR_DYNACONF%
    echo PYTHONPATH               : %PYTHONPATH%
    echo ---------------------------------------------------------------------------
    echo TASK                     : %IO_AERO_TASK%
    echo ---------------------------------------------------------------------------
    echo:| TIME
    echo ===========================================================================

    rem ----------------------------------------------------------------------------
    rem Show the IO_TEMPLATE_APP version.
    rem ----------------------------------------------------------------------------
    if /I ["%IO_AERO_TASK%"] EQU ["version"] (
        python scripts\launcher.py -t "%IO_AERO_TASK%"
        if ERRORLEVEL 1 (
            echo Processing of the script run_io_template_app_dev was aborted
            exit 1
        )

        goto END_OF_SCRIPT
    )
)

rem ----------------------------------------------------------------------------
rem Program abort due to wrong input.
rem ----------------------------------------------------------------------------

echo Processing of the script run_io_template_app_dev is aborted: unknown task='%IO_AERO_TASK%'
exit 1

:END_OF_SCRIPT
echo.
echo ---------------------------------------------------------------------------
echo:| TIME
echo ---------------------------------------------------------------------------
echo End   %0
echo ===========================================================================

ENDLOCAL
