*** Settings ***
Documentation     Automation Test Assignment Central Digital.
Library           SeleniumLibrary


*** Variables ***
${SEARCH BAR}    xpath://input[@data-testid="txt-SearchBar"]
${SEARCH BTN}    btn-searchResultPage
${SEARCH BAR PLACHOLDER}    ค้นหาสินค้า
${CATEGORY URL}    https://www.officemate.co.th/th/furniture
${PRODUCT URL}    https://www.officemate.co.th/th/faber-castell-faber-castell-1423-ballpoint-pen-con1031411
${SEARCH RESULT LABEL}    ผลการค้นหาสำหรับ
${SUGGESTION CONTAINER}    xpath://div[contains(@class,"suggestion_container")]

*** Keywords ***
Open Browser To Home Page     
    [Arguments]    ${BASE URL}    ${BROWSER}     ${SPEED}
    Open Browser    ${BASE URL}    ${BROWSER}    options=add_argument("disable-notifications"); add_argument("window-size=1920,1080")
    Set Selenium Speed    ${SPEED}
    Set Browser Implicit Wait    10s
    Close AD
    
    
Close AD
    [Documentation]    close the ad that apear in the first time
    select frame    xpath://iframe[starts-with(@classname,"sp-fancybox-iframe")]
    Click Element   xpath://div[starts-with(@id,"close-button")]
    unselect frame


Verify search bar visible 
    Element Should Be Visible    ${SEARCH BAR}

Verify search button visible
    Element Should Be Visible    ${SEARCH BTN}

Verify placeholder in search bar
    Element Attribute Value Should Be    ${SEARCH BAR}    placeholder    ${SEARCH BAR PLACHOLDER}


Verify search bar visible in all pages
    go to    ${CATEGORY URL}
    Verify search bar visible
    go to    ${PRODUCT URL}
    Verify placeholder in search bar

Input text and click search
    [Arguments]    ${KEYWORD SEARCH} 
    Click Element    ${SEARCH BAR}
    Input Text        ${SEARCH BAR}    ${KEYWORD SEARCH}
    Click Element      ${SEARCH BTN}
    Page Should Contain   ${SEARCH RESULT LABEL}

Input text and press Enter
    [Arguments]    ${KEYWORD SEARCH} 
    Click Element    ${SEARCH BAR}
    Input Text        ${SEARCH BAR}    ${KEYWORD SEARCH}
    Press Keys    ${SEARCH BAR}    ENTER
    Page Should Contain        ${SEARCH RESULT LABEL} "${KEYWORD SEARCH}"

Validate search results
    [Arguments]    ${KEYWORD SEARCH}
    Clear Element Text    ${SEARCH BAR}
    Input text and click search    ${KEYWORD SEARCH}
    ${count} =  SeleniumLibrary.Get Element Count    xpath://div[@data-testid="pnl-productGrid"]//div//div//div//div//div//div//h2//a[contains(text(),${KEYWORD SEARCH})]
    Should Be True  ${count} >= 1


Validate suggestion container have Categories and Products
    [Arguments]    ${KEYWORD SEARCH}     ${Categories}    ${Products}    
    Click Element    ${SEARCH BAR}
    Input Text        ${SEARCH BAR}    ${KEYWORD SEARCH}
    Wait Until Element Is Visible    ${SUGGESTION CONTAINER}
    SeleniumLibrary.Element Text Should Be    ${SUGGESTION CONTAINER}/child::div[1]    ${Categories}
    SeleniumLibrary.Element Text Should Be    ${SUGGESTION CONTAINER}/child::div[3]    ${Products}

Validate suggestion container Product section have name image and price
    [Arguments]    ${KEYWORD SEARCH} 
    Click Element    ${SEARCH BAR}
    Input Text        ${SEARCH BAR}    ${KEYWORD SEARCH}
    Wait Until Element Is Visible    ${SUGGESTION CONTAINER}
    Element Should Be Visible    ${SUGGESTION CONTAINER}/child::div[last()]//a//img    #Check for image
    Element Should Be Visible    ${SUGGESTION CONTAINER}/child::div[last()]//div[1]    #Check for name
    Element Should Be Visible    ${SUGGESTION CONTAINER}/child::div[last()]//div[2]    #Check for price


Navigate to categories by keyword search
    [Arguments]    ${KEYWORD SEARCH} 
    Click Element    ${SEARCH BAR}
    Input Text        ${SEARCH BAR}    ${KEYWORD SEARCH}
    Wait Until Element Is Visible    ${SUGGESTION CONTAINER}
    ${category text}    Get Text    ${SUGGESTION CONTAINER}/child::div[2]//div[1]
    Click Element    ${SUGGESTION CONTAINER}/child::div[2]//div[1]
    Wait Until Element Is Visible    xpath://h1[@id="txt-subCategories-name"]
    ${category result}     Get Text     xpath://h1[@id="txt-subCategories-name"]
    Should Contain    ${category text}    ${category result}


Navigate to product details by keyword search
    [Arguments]    ${KEYWORD SEARCH} 
    Click Element    ${SEARCH BAR}
    Input Text        ${SEARCH BAR}    ${KEYWORD SEARCH}
    Wait Until Element Is Visible    ${SUGGESTION CONTAINER}
    ${product name}    Get Text    ${SUGGESTION CONTAINER}/child::div[last()]//div[1]
    Click Element    ${SUGGESTION CONTAINER}/child::div[last()]//div[1]
    Wait Until Element Is Visible        xpath://h1[starts-with(@id,"lbl-ProductHeader-Name")]
    ${product deatis name}     Get Text     xpath://h1[starts-with(@id,"lbl-ProductHeader-Name")]
    Should Contain    ${product name}     ${product deatis name}
