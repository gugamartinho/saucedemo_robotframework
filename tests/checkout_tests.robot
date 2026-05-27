*** Settings ***
Resource        ../resources/pages/base_page.robot
Resource        ../resources/pages/login_page.robot
Resource        ../resources/pages/cart_page.robot
Resource        ../resources/pages/inventory_page.robot
Resource        ../resources/pages/checkout_one_page.robot
Resource        ../resources/pages/checkout_two_page.robot
Resource        ../resources/pages/checkout_confirmation_page.robot

Test Setup     Run Keywords
...    base_page.Open Browser And Go To Login Page    AND
...    base_page.Load JSON Fixture Data    customers   customerData        CUSTOMER_DATA        AND
...    base_page.Load JSON Fixture Data    products    productsData        PRODUCT_DATA         AND
...    base_page.Load JSON Fixture Data    checkout    checkoutMessages    CHECKOUT_MESSAGES    AND
...    login_page.Login As Valid User    AND
...    inventory_page.Add Item To Cart    ${PRODUCT_DATA["product"][0]["name"]}   AND
...    base_page.Open Shopping Cart    AND
...    cart_page.Proceed To Checkout    AND
...    checkout_one_page.Check Checkout Step One Page Is Loaded

Test Teardown  base_page.Close Browser Session

*** Variables ***
${CUSTOMER_DATA}        ${EMPTY}
${PRODUCT_DATA}         ${EMPTY}
${CHECKOUT_MESSAGES}    ${EMPTY}

*** Test Cases ***

Complete Full Checkout Flow
    [Tags]    checkout    e2e
    checkout_one_page.Fill Checkout Form    ${CUSTOMER_DATA["customer"][0]["firstName"]}    ${CUSTOMER_DATA["customer"][0]["lastName"]}    ${CUSTOMER_DATA["customer"][0]["postalCode"]}
    checkout_one_page.Continue To Order Summary
    checkout_two_page.Check Checkout Step Two Page Is Loaded
    checkout_two_page.Finish Order
    checkout_confirmation_page.Check Checkout Confirmation Page Is Loaded
    checkout_confirmation_page.Check Header Confirmation Message    ${CHECKOUT_MESSAGES["messages"]["headerMessage"]}
    checkout_confirmation_page.Check Dispatch Message               ${CHECKOUT_MESSAGES["messages"]["dispatchMessage"]}

Should Show Error When First Name Input Is Missing
    [Tags]    checkout
    checkout_one_page.Fill Checkout Form    ${EMPTY}    ${CUSTOMER_DATA["customer"][0]["lastName"]}    ${CUSTOMER_DATA["customer"][0]["postalCode"]}
    checkout_one_page.Continue To Order Summary
    checkout_one_page.Check Input Error Message    ${CHECKOUT_MESSAGES["messages"]["missingFirstName"]}    

Should Show Error When Last Name Input Is Missing
    [Tags]    checkout
    checkout_one_page.Fill Checkout Form    ${CUSTOMER_DATA["customer"][0]["firstName"]}    ${EMPTY}    ${CUSTOMER_DATA["customer"][0]["postalCode"]}
    checkout_one_page.Continue To Order Summary
    checkout_one_page.Check Input Error Message    ${CHECKOUT_MESSAGES["messages"]["missingLastName"]} 

Should Show Error When Postal COde Input Is Missing
    [Tags]    checkout
    checkout_one_page.Fill Checkout Form    ${CUSTOMER_DATA["customer"][0]["firstName"]}    ${CUSTOMER_DATA["customer"][0]["lastName"]}    ${EMPTY}
    checkout_one_page.Continue To Order Summary
    checkout_one_page.Check Input Error Message    ${CHECKOUT_MESSAGES["messages"]["missingPostalCode"]} 

Should Cancel Checkout And Return To Cart
    [Tags]    checkout
    checkout_one_page.Cancel Checkout
    cart_page.Check Cart Page Is Loaded


Summary Info Is Ok After Checkout
    [Tags]    checkout    e2e
    checkout_one_page.Fill Checkout Form    ${CUSTOMER_DATA["customer"][0]["firstName"]}    ${CUSTOMER_DATA["customer"][0]["lastName"]}    ${CUSTOMER_DATA["customer"][0]["postalCode"]}
    checkout_one_page.Continue To Order Summary
    checkout_two_page.Check Checkout Step Two Page Is Loaded
    checkout_two_page.Check Summary Order Sub-Total    ${PRODUCT_DATA["product"][0]["price"]}
    checkout_two_page.Check Summary Order Tax          ${PRODUCT_DATA["product"][0]["tax"]}
    checkout_two_page.Check Summary Order Total        ${PRODUCT_DATA["product"][0]["total"]}