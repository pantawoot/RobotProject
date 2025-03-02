*** Settings ***
Library  SeleniumLibrary

*** Test Cases ***
Search In Google
    Open Browser    https://www.google.com    chrome
    Input Text    name=q    Robot Framework
    Press Keys    name=q    ENTER
    Sleep    2s
    Close Browser

Open Gmail
    Open Browser    https://www.gmail.com    chrome
    Sleep    s
    Close Browser

Open sanook
    Open Browser    https://www.sanook.com    chrome
    Sleep    s
    Close Browser