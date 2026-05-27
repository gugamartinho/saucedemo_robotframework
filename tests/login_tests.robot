*** Settings ***
Library         JSONLibrary
Resource        ../resources/pages/base_page.robot
Resource        ../resources/pages/login_page.robot
Resource        ../resources/pages/inventory_page.robot

Test Setup     Run Keywords
...    base_page.Load JSON Fixture Data    login    errorMessages    LOGIN_MESSAGES    AND
...    base_page.Open Browser And Go To Login Page

Test Teardown  base_page.Close Browser Session

*** Variables ***
${LOGIN_MESSAGES}    ${EMPTY}
*** Test Cases ***

Login With Valid Credentials
    [Tags]    login    smoke
    login_page.Login With Credentials    ${VALID_USER}    ${PASSWORD}
    inventory_page.Check Inventory Page Is Loaded

Login With Locked Out User
    [Tags]    login    negative
    login_page.Login With Credentials    ${LOCKED_USER}    ${PASSWORD}
    login_page.Error Message Should Contain    ${LOGIN_MESSAGES["login"]["lockedUser"]}        

Login With Invalid Credentials
    [Tags]    login    negative
    login_page.Login With Credentials    invalid_user    wrong_password
    login_page.Error Message Should Contain    ${LOGIN_MESSAGES["login"]["invalidCredentials"]}

Login With Empty Username
    [Tags]    login    negative
    login_page.Login With Credentials    ${EMPTY}    ${PASSWORD}
    login_page.Error Message Should Contain    ${LOGIN_MESSAGES["login"]["emptyUsername"]}

Login With Empty Password
    [Tags]    login    negative
    login_page.Login With Credentials    ${VALID_USER}    ${EMPTY}
    login_page.Error Message Should Contain    ${LOGIN_MESSAGES["login"]["emptyPassword"]}
