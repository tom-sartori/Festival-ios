//
// Created by Tom Sartori on 3/23/23.
//

import SwiftUI

struct FestivalSlotView: View {

    @ObservedObject private var slot: SlotModel
    private var intent: FestivalSlotIntent

    @State private var addingZone = ZoneModel()
    @State private var showingPopoverAddZone = false

    @AppStorage("isAdmin") var isAdmin: Bool = false

    init(festivalDayIntent: FestivalDayIntent, slot: SlotModel) {
        self.slot = slot
        intent = FestivalSlotIntent(festivalDayIntent: festivalDayIntent, slot: slot)
    }

    var body: some View {
        VStack {
            HStack() {
                DatePicker("", selection: $slot.startHour, displayedComponents: .hourAndMinute)
                DatePicker("", selection: $slot.endHour, displayedComponents: .hourAndMinute)
            }
                .disabled(!isAdmin)
                .onChange(of: slot.startHour) { _ in
                    update()
                }
                .onChange(of: slot.endHour) { _ in
                    update()
                }
            NavigationStack {
                List {
                    ForEach(slot.zones, id: \.self) { (zone: ZoneModel) in
                        NavigationLink(destination: FestivalZoneView(festivalSlotIntent: intent, zone: zone)) {
                            Text(zone.name)
                        }
                    }
                        .onDelete(perform: delete)
                        .deleteDisabled(!isAdmin)
                }
            }
            Button("Ajouter une zone") {
                addingZone = ZoneModel()
                showingPopoverAddZone.toggle()
            }
                .isVisible(isAdmin)
                .popover(isPresented: $showingPopoverAddZone) {
                    VStack {
                        Form {
                            Section {
                                TextAdmin(placeholder: "Nom de la zone", text: $addingZone.name).onSubmit(addZone)
                            }
                            Section {
                                Button("Ajouter", action: addZone)
                            }
                        }
//                            .onSubmit(addZone)
                    }
                }
                .padding()
        }
    }

    private func addZone() {
        slot.zones.append(addingZone)
        showingPopoverAddZone.toggle()
        intent.update()
    }

    private func update() -> Void {
        intent.update()
    }

    private func delete(at offsets: IndexSet) {
        intent.delete(at: offsets)
    }
}
