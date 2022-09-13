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


Google MFA
    # Open browser as normal usage.
    @{args} =    Create List
    ...    --user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36
    ...    --disable-dev-shm-usage    --no-sandbox
    &{options} =    Create Dictionary    arguments    ${args}
    Open Available Browser    https://accounts.google.com/ServiceLogin
    ...    options=${options}
    # Doesn't work even if you attach to your existing browser and profile.
    # Attach Chrome Browser    9222
    # Go To    https://accounts.google.com/ServiceLogin

    # This gets to a page detecting and blocking automation.
    Input Text When Element Is Visible    id:identifierId    ${SECRETS}[google_usr]
    Click Element When Visible    //span[contains(text(), 'Next')]

    # FIXME: Complete the login process if allowed.
    Use Mfa Secret From Vault    MFA    google_secret
    ${code} =    Get Time Based Otp
    Log To Console    Would fill in code: ${code}
