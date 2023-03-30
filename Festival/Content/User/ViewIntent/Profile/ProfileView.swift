//
// Created by Tom Sartori on 3/22/23.
//

import SwiftUI

struct ProfileView : View{
    var body: some View {
        NavigationView{
            Form {
                Button("Se déconnecter", role: .destructive, action: {
                    UserDAO().logout()
                })
            }
                .navigationTitle("Profil")
        }
    }
}
