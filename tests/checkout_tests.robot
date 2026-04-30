*** Settings ***
Resource        ../resources/keywords/common.robot
Resource        ../resources/pages/login_page.robot
Resource        ../resources/pages/checkout_page.robot
Resource        ../resources/pages/cart_page.robot
Resource        ../resources/pages/inventory_page.robot

Test Setup     Run Keywords
...    Open Browser And Go To Login Page    AND
...    Login As Valid User    AND
...    Add Item To Cart    Sauce Labs Backpack    AND
...    Go To Cart Page    AND
...    Proceed To Checkout

Test Teardown  Close Browser


*** Test Cases ***

Complete Full Checkout Flow
    [Tags]    checkout    smoke    e2e
    Fill Checkout Form    ${FIRST_NAME}    ${LAST_NAME}    ${POSTAL_CODE}
    Continue To Order Summary
    ${total}=    Get Order Total
    Should Contain    ${total}    $
    Finish Order
    Location Should Contain    checkout-complete.html
    ${message}=    Get Confirmation Message
    Should Contain    ${message}    Thank you

Error When First Name Is Missing
    [Tags]    checkout    negative
    Fill Checkout Form    ${EMPTY}    ${LAST_NAME}    ${POSTAL_CODE}
    Continue To Order Summary
    Checkout Error Should Contain    First Name is required

Error When Last Name Is Missing
    [Tags]    checkout    negative
    Fill Checkout Form    ${FIRST_NAME}    ${EMPTY}    ${POSTAL_CODE}
    Continue To Order Summary
    Checkout Error Should Contain    Last Name is required

Error When Postal Code Is Missing
    [Tags]    checkout    negative
    Fill Checkout Form    ${FIRST_NAME}    ${LAST_NAME}    ${EMPTY}
    Continue To Order Summary
    Checkout Error Should Contain    Postal Code is required

Cancel Checkout Returns To Cart
    [Tags]    checkout    navigation
    Cancel Checkout
    Location Should Contain    cart.html

Correct Item In Order Summary
    [Tags]    checkout    smoke
    Fill Checkout Form    ${FIRST_NAME}    ${LAST_NAME}    ${POSTAL_CODE}
    Continue To Order Summary
    ${names}=    Get Summary Item Names
    List Should Contain Value    ${names}    Sauce Labs Backpack
