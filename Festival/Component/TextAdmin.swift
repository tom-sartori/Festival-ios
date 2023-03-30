//
// Created by Tom Sartori on 3/27/23.
//

import SwiftUI

struct TextAdmin: View {

    private var placeholder: String
    private var text: Binding<String>

    @AppStorage("isAdmin") var isAdmin: Bool = false

    init(placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self.text = text
    }

    var body: some View {
        VStack {
            Text(text.wrappedValue)
                .isHidden(isAdmin)

            TextField(placeholder, text: text)
                .isVisible(isAdmin)
        }
    }
}
