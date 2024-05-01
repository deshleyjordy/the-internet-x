*** Settings ***
Library    Browser

*** Keywords ***
Setup Browser
    New Page    https://the-internet.herokuapp.com/
    Get Title    contains    The Internet