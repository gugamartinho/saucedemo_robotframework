*** Settings ***
Library        SeleniumLibrary
Variables      ../variables/variables.py

*** Variables ***
${CART_ITEM}            //div[@data-test="inventory-item"]
${CHECKOUT_BUTTON}      //button[@data-test="checkout"]

*** Keywords ***
Check Cart Page Is Loaded
    Wait Until Location Contains    cart

Check Cart Amount Of Items
    [Arguments]    ${expected_count}
    ${count}=    Get Element Count    ${CART_ITEM}
    Should Be Equal As Integers    first=${count}    second=${expected_count}

Remove Item From Cart
    [Arguments]    ${item_name}
    ${button}=    Set Variable    //div[@data-test='inventory-item-name' and text()='${item_name}']/ancestor::div[@data-test='inventory-item']//button[contains(@data-test,'remove')]
    Wait Until Element Is Visible    ${button}
    Click Element    ${button}


Proceed To Checkout
    Click Element    ${CHECKOUT_BUTTON}
