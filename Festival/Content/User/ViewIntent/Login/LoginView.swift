//
//  LoginView.swift
//  Festival
//
//  Created by Tom Sartori on 3/12/23.
//

import SwiftUI

struct LoginView: View {

    @State var email: String
    @State var password: String

    init() {
        self.email = ""
        self.password = ""
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Email", text: $email)
                    SecureField("Mot de passe", text: $password)
                }
                Section {
                    Button("Se connecter", action: {
                        Task {
                            await UserDAO().login(email: email, password: password)
                        }
                    })
                }
                    .disabled(disabledForm)
            }
                .navigationTitle("Se connecter")
        }
            .onSubmit {
                Task {
                    await UserDAO().login(email: email, password: password)
                }
            }
    }

    var disabledForm: Bool {
        email.isEmpty || password.isEmpty
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
