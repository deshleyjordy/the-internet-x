*** Settings ***
Library    Browser
Resource    ../navigation.resource

*** Keywords ***
Setup Browser
    New Page    ${BASE_URL}
    Get Title    contains    The Internet