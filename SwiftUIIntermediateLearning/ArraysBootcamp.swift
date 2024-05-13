//
//  ArraysBootcamp.swift
//  SwiftUIIntermediateLearning
//
//  Created by Asya Tealdi on 09/05/2024.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var mappedArray: [String] = []
    
    init() {
        getUsers()
        updateFilteredArray()
    }
    
    func updateFilteredArray() {
        //sort - Compare 2 users and returns based on condition
        /*        filteredArray = dataArray.sorted { (user1, user2) -> Bool in
            user1.points > user2.points
        }
        filteredArray = dataArray.sorted(by: { $0.points > $1.points })
         */
        
        //filter - Filter based on condition
        /*
         filteredArray = dataArray.filter({ user -> Bool in
            user.points > 10
        })
        filteredArray = dataArray.filter({ $0.isVerified })
         */
        
        //map
        /* mappedArray = dataArray.map({ user in
            user.name
        })
        mappedArray = dataArray.map({ $0.name })
         
        //Compact map, if the field is optional(nil) it just doesn't include in the mapped array
        mappedArray = dataArray.compactMap({ $0.name })
         */
                 
        mappedArray = dataArray
                        .sorted(by: { $0.points > $1.points })
                        .filter({ $0.isVerified })
                        .compactMap({ $0.name })
    }
    
    func getUsers() {
        let user1 = UserModel(name: "Asya", points: 5, isVerified: true)
        let user2 = UserModel(name: "Barbara", points: 4, isVerified: false)
        let user3 = UserModel(name: nil, points: 8, isVerified: true)
        let user4 = UserModel(name: "Thomas", points: 2, isVerified: false)
        let user5 = UserModel(name: "Framboos", points: 0, isVerified: true)
        let user6 = UserModel(name: "Shary", points: 16, isVerified: false)
        let user7 = UserModel(name: nil, points: 3, isVerified: true)
        let user8 = UserModel(name: "Dorian", points: 10, isVerified: false)
        let user9 = UserModel(name: "Matt", points: 7, isVerified: true)
        let user10 = UserModel(name: "Anna", points: 19, isVerified: false)
        
        self.dataArray.append(contentsOf: [
            user1,
            user2,
            user3,
            user4,
            user5,
            user6,
            user7,
            user8,
            user9,
            user10,
        ])
    }
}

struct ArraysBootcamp: View {
    
    @StateObject var vm = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(vm.mappedArray, id: \.self) { name in
                    Text(name)
                        .font(.title)
                }
//                ForEach(vm.filteredArray) { user in
//                    VStack(alignment: .leading) {
//                        Text(user.name)
//                            .font(.headline)
//                        HStack {
//                            Text("Points: \(user.points)")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                    }
//                    .foregroundStyle(Color.white)
//                    .padding()
//                    .background(Color.blue.cornerRadius(10))
//                    .padding(.horizontal)
//                }
            }
        }
    }
}

#Preview {
    ArraysBootcamp()
}
