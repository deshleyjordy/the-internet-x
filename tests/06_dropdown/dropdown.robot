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

    # Validate dropdown exists and all available label options
    Get Select Options    id=dropdown    validate    [v["label"] for v in value] == ["Please select an option", "Option 1", "Option 2"]  

    # Validate default selected value
    Get Attribute    //option[@value=""]    selected    ==    selected

    # Select option 2 by label
    Select Options By    id=dropdown    label    Option 2
    
    # Validate that option 2 is selected
    Get Attribute    //option[@value="2"]    selected    ==    selected
    