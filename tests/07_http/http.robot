*** Settings ***
Documentation    //
...              Examples of pages that returns certain status codes: https://the-internet.herokuapp.com/status_codes
...              //
...              For other operations: https://restful-booker.herokuapp.com
Library          Browser
Library          Collections
Library          JSONLibrary

Resource         ../../globals/setups/setup.robot

*** Test Cases ***
Scenario: A GET request that returns a status code 200 OK
    [Setup]    Setup Browser
    # Perform the HTTP request
    ${response} =    Http    ${BASE_URL}/status_codes/200

    # Validate the response status and convert to integer
    Should Be Equal    ${response.status}    ${200}
    Should Be Equal    ${response.statusText}    OK    ignore_case=True

Scenario: A GET request that returns a status code 301 Moved Permanently
    [Setup]    Setup Browser
    ${response} =    Http    ${BASE_URL}/status_codes/301

    Should Be Equal    ${response.status}    ${301}
    Should Be Equal    ${response.statusText}    Moved Permanently    ignore_case=True

Scenario: A GET request that returns a status code 404 Not found
    [Setup]    Setup Browser
    ${response} =    Http    ${BASE_URL}/status_codes/404

    Should Be Equal    ${response.status}    ${404}
    Should Be Equal    ${response.statusText}    Not Found    ignore_case=True

Scenario: A GET request that returns a status code 500 Internal Server Error
    [Setup]    Setup Browser
    ${response} =    Http    ${BASE_URL}/status_codes/500

    Should Be Equal    ${response.status}    ${500}
    Should Be Equal    ${response.statusText}    Internal Server Error    ignore_case=True

Scenario: Perform a POST request to add a booking and validate with a GET request
    [Setup]    Setup Restful Booker
    # Headers in a dictionary. Be aware: names are case-sensitive
    ${headers} =    Create Dictionary
    ...    Content-Type=application/json
    ...    accept=application/json
    
    # A readable json on multiple lines using catenate
    ${json} =    Catenate
    ...    {
    ...    "firstname": "Koji",
    ...    "lastname": "Kin",
    ...    "totalprice": 130,
    ...    "depositpaid": true,
    ...    "bookingdates": {
    ...        "checkin": "2024-06-15",
    ...        "checkout": "2024-06-16"
    ...        },
    ...    "additionalneeds": "Bones"
    ...    }

    # Get the response from the POST request
    ${response} =    Http    url=${RESTFUL_BOOKER_URL}/booking    method=POST    body=${json}    headers=${headers}

    # Validate the POST request went ok
    Should Be Equal    ${response.status}    ${200}

    # Get number of bookingId with JSONLibrary
    ${bookingId} =    Get Value From Json    ${response}    $..bookingid

    # Validate if booking number is correct (use [0] to remove the brackets from the returned value)
    ${getBooking} =    Http    url=${RESTFUL_BOOKER_URL}/booking/${bookingId[0]}

    # Validate with extended variable syntax
    Should Be Equal    ${getBooking.status}    ${200}
    Should Be Equal    ${getBooking.body.firstname}    Koji
    Should Be Equal    ${getBooking.body.bookingdates.checkin}    2024-06-15

    # Other way to validate with help of JSONLibrary to access a deep nested value
    ${checkout} =    Get Value From Json    ${response}    $..checkout
    Should Be Equal    ${checkout[0]}    2024-06-16

Scenario: Just another example of creating a dictionary/json
    [Documentation]    Create a body with dictionaries. This fails to talk to the API because dictionary default is single quote instead of double quotes
    ${bookingdates} =    Create Dictionary
    ...    checkin=2024-06-15
    ...    checkout=2024-06-16
    ${json} =    Create Dictionary
    ...    firstname=Marco
    ...    lastname=Polo
    ...    totalprice=130
    ...    depositpaid=true
    ...    bookingdates=${bookingdates}
    ...    additionalneeds=lunch

    Log    ${json}