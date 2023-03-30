//
// Created by Tom Sartori on 3/23/23.
//

import SwiftUI

struct FestivalDayView: View {

    @ObservedObject private var day: DayModel
    @State private var addingSlot = SlotModel()
    @State private var showingPopoverAddSlot = false
    private var intent: FestivalDayIntent

    @AppStorage("isAdmin") var isAdmin: Bool = false

    init(festivalIntent: FestivalDetailIntent, day: DayModel) {
        self.day = day
        intent = FestivalDayIntent(festivalIntent: festivalIntent, day: day)
    }

    var body: some View {
        VStack {
            TextAdmin(placeholder: "Nom du jour", text: $day.name).onSubmit(update)
            HStack {
                DatePicker("", selection: $day.startHour, displayedComponents: .hourAndMinute)
                DatePicker(" - ", selection: $day.endHour, displayedComponents: .hourAndMinute)
            }
                .disabled(!isAdmin)
                .onChange(of: day.startHour) { _ in
                    update()
                }
                .onChange(of: day.endHour) { _ in
                    update()
                }
            NavigationStack {
                List {
                    ForEach(day.slots, id: \.self) { (slot: SlotModel) in
                        NavigationLink(destination: FestivalSlotView(festivalDayIntent: intent, slot: slot)) {
                            Text("\(slot.startHour.toHourMinuteString()) - \(slot.endHour.toHourMinuteString())")
                        }
                    }
                        .onDelete(perform: delete)
                        .deleteDisabled(!isAdmin)
                }
            }
            Button("Ajouter un créneau") {
                addingSlot = SlotModel()
                showingPopoverAddSlot.toggle()
            }
                .isVisible(isAdmin)
                .popover(isPresented: $showingPopoverAddSlot) {
                    VStack {
                        Form {
                            Section {
                                DatePicker(selection: $addingSlot.startHour, displayedComponents: .hourAndMinute) {
                                    Text("Heure de début")
                                }
                                    .onAppear {
                                        UIDatePicker.appearance().minuteInterval = 30
                                    }
                                    .onDisappear {
                                        UIDatePicker.appearance().minuteInterval = 1
                                    }
                                DatePicker(selection: $addingSlot.endHour, displayedComponents: .hourAndMinute) {
                                    Text("Heure de fin")
                                }
                                    .onAppear {
                                        UIDatePicker.appearance().minuteInterval = 30
                                    }
                                    .onDisappear {
                                        UIDatePicker.appearance().minuteInterval = 1
                                    }
                            }
                            Section {
                                Button("Ajouter", action: addSlot)
                            }
                        }
                            .onSubmit(addSlot)
                    }
                }
                .padding()
        }
    }

    private func addSlot() -> Void {
        day.slots.append(addingSlot)
        showingPopoverAddSlot.toggle()
        update()
    }

    private func update() -> Void {
        intent.update(dayModel: day)
    }

    private func delete(at offsets: IndexSet) {
        intent.delete(at: offsets)
    }
}
