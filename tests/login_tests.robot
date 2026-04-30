*** Settings ***
Resource        ../resources/keywords/common.robot
Resource        ../resources/pages/login_page.robot


Test Setup     Open Browser And Go To Login Page
Test Teardown  Close Browser

*** Test Cases ***

Login With Valid Credentials
    [Tags]    login    smoke
    Login With Credentials    ${VALID_USER}    ${PASSWORD}
    Wait Until Location Contains    inventory.html
    Location Should Contain    inventory.html

Login With Locked Out User
    [Tags]    login    negative
    Login With Credentials    ${LOCKED_USER}    ${PASSWORD}
    Error Message Should Contain    locked out

Login With Invalid Credentials
    [Tags]    login    negative
    Login With Credentials    invalid_user    wrong_password
    Error Message Should Contain    Username and password do not match

Login With Empty Username
    [Tags]    login    negative
    Login With Credentials    ${EMPTY}    ${PASSWORD}
    Error Message Should Contain    Username is required

Login With Empty Password
    [Tags]    login    negative
    Login With Credentials    ${VALID_USER}    ${EMPTY}
    Error Message Should Contain    Password is required
