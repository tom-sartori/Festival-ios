//
//  ContentView.swift
//  Festival
//
//  Created by Tom Sartori on 2/6/23.
//
//

import SwiftUI

struct ContentView: View {
    private var numberTable = 10
    // 2 columns of the same size adjusting to the width of the screen
    var columns = [GridItem](repeating: .init(.flexible(), alignment: .leading), count: 2)
    let salmon = Color(red: 1.0, green: 126.0 / 255.0, blue: 121.0 / 255.0)

    @StateObject private var festival: Festival = Festival(name: "My Festival", initialNumberOfTable: 10, initialTablePrice: 18.3)

    var body: some View {
        VStack {
            Text("Festivals").font(.title)

            LazyVGrid(columns: columns) {
                Text("Name:"); Text(festival.name);
                Text("Number of tables"); Stepper("\(festival.currentNumberOfTable)", value: $festival.currentNumberOfTable, in: 1...100, step: 1)
                Text("Table price"); Stepper(String(format: "%.2f", festival.currentTablePrice), value: $festival.currentTablePrice, in: 1...1000, step: 0.5)
                Text("m2 price"); Text("18.3");
                Text("Max revenue"); Text("7040.0")
            }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))

            Spacer().frame(height: 40)

            HStack() {
                Spacer()
                Button("Default number", action: {
                    festival.currentNumberOfTable = festival.initialNumberOfTable
                })
                        .padding(10)
                        .frame(width: 138)
                        .background(.teal.opacity(0.25))
                        .cornerRadius(10)
                Spacer()
                Button("Default price", action: {
                    festival.currentTablePrice = festival.initialTablePrice
                })
                        .padding(10)
                        .frame(width: 138)
                        .background(salmon.opacity(0.25))
                        .foregroundColor(salmon)
                        .cornerRadius(10)
                Spacer()
            }
        }
    }
}

class ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }

    #if DEBUG
    @objc class func injected() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        windowScene?.windows.first?.rootViewController = UIHostingController(rootView: ContentView())
    }
    #endif
}
