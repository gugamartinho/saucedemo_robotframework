*** Variables ***
# ============================================================
# Global Variables
# ============================================================

# URLs
${BASE_URL}             https://www.saucedemo.com
${INVENTORY_URL}        ${BASE_URL}/inventory.html
${CART_URL}             ${BASE_URL}/cart.html
${CHECKOUT_STEP1_URL}   ${BASE_URL}/checkout-step-one.html
${CHECKOUT_STEP2_URL}   ${BASE_URL}/checkout-step-two.html
${CHECKOUT_DONE_URL}    ${BASE_URL}/checkout-complete.html

# Global Locators
${PAGE_LOGO}               css:.login_logo

# Credentials
${VALID_USER}           standard_user
${LOCKED_USER}          locked_out_user
${PERF_GLITCH_USER}     performance_glitch_user
${PASSWORD}             secret_sauce

# Customer data
${FIRST_NAME}           David
${LAST_NAME}            Martinho
${POSTAL_CODE}          2000-105

# Browser settings
${BROWSER}              chrome
${HEADLESS}             false

# Timeouts
${DEFAULT_TIMEOUT}      10s
${SHORT_TIMEOUT}        5s
