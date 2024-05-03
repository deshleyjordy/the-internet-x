*** Settings ***
Documentation    https://marketsquare.github.io/robotframework-browser/Browser.html#Get%20Table%20Cell%20Element
...              //
Library          Browser

Resource         ../../globals/setups/setup.robot
Suite Setup      Setup Browser

*** Test Cases ***
Scenario: A user deletes a specific row based on a text
    Navigate to Challenging DOM
    
    # Set variable to search for
    ${text} =    Set Variable    Iuvaret7

    # Xpath to get to this specific button
    Click    //*[contains(text(), "${text}")]//ancestor::tr//a[@href="#delete"]

Scenario: Verify information based on a specific column and row
    Navigate to Challenging DOM

    # Set a Xpath to find the correct table
    ${table} =    Set Variable    //*[@id="content"]//table

    # Get the table elements
    ${element} =    Get Table Cell Element    ${table}    "Amet"    "Iuvaret7"

    # Validate if this is correct
    Get Text    ${element}    ==    Consequuntur7

*** Keywords ***
Navigate to Challenging DOM
    Click    text=Challenging DOM
    Get Text    id=content    contains    Challenging DOM