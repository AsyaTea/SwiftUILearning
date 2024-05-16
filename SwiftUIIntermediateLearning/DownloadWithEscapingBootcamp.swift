//
//  DownloadWithEscapingBootcamp.swift
//  SwiftUIIntermediateLearning
//
//  Created by Asya Tealdi on 15/05/2024.
//

import SwiftUI

class DownloadWithEscapingViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        // DataTask automatically downloads the data in the background thread, we don't have to specify it
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        downloadData(fromURL: url) { data in
            if let data = data {
                guard let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.posts = newPosts
                }
            } else {
                print("No data")
            }
        }
    }
    
    //@escaping because it's asynchronous
    //Generic data, it can be used everywhere
    func downloadData(fromURL url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300
            else {
                print("Error downloading data.")
                completionHandler(nil)
                return
            }
            
            completionHandler(data)
        }
        .resume() //starts the function
    }
}

struct DownloadWithEscapingBootcamp: View {
    @StateObject var vm = DownloadWithEscapingViewModel()
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
    DownloadWithEscapingBootcamp()
}
