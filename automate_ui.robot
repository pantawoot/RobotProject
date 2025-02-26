*** Settings ***
Library  SeleniumLibrary
Library  Collections 

*** Variables ***
${URL}              https://www.saucedemo.com/
${BROWSER}          chrome
${USERNAME}         standard_user
${PASSWORD}         secret_sauce

# Locators (ใช้ CSS Selectors แทน XPath)
${USER_FIELD}       css=#user-name
${PASS_FIELD}       css=#password
${LOGIN_BTN}        css=#login-button
${LOGOUT_MENU_BTN}  css=#react-burger-menu-btn
${LOGOUT_BTN}       css=#logout_sidebar_link
${CART_ICON}        css=.shopping_cart_link

# Locators for Products
${PRODUCTS}         css=.inventory_item
${ITEM_NAMES}       css=.inventory_item_name
${ADD_TO_CART_BTN}  css=.btn_inventory

*** Test Cases ***
Login and Add T-Shirts to Cart
    Open Browser  ${URL}  ${BROWSER}
    Input Text    ${USER_FIELD}  ${USERNAME}
    Input Text    ${PASS_FIELD}  ${PASSWORD}
    Click Button  ${LOGIN_BTN}
    Wait Until Page Contains Element  ${CART_ICON}  timeout=5s
    Capture Page Screenshot

    # Add only T-Shirts to cart
    Add T-Shirts To Cart

    Click Element  ${CART_ICON}
    Capture Page Screenshot

    [Teardown]  Close Browser

*** Keywords ***
Add T-Shirts To Cart
    ${found_tshirts}=  Create List
    ${not_found_items}=  Create List
    
    ${product_elements}=  Get WebElements  ${PRODUCTS}
    
    FOR  ${product_element}  IN  @{product_elements}
        ${name}=  Get Text  css=.inventory_item_name
        IF  'T-Shirt' in '${name}'
            ${button}=  Get WebElement  css=.btn_inventory
            Click Button  ${button}
            Append To List  ${found_tshirts}  ${name}  # ✅ ใช้ Append To List แทน List Append
        ELSE
            Append To List  ${not_found_items}  ${name}  # ✅ ใช้ Append To List แทน List Append
        END
    END
    
    Log  T-Shirts added to cart: ${found_tshirts}
    Log  Other products skipped: ${not_found_items}
