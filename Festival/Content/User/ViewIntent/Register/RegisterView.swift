//
// Created by Tom Sartori on 3/22/23.
//

import SwiftUI

struct RegisterView: View {

    @State var firstName: String
    @State var lastName: String
    @State var email: String
    @State var password: String
    @State var confirmPassword: String

    init() {
        self.firstName = ""
        self.lastName = ""
        self.email = ""
        self.password = ""
        self.confirmPassword = ""
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Prénom", text: $firstName).autocorrectionDisabled()
                    TextField("Nom", text: $lastName).autocorrectionDisabled()
                    TextField("Email", text: $email).autocorrectionDisabled()
                    SecureField("Mot de passe", text: $password).autocorrectionDisabled()
                    SecureField("Confirmer le mot de passe", text: $confirmPassword).autocorrectionDisabled()
                }
                Section {
                    Button("S'inscrire", action: {
                        Task {
                            await UserDAO().register(firstName: firstName, lastName: lastName, email: email, password: password)
                        }
                    })
                }
                    .disabled(disabledForm)
            }
                .navigationTitle("S'inscrire")
        }
            .onSubmit {
                Task {
                    await UserDAO().register(firstName: firstName, lastName: lastName, email: email, password: password)
                }
            }

    }

    var disabledForm: Bool {
        email.isEmpty || password.isEmpty || firstName.isEmpty || lastName.isEmpty || password != confirmPassword
    }
}
