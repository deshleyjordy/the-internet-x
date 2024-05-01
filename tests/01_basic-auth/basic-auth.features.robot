*** Settings ***
Resource    basic-auth.steps.resource
Test Teardown    Close Browser

*** Test Cases ***
Scenario: The user logs in to the system with valid credentials for basic authentication
    Given The user logs in with "admin" and "admin" as credentials
    Then The user is logged in to the system

Scenario: The user logs in to the system with invalid password for basic authentication
    Given The user logs in with "admin" and "invalidpassword" as credentials
    Then The user is not authorized to the system