*** Settings ***
Resource        ../resources/keywords/common.robot
Resource        ../resources/pages/login_page.robot
Resource        ../resources/pages/inventory_page.robot


Test Setup     Run Keywords
...    Open Browser And Go To Login Page    AND
...    Login As Valid User

Test Teardown  Close Browser

*** Test Cases ***

Display 6 Products
    [Tags]    inventory    smoke
    ${count}=    Get Inventory Item Count
    Should Be Equal As Integers    ${count}    6

Add Item To Cart
    [Tags]    inventory    cart
    Add Item To Cart    Sauce Labs Backpack
    ${count}=    Get Cart Count
    Should Be Equal    ${count}    1

Add Multiple Items To Cart
    [Tags]    inventory    cart
    Add Item To Cart    Sauce Labs Backpack
    Add Item To Cart    Sauce Labs Bike Light
    ${count}=    Get Cart Count
    Should Be Equal    ${count}    2

Sort Products A To Z
    [Tags]    inventory    sorting
    Sort Products By    Name (A to Z)
    Items Should Be Sorted Ascending

Sort Products Z To A
    [Tags]    inventory    sorting
    Sort Products By    Name (Z to A)
    Items Should Be Sorted Descending

Sort Products Price Low To High
    [Tags]    inventory    sorting
    Sort Products By    Price (low to high)
    Prices Should Be Sorted Ascending

Sort Products Price High To Low
    [Tags]    inventory    sorting
    Sort Products By    Price (high to low)
    Prices Should Be Sorted Descending

Logout Successfully
    [Tags]    inventory    smoke
    Logout
    Wait Until Location Is    ${BASE_URL}/
    #Location Should Be    ${BASE_URL}/
