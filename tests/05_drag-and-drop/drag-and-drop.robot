*** Settings ***
Documentation    //
...              Retrieve the coordinates in the browser console: document.getElementById('column-a').getBoundingClientRect()
Library          Browser

Resource         ../../globals/setups/setup.robot
Suite Setup      Setup Browser

*** Test Cases ***
Scenario: The user drags box A in to box B so the boxes switches
    # Navigate
    Click    text=Drag and Drop
    Get Text    id=content    contains    Drag and Drop

    # Validate boxes
    Get Text    //*[@id="column-a"]//header    should be    A
    Get Text    //*[@id="column-b"]//header    should be    B
    Take Screenshot

    # Drag box A into box B
    Drag And Drop    id=column-a    id=column-b

    # Validate boxes switched
    Get Text    //*[@id="column-a"]//header    should be    B
    Get Text    //*[@id="column-b"]//header    should be    A
    Take Screenshot