//
//  SubscriberBootcamp.swift
//  SwiftUIIntermediateLearning
//
//  Created by Asya Tealdi on 17/05/2024.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject {
    @Published var count: Int = 0
    @Published var textFieldText = ""
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        setUpTimer()
    }
    
    func setUpTimer() {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.count += 1
                
            }
            .store(in: &cancellables)
    }
}
struct SubscriberBootcamp: View {
    @StateObject var vm = SubscriberViewModel()
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)
            
            TextField("Type something..", text: vm.$textFieldText)
                .frame(height: 55)
        }
    }
}

#Preview {
    SubscriberBootcamp()
}
