//
// Created by Tom Sartori on 3/22/23.
//

import SwiftUI

struct FestivalView: View {

    @StateObject private var festivalList: FestivalListModel = FestivalListModel(festivals: [])

    var body: some View {
        FestivalListView(festivalList: festivalList)
    }
}
