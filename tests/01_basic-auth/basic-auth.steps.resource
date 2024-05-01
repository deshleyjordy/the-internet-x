*** Settings ***
Resource    basic-auth.helpers.resource

*** Keywords ***
The user logs in with "${username}" and "${password}" as credentials
    inputHttpCredentials    ${username}    ${password}

The user is logged in to the system
    validateLogInSucces

The user is not authorized to the system
    validateNotAuthorized