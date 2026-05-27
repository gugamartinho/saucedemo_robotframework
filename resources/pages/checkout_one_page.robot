*** Settings ***
Library        SeleniumLibrary
Library        Collections


*** Variables ***
${FIRST_NAME_INPUT}     //input[@data-test="firstName"]
${LAST_NAME_INPUT}      //input[@data-test="lastName"]
${POSTAL_CODE_INPUT}    //input[@data-test="postalCode"]
${CONTINUE_BUTTON}      //input[@data-test="continue"]
${CANCEL_BUTTON}        //button[@data-test="cancel"]
${ERROR_MESSAGE}        //div[@data-test="error"]

*** Keywords ***
Check Checkout Step One Page Is Loaded
    Wait Until Location Contains    checkout-step-one

Fill Checkout Form
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}
    Input Text    ${FIRST_NAME_INPUT}    ${first_name}
    Input Text    ${LAST_NAME_INPUT}     ${last_name}
    Input Text    ${POSTAL_CODE_INPUT}   ${postal_code}

Continue To Order Summary
    Wait Until Element Is Visible    ${CONTINUE_BUTTON}
    Click Element    ${CONTINUE_BUTTON}

Cancel Checkout
    Click Element    ${CANCEL_BUTTON}

Check Input Error Message
    [Arguments]    ${expected_text}
    Wait Until Element Is Visible    ${ERROR_MESSAGE}
    ${message}=    Get Text    ${ERROR_MESSAGE}
    Should Be Equal As Strings    ${message}    ${expected_text}
