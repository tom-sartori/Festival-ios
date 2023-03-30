//
// Created by Tom Sartori on 3/23/23.
//

import SwiftUI

struct FestivalZoneView: View {

    @ObservedObject private(set) var zone: ZoneModel
    private var intent: FestivalZoneIntent

    @State private var isShowingPopoverManageVolunteer: Bool = false
    @State private var volunteerList: [UserModel] = []

    @AppStorage("isAdmin") var isAdmin: Bool = false
    @AppStorage("token") var token: String?

    @State var editMode = EditMode.inactive
    @State private var itemSelection = Set<UserModel>()

    init(festivalSlotIntent: FestivalSlotIntent, zone: ZoneModel) {
        self.zone = zone
        intent = FestivalZoneIntent(slotIntent: festivalSlotIntent, zone: zone)
        volunteerList = []
    }

    var body: some View {
        VStack {
            TextAdmin(placeholder: "Nom de la zone", text: $zone.name).onSubmit(update)

            Stepper("Nombre de bénévoles souhaités : \(zone.nbVolunteerNeeded)", value: $zone.nbVolunteerNeeded, in: 0...50)
                .isVisible(isAdmin)
                .onChange(of: zone.nbVolunteerNeeded) { _ in
                    update()
                }
            Text("\(zone.nbVolunteerNeeded) bénévoles souhaités").isHidden(isAdmin)

            NavigationView {
                VStack {
                    List(volunteerList, id: \.self, selection: $itemSelection) { volunteer in
                        Text(volunteer.firstName!).isVisible(editMode.isEditing)
                        Text(volunteer.firstName!).isVisible(!editMode.isEditing && itemSelection.contains(volunteer))
                    }
                        .toolbar {
                            EditButton().isVisible(isAdmin)
                        }
                        .environment(\.editMode, $editMode)
                }
                    .onChange(of: itemSelection, perform: { value in
                        zone.volunteers = Array(itemSelection)
                    })
                    .animation(.default, value: itemSelection.isEmpty)
            }
                .onDisappear {
                    editMode = .inactive
                }
            Button(isSubscribing() ? "Se désinscrire" : "S'inscrire") {
                subscribe()
            }
                .isVisible(token != nil)
                .padding()
        }
            .onChange(of: editMode, perform: { value in
                if value.isEditing {
                    // Entering edit mode (e.g. 'Edit' tapped)
                    itemSelection = Set(zone.volunteers)
                }
                else {
                    // Leaving edit mode (e.g. 'Done' tapped)
                    update()
                }
            })
            .onAppear {
                getVolunteers()
            }
    }

    func update() -> Void {
        intent.update()
        itemSelection = Set(zone.volunteers)
    }

    func getVolunteers() -> Void {
        Task {
            let userDtoList = try! await UserDAO().read()
            userDtoList.forEach { userDto in
                volunteerList.append(UserModel(userDto: userDto))
            }
            itemSelection = Set(zone.volunteers)
        }
    }

//    func addVolunteer(volunteer: UserModel) -> Void {
//        zone.volunteers.append(volunteer)
//        update()
//    }

    func updateVolunteer() {
        zone.volunteers = Array(itemSelection)
        update()
    }

    func subscribe() -> Void {
        if (isSubscribing()) {
            let a = JWTHelper().decode(jwtToken: token!)
            // get the sub token
            let id = a["sub"] as! String
            zone.volunteers.removeAll(where: { $0.id == id })
            update()
        }
        else {
            let a = JWTHelper().decode(jwtToken: token!)
            // get the sub token
            let id = a["sub"] as! String
            zone.volunteers.append(UserModel(id: id))
            update()
        }
    }

    func isSubscribing() -> Bool {
        guard token != nil else {
            return false
        }
        let a = JWTHelper().decode(jwtToken: token!)
        // get the sub token
        let id = a["sub"] as! String
        return zone.volunteers.contains(where: { $0.id == id })
    }
}
