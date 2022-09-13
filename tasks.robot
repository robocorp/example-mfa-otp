*** Settings ***
Documentation       Use MFA with Microsoft, Google and GitHub authentication.

Library    RPA.Browser.Selenium
Library    RPA.MFA
Library    RPA.Robocorp.Vault

Suite Setup    Init Secrets


*** Variables ***
${SECRETS}


*** Keywords ***
Init Secrets
    ${secrets} =    Get Secret    MFA
    Set Global Variable    ${SECRETS}    ${secrets}


*** Tasks ***
Microsoft MFA
    # Login with username and password.
    Open Available Browser    https://mysignins.microsoft.com/
    Input Text When Element Is Visible    name:loginfmt    ${SECRETS}[microsoft_usr]
    ${submit_locator} =    Set Variable    idSIButton9
    Click Button When Visible    ${submit_locator}
    ${password_locator} =    Set Variable    passwd
    Wait Until Element Is Visible    ${password_locator}
    Input Password    ${password_locator}    ${SECRETS}[microsoft_pwd]
    Click Button When Visible    ${submit_locator}

    # Proceed to OTP input.
    Click Element When Visible    signInAnotherWay
    # Click Element If Visible    idA_SAASTO_SendCode
    Click Element When Visible    //div[contains(text(), 'verification code')]

    # Input OTP.
    Use Mfa Secret From Vault    MFA    microsoft_secret
    ${code} =    Get Time Based Otp
    Input Text When Element Is Visible    name:otc    ${code}
    Click Button When Visible    idSubmit_SAOTCC_Continue

    # Remember sign-in.
    Click Element When Visible    //span[contains(text(), 'show this')]
    Click Button When Visible    ${submit_locator}

    Go To    https://outlook.office.com/mail/


GitHub MFA
    # Fill in username and password, then press the submit button.
    Open Available Browser    https://github.com/login
    Input Text When Element Is Visible    name:login    ${SECRETS}[github_usr]
    ${password_locator} =    Set Variable    name:password
    Wait Until Element Is Visible    ${password_locator}
    Input Password    ${password_locator}    ${SECRETS}[github_pwd]
    Click Element When Visible    name:commit

    # Now select and complete two-factor authentication.
    Click Element When Visible    //a[contains(text(), 'two-factor')]
    Use Mfa Secret From Vault    MFA    github_secret
    ${code} =    Get Time Based Otp
    # This automatically submits the code.
    Input Text When Element Is Visible    name:otp    ${code}
