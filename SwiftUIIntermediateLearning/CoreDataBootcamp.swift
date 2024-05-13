//
//  CoreDataBootcamp.swift
//  SwiftUIIntermediateLearning
//
//  Created by Asya Tealdi on 11/05/2024.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    
    @Published var savedEntities: [FruitEntity] = []
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            } else {
                print("Successfully loaded Core Data.")
            }
        }
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity >(entityName: "FruitEntity")
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func addFruit(text: String) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        saveData()
    }
    
    func updateItem(fruit: FruitEntity) {
            let currentName = fruit.name ?? ""
            let newName = currentName + "!"
            fruit.name = newName
            saveData()
    }
    
    func deleteFruit(offset: IndexSet) {
        guard let index = offset.first else { return }
        let fruitEntity = savedEntities[index]
        container.viewContext.delete(fruitEntity)
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
    
}

struct CoreDataBootcamp: View {
    @StateObject var vm = CoreDataViewModel()
    @State var textFieldText = ""
    let bgColor = Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))
    let tFbgColor = Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1))
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                TextField("Add fruit here...", text: $textFieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(tFbgColor)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                
                Button(action: {
                    guard !textFieldText.isEmpty else { return}
                    vm.addFruit(text: textFieldText)
                    textFieldText = ""
                }, label: {
                    Text("Submit")
                        .font(.headline)
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(bgColor)
                        .cornerRadius(10)
                })
                .padding(.horizontal)
                
                List {
                    ForEach(vm.savedEntities) { fruit in
                        Text(fruit.name ?? "")
                            .onTapGesture {
                                vm.updateItem(fruit: fruit)
                            }
                    }
                    .onDelete(perform: vm.deleteFruit)
                }
            }
            .navigationTitle("Fruits")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CoreDataBootcamp()
}
