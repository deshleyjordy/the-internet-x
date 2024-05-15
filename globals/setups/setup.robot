*** Settings ***
Library    Browser
Resource    ../navigation.resource

*** Keywords ***
Setup Browser
    New Page    ${BASE_URL}
    Get Title    contains    The Internet
    Set Browser Timeout    30s

Setup Restful Booker
    New Page    ${RESTFUL_BOOKER_URL}
    Get Title    contains    Welcome to Restful-Booker
    Set Browser Timeout    30s