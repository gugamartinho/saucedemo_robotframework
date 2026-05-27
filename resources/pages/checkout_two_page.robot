*** Settings ***
Library        SeleniumLibrary
Library        Collections


*** Variables ***
${FINISH_BUTTON}        //button[@data-test="finish"]
${CANCEL_BUTTON}        //button[@data-test="cancel"]
${SUMMARY_SUB_TOTAL}    //div[@data-test="subtotal-label"]
${SUMMARY_TAX}          //div[@data-test="tax-label"]
${SUMMARY_TOTAL}        //div[@data-test="total-label"]

*** Keywords ***
Check Checkout Step Two Page Is Loaded
    Wait Until Location Contains    checkout-step-two

Finish Order
    Click Element    ${FINISH_BUTTON}
    Wait Until Location Contains    checkout-complete

Cancel Checkout
    Click Element    ${CANCEL_BUTTON}

Check Summary Order Sub-Total
    [Arguments]    ${expected_value}
    ${sub_total}=    Get Text    ${SUMMARY_SUB_TOTAL}
    Should Contain    ${sub_total}    ${expected_value}    

Check Summary Order Tax
    [Arguments]    ${expected_value}
    ${tax}=    Get Text    ${SUMMARY_TAX}
    Should Contain    ${tax}    ${expected_value} 

Check Summary Order Total
    [Arguments]    ${expected_value}
    ${tax}=    Get Text    ${SUMMARY_TOTAL}
    Should Contain    ${tax}    ${expected_value} 