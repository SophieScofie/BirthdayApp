//
//  ContentView.swift
//  BirthdayApp
//
//  Created by Scholar on 8/8/25.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    @Query private var friends: [Friend]
    @Environment(\.modelContext) private var context
    //= [Friend(name: "Naomi Chi", birthday: .now),Friend(name: "Charlotte Wong", birthday: Date(timeIntervalSinceReferenceDate: 38))
   // ]//end state
    @State private var newName = ""
    @State private var newBirthday = Date.now
    var body: some View {
        NavigationStack{
            List{
               ForEach (friends) {friend in
                    HStack{
                        Text(friend.name)
                        Spacer()
                        Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                    }//end HStack
                }//end ForEach loop
               .onDelete(perform: deleteFriend)
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
                        //friends.append(newFriend)
                        context.insert(newFriend)
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
    func deleteFriend(at offsets: IndexSet) {
        for index in offsets {
            let friendToDelete = friends[index]
            context.delete(friendToDelete)
        }//ends for loop
    }//ends deleteFriend function
}//end struct

#Preview {
    ContentView()
        .modelContainer(for: Friend.self,
                        inMemory:true)
}
