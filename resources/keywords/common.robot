*** Settings ***
Library     SeleniumLibrary
Library     Collections
Variables   ../variables/variables.py

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
    Capture Page Screenshot
    Close Browser