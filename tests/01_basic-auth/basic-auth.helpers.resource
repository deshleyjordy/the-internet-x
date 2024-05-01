*** Settings ***
Documentation    I tried using the special variable syntax, 'example as literal', because this was the only thing that worked
...              https://forum.robotframework.org/t/secureauth-sign-in-pop-up-how-to-handle/757/5
...              https://marketsquare.github.io/robotframework-browser/Browser.html#Close%20Browser
...        	     //
...              Set Browser Timeout is added when creating a new page, this seems to work according to the documentation, still figuring out why it doesn't work with the default
...              https://marketsquare.github.io/robotframework-browser/Browser.html#Set%20Browser%20Timeout
...              //
Library    Browser

*** Variables ***
${contentConfirmation}    id=content
${contentNotAuthorized}    css=body

*** Keywords ***
inputHttpCredentials
    [Arguments]    ${username}    ${password}
    # Value for browser is optional, but more readable when switching to firefox/webkit
    New Browser    browser=chromium

    # Direct assignment of values or variables as 'httpCredentials' is not allowed. Use special variable syntax ($var instead of ${var}) to prevent variable values from being spoiled.
    New Context    httpCredentials={'username': '$username', 'password': '$password'}
    
    # Set a longer browser timeout than the default (fails now and then)
    Set Browser Timeout    30s
    New Page    https://the-internet.herokuapp.com/basic_auth

validateLogInSucces
    # Validate confirmation that user is logged in correctly
    Get Text    ${contentConfirmation}    contains    Congratulations! You must have the proper credentials.

validateNotAuthorized
    # Validate error not authorized
    Get Text    ${contentNotAuthorized}    contains    Not authorized