*** Settings ***
Resource       ../keywords/common.robot

*** Variables ***
${CART_ITEM}            css:.cart_item
${CHECKOUT_BUTTON}      //button[@data-test="checkout"]
${CONTINUE_BUTTON}      //button[@data-test="continue-shopping"]

*** Keywords ***
Go To Cart Page
    Go To    ${CART_URL}
    Wait Until Element Is Visible    css:.cart_contents_container

Get Cart Item Count
    ${count}=    Get Element Count    ${CART_ITEM}
    RETURN    ${count}

Remove Item From Cart
    [Arguments]    ${item_name}
    ${button}=    Get WebElement    xpath://div[@class='cart_item'][.//div[text()='${item_name}']]//button[contains(text(),'Remove')]
    Click Element    ${button}

Proceed To Checkout
    Click Element    ${CHECKOUT_BUTTON}
    Wait Until Location Contains    checkout-step-one
