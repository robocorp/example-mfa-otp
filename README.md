# Automating Multi-Factor Authentication (MFA)

With the `RPA.MFA` wrapping [pyotp](https://pypi.org/project/pyotp/) library, you can generate one-time passwords to sign in to services and sites that enforce multi-factor authentication.

The common setup flow is as follows:

1. Login into the web platform as usual, then go to security settings and register a new authenticator app (as you normally do with Google Authenticator or Authy).
1. Proceed throughout the instructions and choose "different auth app" if such an option is available.
1. You'll get to a QR code that contains a secret key. 
1. Store the secret securely in the Robocorp Control Room Vault.
1. Scanning the QR code with your mobile app will enable you to finish the registration process quickly.
1. Finish registration by entering the 6-digit code obtained with your smartphone or the `Get Time/Counter Based Otp` keyword.

Now you should be able to authenticate with your usual credentials and the immediately requested OTP without any manual intervention, fully automated!

## Examples

### Microsoft

https://mysignins.microsoft.com/security-info

1. Add a sign-in method ![Add sign-in method](https://github.com/robocorp/example-mfa-otp/raw/master/devdata/screens/ms1.png)
1. Authenticator app ![Authenticator app](https://github.com/robocorp/example-mfa-otp/raw/master/devdata/screens/ms2.png)
1. QR code and secret ![QR code and secret](https://github.com/robocorp/example-mfa-otp/raw/master/devdata/screens/ms3.png)
1. Code confirmation ![Code confirmation](https://github.com/robocorp/example-mfa-otp/raw/master/devdata/screens/ms4.png)

### GitHub

https://github.com/login

1. Configure authenticator app ![Configure authenticator app](https://github.com/robocorp/example-mfa-otp/raw/master/devdata/screens/gh1.png)
1. App setup ![App setup](https://github.com/robocorp/example-mfa-otp/raw/master/devdata/screens/gh2.png)
1. QR code and secret ![QR code and secret](https://github.com/robocorp/example-mfa-otp/raw/master/devdata/screens/gh3.png)

### Google

https://accounts.google.com/ServiceLogin

1. 2-Step Verification ![2-Step Verification](https://github.com/robocorp/example-mfa-otp/raw/master/devdata/screens/go1.png)
1. Authenticator app ![Authenticator app](https://github.com/robocorp/example-mfa-otp/raw/master/devdata/screens/go2.png)
1. Change authenticator ![Change authenticator](https://github.com/robocorp/example-mfa-otp/raw/master/devdata/screens/go3.png)
1. QR code ![QR code](https://github.com/robocorp/example-mfa-otp/raw/master/devdata/screens/go4.png)
1. QR secret ![QR code and secret](https://github.com/robocorp/example-mfa-otp/raw/master/devdata/screens/go5.png)
