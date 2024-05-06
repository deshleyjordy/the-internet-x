*** Settings ***
Documentation    //
Library          Browser
Library          Collections
Library    Dialogs

Resource         ../../globals/setups/setup.robot
Suite Setup      Setup Browser

*** Test Cases ***
Scenario: A user selects an option from a dropdown menu
    # Navigate
    Click    text=Dropdown
    Get Text    id=content    contains    Dropdown List

    # Validate dropdown exists and options
    Get Select Options    id=dropdown    validate    [v["label"] for v in value] == ["Please select an option", "Option 1", "Option 2"]  

    # Select option 2 by value
    Select Options By    id=dropdown    value    2
    
    # Validate that option 2 is selected somehow
     