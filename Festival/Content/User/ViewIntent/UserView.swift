//
//  UserView.swift
//  Festival
//
//  Created by Tom Sartori on 3/12/23.
//

import SwiftUI

struct UserView: View {

    @State var showLoginView = true

    var body: some View {
        VStack {
            Group {
                LoginView().isVisible(showLoginView)
                RegisterView().isVisible(!showLoginView)
                Button(showLoginView ? "Pas encore de compte ?" : "Déjà un compte ?") {
                    showLoginView.toggle()
                }
            }
                .isVisible(UserDAO().isNotLoggedIn())

            Group {
                ProfileView()
            }
                .isVisible(UserDAO().isLoggedIn())
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
