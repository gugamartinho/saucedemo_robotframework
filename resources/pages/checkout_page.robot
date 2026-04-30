*** Settings ***
Resource       ../keywords/common.robot


*** Variables ***
${FIRST_NAME_INPUT}     //input[@data-test="firstName"]
${LAST_NAME_INPUT}      //input[@data-test="lastName"]
${POSTAL_CODE_INPUT}    //input[@data-test="postalCode"]
${CONTINUE_BUTTON}      //input[@data-test="continue"]
${FINISH_BUTTON}        //button[@data-test="finish"]
${CANCEL_BUTTON}        //button[@data-test="cancel"]
${ERROR_MESSAGE}        //div[@data-test="error"]
${SUMMARY_TOTAL}        css:.summary_total_label
${CONFIRMATION}         css:.complete-header
${SUMMARY_ITEM_NAME}    css:.inventory_item_name

*** Keywords ***
Fill Checkout Form
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}
    Input Text    ${FIRST_NAME_INPUT}    ${first_name}
    Input Text    ${LAST_NAME_INPUT}     ${last_name}
    Input Text    ${POSTAL_CODE_INPUT}   ${postal_code}

Continue To Order Summary
    Click Element    ${CONTINUE_BUTTON}

Finish Order
    Click Element    ${FINISH_BUTTON}
    Wait Until Location Contains    checkout-complete

Cancel Checkout
    Click Element    ${CANCEL_BUTTON}

Get Checkout Error Message
    Wait Until Element Is Visible    ${ERROR_MESSAGE}
    ${message}=    Get Text    ${ERROR_MESSAGE}
    RETURN    ${message}

Checkout Error Should Contain
    [Arguments]    ${expected_text}
    ${message}=    Get Checkout Error Message
    Should Contain    ${message}    ${expected_text}

Get Order Total
    ${total}=    Get Text    ${SUMMARY_TOTAL}
    RETURN    ${total}

Get Confirmation Message
    Wait Until Element Is Visible    ${CONFIRMATION}
    ${message}=    Get Text    ${CONFIRMATION}
    RETURN    ${message}

Get Summary Item Names
    ${elements}=    Get WebElements    ${SUMMARY_ITEM_NAME}
    ${names}=    Create List
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Text    ${element}
        Append To List    ${names}    ${text}
    END
    RETURN    ${names}
