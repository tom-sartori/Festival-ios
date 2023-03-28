//
//  ViewExtension.swift
//  Festival
//
//  Created by Tom Sartori on 3/13/23.
//

import Foundation
import SwiftUI

extension View {
    
    func isVisible(_ bool: Bool) -> some View {
        modifier(IsVisibleViewModifier(isVisible: bool))
    }
    
    func isHidden(_ bool: Bool) -> some View {
        modifier(IsVisibleViewModifier(isVisible: !bool))
    }
}
