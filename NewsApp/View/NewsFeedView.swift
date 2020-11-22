
import SwiftUI

struct NewsFeedView: View {
    @ObservedObject var newsFeed: NewsFeed
    var imageurl : String?
    
    init(url: String?) {
        imageurl = url ?? "https://s3.amazonaws.com/tweet.meme/1328653653079560192_basketball_lYfh8U.jpg"
        newsFeed = NewsFeed(url: url)
    }
    
    var body: some View {
        NavigationView {
            List(newsFeed) { (article: NewsListItem) in
                NavigationLink(destination: NewsListItemView(article: article)) {
                    NewsListItemListView(article: article)
                        .onAppear {
                            self.newsFeed.loadMoreArticles(currentItem: article, imageurl: imageurl)
                    }
                }
            }
        .navigationBarTitle("Suggest Twitters")
        }
    }
}

struct NewsListItemView: View {
    var article: NewsListItem
    
    var body: some View {
        UrlWebView(urlToDisplay: URL(string: article.link)!)
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle(article.name ?? "abc")
    }
}

struct NewsListItemListView: View {
    var article: NewsListItem
    
    var body: some View {
        VStack {
            
            VStack(alignment: .leading) {
                Text("\(article.text)")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top)
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .lineLimit(1)
                Text("\(article.tag ?? "No Author")")
                    .foregroundColor(.white)
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .lineLimit(2)
            }
            UrlImageView(urlString: article.imgUrl)
        }
        .background(Color.black)
        .cornerRadius(10)
        .shadow(radius: 10)
        .animation(.spring())
    }
}

struct NewsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView(url: "" )
    }
}
