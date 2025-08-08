//
//  ContentView.swift
//  BirthdayApp
//
//  Created by Scholar on 8/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var friends: [Friend] = [
        Friend(name: "Naomi Chi", birthday: .now),
        Friend(name: "Charlotte Wong", birthday: Date(timeIntervalSinceReferenceDate: 38))
    ]//end state
    @State private var newName = ""
    @State private var newBirthday = Date.now
    var body: some View {
        NavigationStack{
            List(friends, id: \.name) {friend in
                HStack{
                    Text(friend.name)
                    Spacer()
                    Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                }//end HStack
            }//end list
            .navigationTitle("Birthdays")
            .safeAreaInset(edge:.bottom){
                VStack(alignment: .center, spacing: 20){
                    Text("New Birthday").font(.headline)
                    DatePicker(selection: $newBirthday,
                               in:Date.distantPast...Date.now, displayedComponents: .date){
                        TextField("name", text: $newName)
                            .textFieldStyle(.roundedBorder)
                    }//ends Date Picker
                    Button("Save") {
                        let newFriend = Friend(name: newName, birthday:newBirthday)
                        friends.append(newFriend)
                        newName = ""
                        newBirthday = .now
                    }//end button
                    .bold()
                }//endVStack
                .padding()
                .background(.bar)
            }//end safeAreaInset
        }//end NavStack
    }//end body
}//end struct

#Preview {
    ContentView()
}
