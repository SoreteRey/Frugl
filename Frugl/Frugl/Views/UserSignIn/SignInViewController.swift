//
//  SignInViewController.swift
//  Frugl
//
//  Created by Jake Gloschat on 4/26/23.
//

import UIKit
import AuthenticationServices
import CryptoKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Properties
    var viewModel: SignInAccountViewModel!
    var nonce: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SignInAccountViewModel(delegate: self)
        self.hideKeyboardWhenDone()
        let signInWithApple = ASAuthorizationAppleIDButton()
        signInWithApple.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(signInWithApple)
        NSLayoutConstraint.activate([
            signInWithApple.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100),
            signInWithApple.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -100),
            signInWithApple.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -380),
            signInWithApple.heightAnchor.constraint(equalToConstant: 38)
        ])
        signInWithApple.addTarget(self, action: #selector(appleSignInButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.requestUserNotificationAuthorization()
    }
    
    // MARK: - Functions
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    @objc func appleSignInButtonTapped() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [
            .email
        ]
        
        self.nonce = randomNonceString()
        request.nonce = sha256(nonce!)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.presentationContextProvider = self
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    func presentErrorAlertController(error: String) {
        let alertController = UIAlertController(title: "", message: error, preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "Okay", style: .cancel)
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
    
    // MARK: - Actions
    @IBAction func signInButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, email != "",
              let password = passwordTextField.text, password != "" else { return }
        viewModel.signInAccount(email: email, password: password) { Bool, error in
            if let error = error {
                self.presentErrorAlertController(error: error.localizedDescription)
            }
        }
    }
} // End of class

extension SignInViewController: SignInAccountViewModelDelegate {
    func signInSuccessfull() {
    }
}

extension SignInViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
extension SignInViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIdCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // Do something with this credential
            guard let nonce = self.nonce else {
                fatalError()
            }
            guard let appleIdToken = appleIdCredential.identityToken else {
                print("failed to get token")
                return
            }
            guard let idTokenString = String(data: appleIdToken, encoding: .utf8) else { print("No ID Token"); return}
            let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            Auth.auth().signIn(with: firebaseCredential) { [weak self] authResult, error in
                // Do something after firebase sign in has completed
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
            }
        }
    }
}
