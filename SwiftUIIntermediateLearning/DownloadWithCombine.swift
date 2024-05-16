//
//  DownloadWithCombine.swift
//  SwiftUIIntermediateLearning
//
//  Created by Asya Tealdi on 16/05/2024.
//

import SwiftUI
import Combine

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithCombineViewModel: ObservableObject {
    @Published var posts : [PostModel] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        /*1. Create the Publisher
        //2. Subscribe publisher on background thread (it happens automatically)
        //3. Receive on main thread
        //4. tryMap (check that the data is good)
        //5. Decode data into PostModels
        //6. Sink (put the item into our app)
        //7. Store (cancel subscription if needed)
         */
        
        URLSession.shared.dataTaskPublisher(for: url)
//            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .replaceError(with: []) //replace error with blank data
            .sink(receiveValue: { [weak self] returnedPosts in
                self?.posts = returnedPosts
            })
//            .sink { completion in
//                switch completion {
//                case .finished:
//                    print("Finished")
//                case .failure(let error):
//                    print("Error. \(error)")
//                }
//            } receiveValue: { [weak self] returnedPosts in
//                self?.posts = returnedPosts
//            }
            .store(in: &cancellables)

    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

struct DownloadWithCombine: View {
    
    @StateObject var vm = DownloadWithCombineViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundStyle(Color.gray)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    DownloadWithCombine()
}
