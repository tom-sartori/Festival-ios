//
// Created by Tom Sartori on 3/23/23.
//

import SwiftUI

struct FestivalDetailView: View {

    @ObservedObject private(set) var festival: FestivalModel
    private var intent: FestivalDetailIntent

    @State private var showingPopoverAddDay = false
    @State private var addingDay = DayModel()

    @AppStorage("isAdmin") var isAdmin: Bool = false

    init(festival: FestivalModel) {
        self.festival = festival
        intent = FestivalDetailIntent(festival: festival)
    }

    var body: some View {
        VStack {
            Group {
                TextAdmin(placeholder: "Nom du festival", text: $festival.name).onSubmit(update)
                DatePicker("Date de début", selection: $festival.startDate, displayedComponents: .date)
                    .disabled(!isAdmin)
                    .onChange(of: festival.startDate) { _ in
                        update()
                    }
                Toggle("Actif", isOn: $festival.active)
                    .isVisible(isAdmin)
                    .onChange(of: festival.active) { _ in
                        update()
                    }
                Text("Le festival est clôturé. ")
                    .foregroundColor(.red)
                    .isVisible(!festival.active)
            }
                .padding(.horizontal)
            NavigationStack {
                List {
                    Section {} header: { Text("Liste des journées")}
                    ForEach(festival.days, id: \.self) { (day: DayModel) in
                        NavigationLink(destination: FestivalDayView(festivalIntent: intent, day: day)) {
                            Text("\(day.name) : \(day.startHour.toHourMinuteString()) - \(day.endHour.toHourMinuteString())")
                        }
                    }
                        .onDelete(perform : delete)
                        .deleteDisabled(!isAdmin)
                }
            }
            Button("Ajouter un jour") {
                addingDay = DayModel()
                showingPopoverAddDay.toggle()
            }
                .isVisible(isAdmin)
                .popover(isPresented: $showingPopoverAddDay) {
                    VStack {
                        Form {
                            Section {
                                TextField("Nom du jour", text: $addingDay.name)
                                DatePicker(selection: $addingDay.startHour, displayedComponents: .hourAndMinute) {
                                    Text("Heure de début")
                                }
                                    .onAppear {
                                        UIDatePicker.appearance().minuteInterval = 30
                                    }
                                    .onDisappear {
                                        UIDatePicker.appearance().minuteInterval = 1
                                    }
                                DatePicker(selection: $addingDay.endHour, displayedComponents: .hourAndMinute) {
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
                                Button("Ajouter", action: addDay)
                            }
                        }
                            .onSubmit(addDay)
                    }
                }
                .padding()
        }
    }

    private func addDay() -> Void {
        festival.days.append(addingDay)
        showingPopoverAddDay.toggle()
        update()
    }

    private func update() -> Void {
        intent.update(festivalModel: festival)
    }

    private func delete(at offsets: IndexSet) {
        intent.delete(at: offsets)
    }
}
