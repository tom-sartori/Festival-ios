//
//  IsVisibleViewModifier.swift
//  Festival
//
//  Created by Tom Sartori on 3/13/23.
//

import Foundation
import SwiftUI

struct IsVisibleViewModifier: ViewModifier {
    
    var isVisible: Bool
    
    func body(content: Content) -> some View {
        Group {
            if isVisible {
                content
            }
            else {
                EmptyView()
            }
        }
    }
}
