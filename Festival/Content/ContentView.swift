//
//  ContentView.swift
//  Festival
//
//  Created by Tom Sartori on 2/6/23.
//
//

import SwiftUI

struct ContentView: View {

    @State private var showingPopoverUserView: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                FestivalView()
            }
                .navigationBarItems(trailing: Button(action: {
                    showingPopoverUserView.toggle()
                }, label: {
                    Label("User", systemImage: "person.fill")
//                    Image("person.fill")
                }))
                .popover(isPresented: $showingPopoverUserView, content: {
                    UserView()
                        .padding()
                        .background(Color(UIColor.systemGroupedBackground))
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
