*** Settings ***
Resource        ../resources/pages/login_page.robot
Resource        ../resources/pages/inventory_page.robot
Resource        ../resources/pages/cart_page.robot


Test Setup     Run Keywords
...    Open Browser And Go To Login Page    AND
...    Login As Valid User

Test Teardown  Close Browser

*** Test Cases ***

Cart Is Empty By Default
    [Tags]    cart    smoke
    Go To Cart Page
    ${count}=    Get Cart Item Count
    Should Be Equal As Integers    ${count}    0

Cart Shows Added Items
    [Tags]    cart
    Add Item To Cart    Sauce Labs Backpack
    Add Item To Cart    Sauce Labs Bike Light
    Go To Cart Page
    ${count}=    Get Cart Item Count
    Should Be Equal As Integers    ${count}    2

Remove Item From Cart
    [Tags]    cart
    Add Item To Cart    Sauce Labs Backpack
    Go To Cart Page
    Remove Item From Cart    Sauce Labs Backpack
    ${count}=    Get Cart Item Count
    Should Be Equal As Integers    ${count}    0

Proceed To Checkout
    [Tags]    cart    smoke
    Add Item To Cart    Sauce Labs Backpack
    Go To Cart Page
    Proceed To Checkout
    Location Should Contain    checkout-step-one.html
