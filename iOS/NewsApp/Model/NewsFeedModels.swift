

import Foundation

class NewsFeed: ObservableObject, RandomAccessCollection {
    typealias Element = NewsListItem
    
    @Published var newsListItems = [NewsListItem]()
    
    var startIndex: Int { newsListItems.startIndex }
    var endIndex: Int { newsListItems.endIndex }
    var loadStatus = LoadStatus.ready(nextPage: 1)
    
    var urlBase = "https://s3.amazonaws.com/tweet.meme/1328653653079560192_basketball_lYfh8U.jpg"
    
    init(url: String?) {
        loadMoreArticles( imageurl: url)
    }
    
    subscript(position: Int) -> NewsListItem {
        return newsListItems[position]
    }
    
    func loadMoreArticles(currentItem: NewsListItem? = nil, imageurl: String?) {
        
        if !shouldLoadMoreData(currentItem: currentItem) {
            return
        }
        guard case let .ready(page) = loadStatus else {
            return
        }
        loadStatus = .loading(page: page)
//        let urlString = "\(urlBase)\(page)"
//
//        let url = URL(string: urlString)!
//        let task = URLSession.shared.dataTask(with: url, completionHandler: parseArticlesFromResponse(data:response:error:))
//        task.resume()
        
        
        // prepare json data
        let json : [String: Any] =
            [
                "imgUrl": "https://s3.amazonaws.com/tweet.meme/1327795613463949315_JoJo_g8kygy.jpg"
            ]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        // create post request
        let url = URL(string: "https://v4vk0t5qd1.execute-api.us-east-1.amazonaws.com/test/memes")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // insert json data to the request
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let newArticles = self.parseArticlesFromData(data: data)
            print(newArticles)
//            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//                if let responseJSON = responseJSON as? [String: Any] {
//                    print(responseJSON)
//                }
            DispatchQueue.main.async {
                self.newsListItems.append(contentsOf: newArticles)
                if newArticles.count == 0 {
                    self.loadStatus = .done
                } else {
                    guard case let .loading(page) = self.loadStatus else {
                        fatalError("loadSatus is in a bad state")
                    }
                    self.loadStatus = .ready(nextPage: page + 1)
                }
            }
        }

        task.resume()
    }
    
    func shouldLoadMoreData(currentItem: NewsListItem? = nil) -> Bool {
        guard let currentItem = currentItem else {
            return true
        }
        
        for n in (newsListItems.count - 4)...(newsListItems.count-1) {
            if n >= 0 && currentItem.uuid == newsListItems[n].uuid {
                return true
            }
        }
        return false
    }
    
    func parseArticlesFromResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            print("Error: \(error!)")
            loadStatus = .parseError
            return
        }
        guard let data = data else {
            print("No data found")
            loadStatus = .parseError
            return
        }
        
        let newArticles = parseArticlesFromData(data: data)
        DispatchQueue.main.async {
            self.newsListItems.append(contentsOf: newArticles)
            if newArticles.count == 0 {
                self.loadStatus = .done
            } else {
                guard case let .loading(page) = self.loadStatus else {
                    fatalError("loadSatus is in a bad state")
                }
                self.loadStatus = .ready(nextPage: page + 1)
            }
        }
    }
    
    func parseArticlesFromData(data: Data) -> [NewsListItem] {
        var response: NewsApiResponse
        do {
            
            response = try JSONDecoder().decode(NewsApiResponse.self, from: data)
            
        } catch {
            print("Error parsing the JSON: \(error)")
            return []
        }
        
        if response.statusCode != 200 {
            print("Status is not ok: \(response.statusCode)")
            return []
        }
        
        return response.body ?? []
    }
    
    enum LoadStatus {
        case ready (nextPage: Int)
        case loading (page: Int)
        case parseError
        case done
    }
}

class NewsApiResponse: Codable {
    var statusCode: Int
    var body: [NewsListItem]?
}

class NewsListItem: Identifiable, Codable {
    var uuid = UUID()
    
    var imgUrl: String?
    var link: String
    var name: String?
    var tag: String
    var text: String
    
    enum CodingKeys: String, CodingKey {
        case name,tag, text, imgUrl, link
    }
}
