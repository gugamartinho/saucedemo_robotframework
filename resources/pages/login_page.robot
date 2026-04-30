*** Settings ***
Resource       ../keywords/common.robot

*** Variables ***
${USERNAME_INPUT}       //input[@data-test="username"]
${PASSWORD_INPUT}       //input[@data-test="password"]
${LOGIN_BUTTON}         //input[@data-test="login-button"]
${ERROR_MESSAGE}        //h3[@data-test="error"]

*** Keywords ***
Open Login Page
    Go To    ${BASE_URL}
    Wait Until Element Is Visible    ${USERNAME_INPUT}

Login With Credentials
    [Arguments]    ${username}    ${password}
    Input Text        ${USERNAME_INPUT}    ${username}
    Input Text        ${PASSWORD_INPUT}    ${password}
    Click Button      ${LOGIN_BUTTON}

Login As Valid User
    Login With Credentials    ${VALID_USER}    ${PASSWORD}
    Wait Until Element Is Visible    css:.inventory_list

Get Login Error Message
    Wait Until Element Is Visible    ${ERROR_MESSAGE}
    ${message}=    Get Text    ${ERROR_MESSAGE}
    RETURN    ${message}

Error Message Should Contain
    [Arguments]    ${expected_text}
    ${message}=    Get Login Error Message
    Should Contain    ${message}    ${expected_text}
