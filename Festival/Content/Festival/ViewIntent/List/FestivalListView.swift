//
// Created by Tom Sartori on 3/22/23.
//

import SwiftUI

struct FestivalListView: View {

    @ObservedObject private var festivalListModel: FestivalListModel
    private var intent: FestivalListIntent

    @State private var isShowingAddFestivalPopover = false
    @State private var addingFestival = FestivalModelDto()
    @State private var addingDate = Date()

    @AppStorage("isAdmin") var isAdmin: Bool = false

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()

    init() {
        let festivalList = FestivalListModel()

        self.festivalListModel = festivalList
        intent = FestivalListIntent(festivalList: festivalList)
    }

    var body: some View {
        VStack {
            NavigationStack {
                List {
                    ForEach(festivalListModel, id: \.self) { (festival: FestivalModel) in
                        NavigationLink(destination: FestivalDetailView(festival: festival)) {
                            Text(festival.name)
                        }
                    }
                        //                        .onDelete { (indexSet: IndexSet) in
                        //                            festivalListModel.remove(atOffsets: indexSet)
                        //                        }
                        .onDelete(perform: delete).deleteDisabled(!isAdmin)
                }
                    .refreshable {
                        intent.load()
                    }
                Button("Ajouter un festival") {
                    addingFestival = FestivalModelDto()
                    addingDate = Date()
                    isShowingAddFestivalPopover.toggle()
                }
                    .isVisible(isAdmin)
                    .popover(isPresented: $isShowingAddFestivalPopover) {
                        VStack {
                            Form {
                                Section {
                                    TextField("Nom du festival", text: $addingFestival.name)
                                    DatePicker("Date de début", selection: $addingDate, displayedComponents: .date)
                                }
                                    .onSubmit {
                                        addFestival()
                                    }
                                Section {
                                    Button("Ajouter") {
                                        addFestival()
                                    }
                                }
                                    .disabled(disabledForm)
                            }
                        }
                    }
                    .padding()
            }
                .onAppear {
                    intent.load()
                }
        }
    }

    private func addFestival() {
        let f: FestivalModel = FestivalModel(festivalDto: addingFestival)
        f.startDate = addingDate
        festivalListModel.append(f)
        isShowingAddFestivalPopover.toggle()
        intent.create(festival: f)
    }

    private var disabledForm: Bool {
        addingFestival.name.isEmpty
    }

    private func delete(at offsets: IndexSet) {
        intent.delete(at: offsets)
    }
}

struct FestivalListView_Previews: PreviewProvider {
    static var previews: some View {
        FestivalListView()
    }
}
