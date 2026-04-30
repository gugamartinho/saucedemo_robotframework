*** Settings ***
Resource       ../keywords/common.robot

*** Variables ***
${INVENTORY_ITEM}           css:.inventory_item
${CART_BADGE}               css:.shopping_cart_badge
${SORT_DROPDOWN}            //select[@data-test="product-sort-container"]
${BURGER_MENU}              id:react-burger-menu-btn
${LOGOUT_LINK}              id:logout_sidebar_link
${INVENTORY_ITEM_NAME}      css:.inventory_item_name
${INVENTORY_ITEM_PRICE}     css:.inventory_item_price

*** Keywords ***
Get Inventory Item Count
    ${count}=    Get Element Count    ${INVENTORY_ITEM}
    RETURN    ${count}

Add Item To Cart
    [Arguments]    ${item_name}
    ${item}=    Get WebElement    xpath://div[@class='inventory_item'][.//div[text()='${item_name}']]
    ${button}=    Get WebElement    xpath://div[@class='inventory_item'][.//div[text()='${item_name}']]//button
    Click Element    ${button}

Get Cart Count
    ${count}=    Get Text    ${CART_BADGE}
    RETURN    ${count}

Cart Badge Should Not Be Visible
    Element Should Not Be Visible    ${CART_BADGE}

Sort Products By
    [Arguments]    ${option}
    Select From List By Label    ${SORT_DROPDOWN}    ${option}

Get All Item Names
    ${elements}=    Get WebElements    ${INVENTORY_ITEM_NAME}
    ${names}=    Create List
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Text    ${element}
        Append To List    ${names}    ${text}
    END
    RETURN    ${names}

Get All Item Prices
    ${elements}=    Get WebElements    ${INVENTORY_ITEM_PRICE}
    ${prices}=    Create List
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Text    ${element}
        ${price}=    Evaluate    float('${text}'.replace('$', ''))
        Append To List    ${prices}    ${price}
    END
    RETURN    ${prices}

Items Should Be Sorted Ascending
    ${names}=    Get All Item Names
    ${sorted}=    Evaluate    sorted(${names})
    Should Be Equal    ${names}    ${sorted}

Items Should Be Sorted Descending
    ${names}=    Get All Item Names
    ${sorted}=    Evaluate    sorted(${names}, reverse=True)
    Should Be Equal    ${names}    ${sorted}

Prices Should Be Sorted Ascending
    ${prices}=    Get All Item Prices
    ${sorted}=    Evaluate    sorted(${prices})
    Should Be Equal    ${prices}    ${sorted}

Prices Should Be Sorted Descending
    ${prices}=    Get All Item Prices
    ${sorted}=    Evaluate    sorted(${prices}, reverse=True)
    Should Be Equal    ${prices}    ${sorted}

Logout
    Click Element       ${BURGER_MENU}
    Wait Until Element Is Visible    ${LOGOUT_LINK}
    Click Element       ${LOGOUT_LINK}
