*** Settings ***
Library    SeleniumLibrary
Library    Collections

*** Variables ***
${INVENTORY_ITEM}           //div[@class='inventory_item']
${CART_BADGE}               css:.shopping_cart_badge
${SORT_DROPDOWN}            //select[@data-test="product-sort-container"]
${INVENTORY_ITEM_NAME}      css:.inventory_item_name
${INVENTORY_ITEM_PRICE}     css:.inventory_item_price

*** Keywords ***

Check Number Of Items Displayed
    [Arguments]    ${expected_count}
    ${count}=    Get Element Count    ${INVENTORY_ITEM}
    Should Be Equal As Integers    first=${count}    second=${expected_count}

Add Item To Cart
    [Arguments]    ${item_name}
    ${item}=    Get WebElement    ${INVENTORY_ITEM}\[.//div[text()='${item_name}']]
    ${button}=    Get WebElement    ${INVENTORY_ITEM}\[.//div[text()='${item_name}']]//button
    Click Element    ${button}

Check Cart Badge Number
    [Arguments]    ${expected_count}
    ${count}=    Get Text    ${CART_BADGE}
    Should Be Equal As Integers     first=${count}    second=${expected_count}

Check Cart Badge Should Not Be Visible
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

Check Sorting
    [Arguments]    ${SORT_TYPE}
    Run Keyword If    '${SORT_TYPE}' == 'name_asc'        Check Items Should Be Sorted Ascending
    ...    ELSE IF    '${SORT_TYPE}' == 'name_desc'       Check Items Should Be Sorted Descending
    ...    ELSE IF    '${SORT_TYPE}' == 'price_asc'       Check Prices Should Be Sorted Ascending
    ...    ELSE IF    '${SORT_TYPE}' == 'price_desc'      Check Prices Should Be Sorted Descending
    ...    ELSE    Fail    Invalid sorting type: ${SORT_TYPE}


Check Items Should Be Sorted Ascending
    ${names}=    Get All Item Names
    ${sorted}=    Evaluate    sorted(${names})
    Should Be Equal    ${names}    ${sorted}

Check Items Should Be Sorted Descending
    ${names}=    Get All Item Names
    ${sorted}=    Evaluate    sorted(${names}, reverse=True)
    Should Be Equal    ${names}    ${sorted}

Check Prices Should Be Sorted Ascending
    ${prices}=    Get All Item Prices
    ${sorted}=    Evaluate    sorted(${prices})
    Should Be Equal    ${prices}    ${sorted}

Check Prices Should Be Sorted Descending
    ${prices}=    Get All Item Prices
    ${sorted}=    Evaluate    sorted(${prices}, reverse=True)
    Should Be Equal    ${prices}    ${sorted}

Check Inventory Page Is Loaded
    Wait Until Location Contains    inventory.html
    Location Should Contain    inventory.html