*** Settings ***
Library        SeleniumLibrary
Library        Collections


*** Variables ***
${H2_MESSAGE}          //h2[@data-test="complete-header"]
${DISPATCH_MESSAGE}    //div[@data-test="complete-text"]

*** Keywords ***
Check Checkout Confirmation Page Is Loaded
    Wait Until Location Contains    checkout-complete

Check Header Confirmation Message
    [Arguments]    ${expected_message}
    Wait Until Element Is Visible    ${H2_MESSAGE}
    ${message}=    Get Text    ${H2_MESSAGE}
    Should Be Equal As Strings    first=${message}    second=${expected_message}

Check Dispatch Message
    [Arguments]    ${expected_message}
    Wait Until Element Is Visible    ${DISPATCH_MESSAGE}
    ${message}=    Get Text    ${DISPATCH_MESSAGE}
    Should Be Equal As Strings    first=${message}    second=${expected_message}