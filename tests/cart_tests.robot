*** Settings ***
Resource        ../resources/pages/base_page.robot
Resource        ../resources/pages/login_page.robot
Resource        ../resources/pages/inventory_page.robot
Resource        ../resources/pages/cart_page.robot
Resource        ../resources/pages/checkout_one_page.robot


Test Setup     Run Keywords
...    base_page.Open Browser And Go To Login Page    AND
...    base_page.Load JSON Fixture Data    products    productsData    PRODUCT_DATA    AND
...    login_page.Login As Valid User

Test Teardown    base_page.Close Browser Session

*** Variables ***
${PRODUCT_DATA}    ${EMPTY}

*** Test Cases ***

Cart Is Empty By Default
    [Tags]    cart
    base_page.Open Shopping Cart
    cart_page.Check Cart Amount Of Items    0

Cart Shows Added Items
    [Tags]    cart
    inventory_page.Add Item To Cart    ${PRODUCT_DATA["product"][0]["name"]}
    inventory_page.Add Item To Cart    ${PRODUCT_DATA["product"][1]["name"]}
    base_page.Open Shopping Cart
    cart_page.Check Cart Amount Of Items    2

Remove Item From Cart
    [Tags]    cart
    inventory_page.Add Item To Cart    ${PRODUCT_DATA["product"][0]["name"]}
    inventory_page.Add Item To Cart    ${PRODUCT_DATA["product"][1]["name"]}
    base_page.Open Shopping Cart
    cart_page.Remove Item From Cart    ${PRODUCT_DATA["product"][1]["name"]}
    cart_page.Check Cart Amount Of Items    1

Proceed To Checkout
    [Tags]    cart    
    inventory_page.Add Item To Cart    ${PRODUCT_DATA["product"][0]["name"]}
    base_page.Open Shopping Cart
    cart_page.Proceed To Checkout
    checkout_one_page.Check Checkout Step One Page Is Loaded
