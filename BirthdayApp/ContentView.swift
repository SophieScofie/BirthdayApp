//
//  ContentView.swift
//  BirthdayApp
//
//  Created by Scholar on 8/8/25.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    @Query(sort: \Friend.birthday) private var friends: [Friend]
    @Environment(\.modelContext) private var context
    //= [Friend(name: "Naomi Chi", birthday: .now),Friend(name: "Charlotte Wong", birthday: Date(timeIntervalSinceReferenceDate: 38))
   // ]//end state
    @State private var newName = ""
    @State private var newBirthday = Date.now
    @State private var selectedFriend: Friend?
    
    var body: some View {
        ZStack{
            
            NavigationStack{
               

                    List{
                        ForEach (friends) {friend in
                            HStack{
                                Text(friend.name)
                                Spacer()
                                Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                            }//end HStack
                            .onTapGesture{
                                selectedFriend = friend
                            }//end onTapGesture
                        }//end ForEach loop
                        .onDelete(perform: deleteFriend)
                    }//end list
                    .navigationTitle("🎂       BIRTHDAYS      🎂")
                    .sheet(item: $selectedFriend){
                        friend in NavigationStack{
                            EditFriendView(friend: friend)
                            ZStack {                            }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background {
                                    Color.teal.opacity(0.3)
                                        .ignoresSafeArea()
                                }
                        }//end Nav Stack
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background {
                            Color.teal.opacity(0.3)
                                .ignoresSafeArea()
                        }
                    }//end sheet
                    .safeAreaInset(edge:.bottom){
                        VStack(alignment: .center, spacing: 20){
                            Text("Don't count your years...")
                                .font(.system(size:20))
                            Text("make your years count.")
                                .font(.system(size:23.5))

                            DatePicker(selection: $newBirthday,
                                       in:Date.distantPast...Date.now, displayedComponents: .date){
                                TextField("name", text: $newName)
                                    .textFieldStyle(.roundedBorder)
                            }//ends Date Picker
                            Button("every day is a gift") {
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
            Color.purple.opacity(0.08)
                .ignoresSafeArea()
        }
        
        
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
