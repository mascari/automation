# Automation Exercise
# This test suite automates interactions with the website https://automationexercise.com/.
# The website may display ads during the test run. Two different approaches are suggested to handle this:
# 1. Use the headless interface by uncommenting line 47: "Call Method    ${chrome_options}    add_argument    --headless"
# 2. Set Selenium Speed to 2 and manually close the ad windows during the test run.

*** Settings ***
Library           SeleniumLibrary
Library           Collections

*** Variables ***
${BROWSER}        Chrome
${BASE_URL}       http://automationexercise.com
${PRODUCT_1_NAME}      Men Tshirt
${PRODUCT_2_NAME}      Sleeveless Dress
${PRODUCT_1_VALUE}      400
${PRODUCT_2_VALUE}      1000

*** Test Cases ***
Test 1 - Search Products and Add to Cart
    # Open the browser to the homepage
    Open Browser To Homepage
    # Navigate to the products page
    Navigate To Products Page
    # Verify search bar visibility
    Verify Search Bar Visibility
    # Search for the first product
    Search For Product    ${PRODUCT_1_NAME}
    # Click the search button
    Click Search Button
    # Verify the visibility of the first product
    Verify Product Visibility    ${PRODUCT_1_NAME}
    # Scroll down the page
    Scroll Down Page
    # Click to view the first product
    Click View Product
    # Add the first product to the cart
    Add Product To Cart    ${PRODUCT_1_NAME}
    # Click to continue shopping
    Click Continue Shopping
    # Navigate back to the products page
    Navigate To Products Page
    # Search for the second product
    Search For Product    ${PRODUCT_2_NAME}
    # Click the search button
    Click Search Button
    # Verify the visibility of the second product
    Verify Product Visibility    ${PRODUCT_2_NAME}
    # Scroll down the page
    Scroll Down Page
    # Click to view the second product
    Click View Product
    # Add the second product to the cart
    Add Product To Cart    ${PRODUCT_2_NAME}
    # Click to continue shopping
    Click Continue Shopping
    # Click the cart button
    Click Cart Button
    # Verify that both products are in the cart
    Verify Products In Cart    ${PRODUCT_1_NAME}    ${PRODUCT_2_NAME}
    # Verify the cart total
    Verify Cart Total    ${PRODUCT_1_VALUE}    ${PRODUCT_2_VALUE}

*** Keywords ***
Open Browser To Homepage
    # Set up Chrome options for headless mode
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    # Uncomment the following line to enable headless mode
    # Call Method    ${chrome_options}    add_argument    --headless
    # Create a Chrome WebDriver instance
    Create Webdriver    ${BROWSER}    options=${chrome_options}
    # Navigate to the base URL
    Go To    ${BASE_URL} 
    # Maximize the browser window for better visibility
    Maximize Browser Window
    # Set Selenium speed to 0 for faster test execution
    Set Selenium Speed    2

Navigate To Products Page  
    # Click the link to navigate to the products page
    Click Link    xpath=//a[@href='/products']

Verify Search Bar Visibility
    # Verify that the search bar is visible
    Page Should Contain Element    id=search_product
    
Search For Product
    [Arguments]    ${product}
    # Input the product name into the search bar
    Input Text    id=search_product    ${product}

Click Search Button
    # Click the search button
    Click Button    id=submit_search

Verify Product Visibility
    [Arguments]    ${product}
    # Verify that the product is visible on the page
    Page Should Contain    ${product}

Scroll Down Page
    # Scroll down the page to view more content
    Execute JavaScript    window.scrollBy(0, 200)

Click View Product
    # Click to view the product details
    Click Element    xpath=//*[text()='View Product']

Add Product To Cart
    [Arguments]    ${product}
    # Click the "Add to cart" button for the specified product
    Click Button    //button[normalize-space()='Add to cart']

Click Continue Shopping
    # Click to continue shopping
    Click Button     xpath=//button[normalize-space()='Continue Shopping']

Click Cart Button
    # Click the "Cart" button to view the cart
    Click Link    xpath=//a[normalize-space()='Cart']

Verify Products In Cart
    [Arguments]    @{products}
    # Verify that all specified products are in the cart
    FOR    ${product}    IN    @{products}
        Page Should Contain    ${product}
    END

Verify Cart Total
    [Arguments]    @{products}
    # Verify the total value of the products in the cart
    FOR    ${product}    IN    @{products}
        Page Should Contain    ${product}
    END
    # Calculate the total sum of product values
    ${total_sum}=    Evaluate    ${PRODUCT_1_VALUE} + ${PRODUCT_2_VALUE}
    # Log the result
    Log    It was possible to verify that the two desired products were in the cart and the total value was correct: ${total_sum}.
