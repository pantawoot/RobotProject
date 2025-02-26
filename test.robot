*** Settings ***
Library  SeleniumLibrary

*** Test Cases ***
Open Google And Search
    Open Browser  https://www.google.com  chrome
    Input Text    name=q   Robot Framework
    Press Keys    name=q   ENTER
    Sleep    2s
    Close Browser