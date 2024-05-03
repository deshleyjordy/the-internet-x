*** Settings ***
Documentation    https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#nesting-while-loops
...              //
Library          Browser
Resource         ../../globals/setups/setup.robot

Suite Setup    Setup Browser

*** Variables ***
# Set number of how many elements to add
${count}    ${100}

*** Test Cases ***
Scenario: The user adds ... elements and removes them all
    # Navigate to broken images page
    Click    text=Add/Remove Elements
    Get Text    id=content    contains    Add/Remove Elements

    # Add 'amount' of elements with the button
    Repeat Keyword    ${count} times    Click    //button[@onclick="addElement()"]

    # Count and validate added buttons
    ${totalButtons} =    Get Element Count    //button[@class="added-manually"]
    Should Be Equal As Numbers    ${totalButtons}    ${count}

    # Create new variable to match total buttons
    ${i} =    Set Variable    ${totalButtons}

    # Delete all the elements, from last to first element
    WHILE    ${i} > ${0}
        # The variable in brackets makes it a valid Xpath
        Click    //button[@onclick="deleteElement()"][${i}]
        # Set ${i} minus 1 to start at last element each iteration
        ${i} =    Evaluate    ${i} - 1
    END