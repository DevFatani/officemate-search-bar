*** Settings ***
Documentation     Automation Test Assignment Central Digital .
Library           SeleniumLibrary
Resource    ../Resources/HomePage.robot

Suite Setup    Open Browser To Home Page    ${BASE URL}    ${BROWSER}    ${SPEED}
Suite Teardown    Close Browser

*** Variables ***
${BASE URL}      https://www.officemate.co.th/th
${BROWSER}        headlesschrome
${SPEED}       1s
${KEYWORD SEARCH}    หนังสือเรียนภาษาไทย


*** Test Cases ***

Check the search bar visible and on the top of the website 
    [Documentation]    check the search bar on the top view
    Verify search bar visible 

Check the search bar has search button
    [Documentation]    verify the search bar has search button user can click to search
    Verify search button visible

Verify placeholder text added on input field with TH when the language is TH
    [Documentation]    check placeholder inside search bar
    Verify placeholder in search bar

Verify on all pages where the Search bar is visible and be on top page
    [Documentation]     Check of some pages and make sure the search bar always apear in all pages
    Verify search bar visible in all pages

Input text in search field and click on search button
    [Documentation]    Check the search button functionality
    Input text and click search    ${KEYWORD SEARCH}

Input text in search field and press "Enter" on the keyboard
    [Documentation]    Check the search Enter on the keyboard functionality
    Input text and press Enter    ${KEYWORD SEARCH}

Validate search results displayed should be relevant to the search keyword in Thai
    [Documentation]    Check the relevant results when user search for a product in Thai language
    Validate search results    ${KEYWORD SEARCH}


Check the suggestion dropdown list must have Categories and Products section in TH
    [Documentation]    Check that the dropdown list suggestion have 2 sections categories and products
    Validate suggestion container have Categories and Products    ${KEYWORD SEARCH}    ประเภท    ผลิตภัณฑ์


Check the suggestion dropdown list categories section have Product name image and price
    [Documentation]    Check in product section show the product name, image and price
    Validate suggestion container Product section have name image and price    ${KEYWORD SEARCH}


Select from suggestion list category
    [Documentation]    user can select from suggestion list and navigate to selected category
    Navigate to categories by keyword search    ${KEYWORD SEARCH}


Navigate to product details by keyword search
    [Documentation]    user can select from suggestion list and navigate to selected product
    Navigate to product details by keyword search    ${KEYWORD SEARCH}
