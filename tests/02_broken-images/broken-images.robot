*** Settings ***
Resource    ../../globals/setups/setup.robot
Library    Browser
Library    RequestsLibrary

Suite Setup    Setup Browser

*** Test Cases ***
Scenario: A user gets a specifiek src attribute from an image
    # Navigate to broken images page
    Click    text=Broken images
    Get Text    id=content    contains    Broken Images

    # Get the attribute from the first image (Xpath starts counting from 1)
    ${imageSrc} =    Get Attribute    //*[@class="example"]//img[1]    src

Scenario: A user checks a specifiek URL to check if the image is NOT available
    # RequestsLibrary: GET to check if image is retrieved
    GET    ${BASE_URL}asdf.jpg    expected_status=404 

Scenario: A user checks all the images of the website to see if it's loaded correctly
    # Navigate to broken images page
    Click    text=Broken images
    Get Text    id=content    contains    Broken Images

    # Get count of all the images on the page
    ${totalImages} =    Get Element Count    //*[@class="example"]//img

    # Xpath starts counting from 1
    FOR    ${i}    IN RANGE    1    ${totalImages}+1
        # Get the attribute from item
        ${imageSrc} =    Get Attribute    //*[@class="example"]//img[${i}]    src

        # For now: just give a warning if an image doesn't give expected status of 200
        Run Keyword And Warn On Failure   GET    ${BASE_URL}${imageSrc}    expected_status=200
    END