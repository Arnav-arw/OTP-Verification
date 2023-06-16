# OTP-Verification

## Project made for SportsTribe

In this project, I am using Firebase SDK for authorisation. I am sending my phone number and getting the OTP and then verifying it via Firebase verification method.
The app supports suggestions for phone number, auto fill for OTP and light/dark theme.

## Some Important Code Snippets: 

### 1. For Auto fill of OTP

In AppDelegate, to listen for OTP in backgroud.
```
func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) async -> UIBackgroundFetchResult {
    return .noData
}
```

In View, this code helps in updating the UI and filling the textfield properly.
```
for index in 0..<6 {
    if value[index].count == 6 {
        DispatchQueue.main.async {
            otpModel.otpText = value[index]
            otpModel.otpFields[index] = ""

            for item in otpModel.otpText.enumerated() {
                otpModel.otpFields[item.offset] = String(item.element)
            }
        }
        return
    }
}
```

### 2. For Firebase

In AppDelegate to init it. 
```
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey:Any]? = nil) -> Bool {
    FirebaseApp.configure ()
    return true
}
```

In ViewModel, to send OTP.
```
let result = try await PhoneAuthProvider.provider().verifyPhoneNumber("+\(code)\(number)", uiDelegate: nil)
```

In ViewModel, to verify OTP.
```
let credentail = PhoneAuthProvider.provider().credential(withVerificationID: verificationCode, verificationCode: otpText)
```

## Demo Video

https://github.com/Arnav-arw/OTP-Verification/assets/88189594/7c4b747f-44fb-477f-8251-0e98383bbc87




