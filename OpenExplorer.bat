@echo off
::
:: Author: MediocreEgg 
:: Date: 01/20/25
:: License: MIT License
::
:: Copyright (c) 2025 John Bryant Topacio
::
:: Permission is hereby granted, free of charge, to any person obtaining a copy
:: of this software and associated documentation files (the "Software"), to deal
:: in the Software without restriction, including without limitation the rights
:: to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
:: copies of the Software, and to permit persons to whom the Software is
:: furnished to do so, subject to the following conditions:
::
:: The above copyright notice and this permission notice shall be included in all
:: copies or substantial portions of the Software.
::
:: THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
:: IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
:: FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
:: AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
:: LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
:: OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
:: SOFTWARE.
::
::
:: ------------------------------------------------------------
:: DESCRIPTION:
:: This script opens a terminal and prints out a list of directories
:: (it was set on) and prompts the user for an input to explore a 
:: specific directory from the list.
:: 
:: After selecting a directory from the list by its index, the 
:: script will open that directory in Explorer.
:: ------------------------------------------------------------
:: P.S. I build this because I'm lazy and trying to learn BATCH. 
::

echo ===OpenExplorer v0.1.0===
echo.

:: BEGIN - MAIN
setlocal ENABLEDELAYEDEXPANSION
  set /A folderIndex=0
  set parentDirectory="D:\Coding Projects\*"

  :: Iterate over directories
  for /D %%G in (%parentDirectory%) do (
    set folderArray[!folderIndex!]=%%G
    echo.[!folderIndex!]%%G
    set /A folderIndex+=1
  )

  :: Create spacing between the printed directories and the prompt
  call :NEWLINE 2

  :: Prompt Message
  set /P rawInput="INDEX: "

  :: Check IF the rawInput aren't EMPTY
  if %rawInput%=="" (call :ERROR_MSG %ERRORLEVEL% "EMPTY PROMPT. Terminate Immediately!")

  :: Evaluates the rawInput IF it contains numbers
  :: So that it produces a Return Code- in which tells if it has the appropriate input 
  echo %rawInput% | FINDSTR /R "[0-9][0-9]*" >nul

  :: Checks IF the FINDSTR were able to determine if the input is allowed. 
  if %ERRORLEVEL% NEQ 0 (call :ERROR_MSG %ERRORLEVEL% "INPUT{%rawInput%} was invalid. Only numbers are allowed.") 

  set /A input_folderIndex=%rawInput%

  :: Open an explorer to a DIR (indicated by the arg)
  start explorer !folderArray[%input_folderIndex%]!

endLocal
call :END
:: END - MAIN 


:: USER_DEFINED_FUNCTIONS
:: NEWLINE- prints new line
:NEWLINE
  if %ERRORLEVEL% NEQ 0 (
    call :ERROR_MSG %ERRORLEVEL% "MISSING INDEX-ARGUMENT FOR NEWLINE FUNCTION"
  ) 

  for /L %%G in (0,1,%~1) do echo.
EXIT /B %ERRORLEVEL%


:: ERROR_MSG- prints error message
:ERROR_MSG
  if "%~2"=="" (echo "CRITICAL ERROR message") else (echo [ERROR=%~1]:^: %~2)
  call :END
EXIT /B %ERRORLEVEL%


:: END - exit the CMD
:END
EXIT
