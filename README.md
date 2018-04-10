# Swift-Firebase-VIPER-Architecture


This repository contains a detailed sample app that implements VIPER architecture in iOS using libraries and frameworks like Firebase-facebook-login,Mobile veriifcation

Just fork, clone, build, run and learn VIPER architecture for IOS.

git clone https://github.com/ashishagradeve/Swift-Firebase-VIPER-Architecture.git

cd Swift-Firebase-VIPER-Architecture

pod install

open Swift-Firebase-VIPER-Architecture.xcworkspace

# Before you begin
1.	Add Firebase to your iOS project. Include the following pods in your Podfile:
pod 'Firebase/Auth'
2.	If you haven't yet connected your app to your Firebase project, do so from the Firebase console.
3.	On the Facebook for Developers site, get the App ID and an App Secret for your app.
4.	Enable Facebook Login:
a.	In the Firebase console, open the Auth section.
b.	On the Sign in method tab, enable the Facebook sign-in method and specify the App ID and App Secret you got from Facebook.
c.	Then, make sure your OAuth redirect URI (e.g. my-app-12345.firebaseapp.com/__/auth/handler) is listed as one of your OAuth redirect URIs in your Facebook app's settings page on the Facebook for Developers site in the Product Settings > Facebook Login config.

# Enable Phone Number sign-in for your Firebase project
To sign in users by SMS, you must first enable the Phone Number sign-in method for your Firebase project:
1.	In the Firebase console, open the Authentication section.
2.	On the Sign-in Method page, enable the Phone Number sign-in method.
Set up reCAPTCHA verification

# To enable the Firebase SDK to use reCAPTCHA verification:

1.	Add custom URL schemes to your Xcode project:
a.	Open your project configuration: double-click the project name in the left tree view. Select your app from the TARGETS section, then select the Info tab, and expand the URL Types section.
b.	Click the + button, and add a URL scheme for your reversed client ID. To find this value, open theGoogleService-Info.plist configuration file, and look for the REVERSED_CLIENT_ID key. Copy the value of that key, and paste it into the URL Schemes box on the configuration page. Leave the other fields blank.
When completed, your config should look something similar to the following (but with your application-specific values):
 

