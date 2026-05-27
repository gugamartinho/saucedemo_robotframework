*** Settings ***
Library         SeleniumLibrary
Library         Collections
Library         JSONLibrary
Variables       ../variables/variables.py

*** Variables ***
${PAGE_LOGO}       css:.login_logo
${BURGER_MENU}     id:react-burger-menu-btn
${LOGOUT_LINK}     id:logout_sidebar_link
${SHOPPING_CART_LINK}    css:[data-test="shopping-cart-link"]

*** Keywords ***
Open Browser And Go To Login Page
    ${options}=    Evaluate
    ...    sys.modules['selenium.webdriver'].ChromeOptions()
    ...    sys
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    --window-size\=1280,800
    Call Method    ${options}    add_experimental_option
    ...    prefs
    ...    ${{ {"credentials_enable_service": False, "profile.password_manager_enabled": False, "profile.password_manager_leak_detection": False} }}
    Run Keyword If    '${HEADLESS}' == 'true'
    ...    Call Method    ${options}    add_argument    --headless
    Create Webdriver    Chrome    options=${options}
    Set Selenium Timeout    ${DEFAULT_TIMEOUT}
    Go To    ${BASE_URL}
    Wait Until Element Is Visible    ${PAGE_LOGO}    timeout=5s

Close Browser Session
    Run Keyword If Test Failed    Capture Page Screenshot
    Close Browser

Logout
    Click Element       ${BURGER_MENU}
    Wait Until Element Is Visible    ${LOGOUT_LINK}
    Click Element       ${LOGOUT_LINK}

Load JSON Fixture Data
    [Arguments]    ${FOLDER_NAME}    ${FILE_NAME}    ${VAR_NAME}
    ${PATH}=    Catenate    ${EXECDIR}${/}resources${/}fixtures${/}${FOLDER_NAME}${/}${FILE_NAME}.json
    ${DATA_FIXTURE}=    Load JSON From File    ${PATH}
    Set Suite Variable    ${${VAR_NAME}}    ${DATA_FIXTURE}

Open Shopping Cart    
    Click Element    ${SHOPPING_CART_LINK}
    Wait Until Location Contains    cart.html