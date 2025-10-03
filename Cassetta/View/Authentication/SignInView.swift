//
//  SignIn.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 8/18/25.
//


import FirebaseAuth
import SwiftUI
import FirebaseAppCheck
import FirebaseCore

struct SignInView: View {
    @State private var phoneNumber: String = ""
    @State private var verificationID: String?
    @State private var verificationCode: String = ""
    @State private var isVerificationSent: Bool = false
    @State private var isAuthenticated: Bool = false
    @State private var errorMessage: String?

    @FocusState private var isPhoneFieldFocused: Bool
    @FocusState private var isCodeFieldFocused: Bool

    var body: some View {
        VStack {
            if isAuthenticated {
                ContentView()

            } else {
                if !isVerificationSent {
                    TextField("Phone number", text: $phoneNumber)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .keyboardType(.phonePad)
                        .focused($isPhoneFieldFocused)
                        .onSubmit {
                            isPhoneFieldFocused = false
                        }

                    Button(action: sendVerificationCode) {
                        Text("Send Verification Code")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()

                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                } else {
                    TextField("Verification code", text: $verificationCode)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .focused($isCodeFieldFocused)
                        .onSubmit {
                            isCodeFieldFocused = false
                        }

                    Button(action: verifyCode) {
                        Text("Verify Code")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()

                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                }
            }
        }
        .animation(.default, value: isVerificationSent)
        .padding()
    }

//    MARK: send verification

    private func sendVerificationCode() {
        dumpFirebaseOptions()

            // Log App Check token right before Firebase work
            AppCheck.appCheck().token(forcingRefresh: true) { token, err in
                if let err = err { print("3BUG: AppCheck error: \(err)"); return }
                print("✅3BUG: AppCheck token string len=\(token?.token.count ?? 0)")
                printJWT("3BUG: AppCheck", token?.token)
            }
        
        let phoneNumber = self.phoneNumber
        let phoneNumberWithCountryCode = "+1\(phoneNumber)" // Replace "+1" with the country code if needed

        Auth.auth().languageCode = "en"
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumberWithCountryCode, uiDelegate: nil) { verificationID, error in
                if let error = error as NSError? {
                    self.errorMessage = "3BUG: 1Error: \(error.localizedDescription) \n"
                    print("3BUG: Firebase Auth error: \(error.code) - \(error.localizedDescription)")
                      print("3BUG: UserInfo: \(error.userInfo)")
                    print("3BUG: Underlying error: \(String(describing: error.userInfo["NSUnderlyingError"]))")
                    return
                }
                self.verificationID = verificationID
                self.isVerificationSent = true
                self.errorMessage = nil

                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                
                print("3BUG: ✅ Verification ID: \(verificationID ?? "none")")
            }
    }

//    MARK: verify code

    private func verifyCode() {
        guard let verificationID = verificationID else {
            errorMessage = "Verification ID is missing."
            return
        }

        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode
        )

//        TEST
        Auth.auth().signIn(with: credential) { _, error in
            if let error = error {
                let authError = error as NSError
                if authError.code == AuthErrorCode.secondFactorRequired.rawValue {
                    // The user is a multi-factor user. Second factor challenge is required.
                    let resolver = authError
                        .userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
                    var displayNameString = ""
                    for tmpFactorInfo in resolver.hints {
                        displayNameString += tmpFactorInfo.displayName ?? ""
                        displayNameString += " "
                    }

                } else {
                    self.errorMessage = "3BUG: 2Error: \(error.localizedDescription)"
                    return
                }
                // ...
                return
            }
            self.isAuthenticated = true
            self.errorMessage = nil
        }

//        END: TEST
    }
    
//    TEST DEBUG ERRORS:-----------------
    func base64URLDecode(_ str: String) -> Data? {
        var s = str.replacingOccurrences(of: "-", with: "+").replacingOccurrences(of: "_", with: "/")
        let pad = 4 - s.count % 4
        if pad < 4 { s.append(String(repeating: "=", count: pad)) }
        return Data(base64Encoded: s)
    }

    func decodeJWT(_ jwt: String) -> (header: [String:Any]?, payload: [String:Any]?) {
        let parts = jwt.split(separator: ".").map(String.init)
        guard parts.count >= 2,
              let h = base64URLDecode(parts[0]),
              let p = base64URLDecode(parts[1]),
              let header = try? JSONSerialization.jsonObject(with: h) as? [String:Any],
              let payload = try? JSONSerialization.jsonObject(with: p) as? [String:Any] else {
            return (nil, nil)
        }
        return (header, payload)
    }

    func printJWT(_ label: String, _ jwt: String?) {
        guard let jwt, !jwt.isEmpty else { print("\(label): <nil>"); return }
        let (h, p) = decodeJWT(jwt)
        print("🔎3BUG: \(label) header=\(h ?? [:])")
        print("🔎3BUG: \(label) payload=\(p ?? [:])")
    }
    
    func dumpFirebaseOptions() {
        guard let opts = FirebaseApp.app()?.options else { print("No FirebaseApp yet"); return }
        print("⚙️3BUG: Firebase Options -> projectID=\(opts.projectID ?? "nil"), googleAppID=\(opts.googleAppID), apiKey=\(opts.apiKey), bundleID=\(Bundle.main.bundleIdentifier ?? "nil")")
    }
    
//    TEST DEBUG ERRORS:-------------
}

#Preview {
    SignInView()
}
