*** Settings ***
Resource        ../resources/pages/base_page.robot
Resource        ../resources/pages/login_page.robot
Resource        ../resources/pages/inventory_page.robot


Test Setup     Run Keywords
...    base_page.Open Browser And Go To Login Page    AND
...    base_page.Load JSON Fixture Data    products    productsData    PRODUCT_DATA    AND
...    login_page.Login As Valid User

Test Teardown  base_page.Close Browser Session

*** Variables ***
${PRODUCT_DATA}    ${EMPTY}

*** Test Cases ***

Should Add Item To Cart
    [Tags]    inventory    cart
    inventory_page.Check Cart Badge Should Not Be Visible
    inventory_page.Add Item To Cart    ${PRODUCT_DATA["product"][0]["name"]}
    inventory_page.Check Cart Badge Number    1

Should Add Multiple Items To Cart
    [Tags]    inventory    cart
    inventory_page.Check Cart Badge Should Not Be Visible
    inventory_page.Add Item To Cart    ${PRODUCT_DATA["product"][0]["name"]}
    inventory_page.Add Item To Cart    ${PRODUCT_DATA["product"][1]["name"]}
    inventory_page.Check Cart Badge Number    2   

Check Number Of Items Displayed
    [Tags]    inventory
    inventory_page.Check Number Of Items Displayed    6
Sort Products A To Z
    [Tags]    inventory    sorting
    inventory_page.Sort Products By    Name (A to Z)
    inventory_page.Check Sorting    name_asc

Sort Products Z To A
    [Tags]    inventory    sorting
    inventory_page.Sort Products By    Name (Z to A)
    inventory_page.Check Sorting    name_desc

Sort Products Price Low To High
    [Tags]    inventory    sorting
    inventory_page.Sort Products By    Price (low to high)
    inventory_page.Check Sorting    price_asc

Sort Products Price High To Low
    [Tags]    inventory    sorting
    inventory_page.Sort Products By    Price (high to low)
    inventory_page.Check Sorting    price_desc
