//
//  MemeList.swift
//  NewsApp
//
//  Created by yuhan yin on 11/21/20.
//  Copyright © 2020 SchwiftyUI. All rights reserved.
//

import SwiftUI

struct MemeList: View {
    var memes = memeData
    @State var showContent = false
    @State var count: Int = 0
    
    var body: some View {
        VStack {
            // title
            HStack{
                VStack (alignment: .leading) {
                    Text("Twitter Meme")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    Text("Meme Suggestions")
                       .foregroundColor(.gray)
                }
                Spacer()
                
            }.padding(.leading, 60.0)
            
            // meme scroll view
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30.0) {
                    ForEach(memes) { item in
                        
                        Button(action: {
                                self.showContent.toggle()
                            self.count = self.count + 1
                        }){
                            GeometryReader { geometry in
                                MemeView(title: item.title,
                                         imageUrl: item.imageUrl,
                                         color: item.color,
                                         shadowColor: item.shadowColor,
                                         name: item.name)
                                    .rotation3DEffect(Angle(degrees:
                                       Double(geometry.frame(in: .global).minX - 30) / -40), axis: (x: 0, y: 10.0, z: 0))
                                    .sheet(isPresented: self.$showContent) {
                                        NewsFeedView(url: memeData[self.count].imageUrl)
                                        
                                    }

                            }.frame(width: 246, height: 360)
                        }
                    }
                }
                .padding(.leading, 30)
                .padding(.top, 30)
                .padding(.bottom, 70)
                Spacer()

            }
            
        }.padding(.top, 78)
    }
}

struct MemeView: View {
    var title = "Build an app with SwiftUI"
    var imageUrl = "Illustration1"
    var color = Color("background3")
    var shadowColor = Color("backgroundShadow3")
    var name = "Meme"
    
    var body: some View{
        return VStack(alignment: .leading) {
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(30)
                .lineLimit(4)
            Spacer()
            
            Text(name)
                .font(.custom("Helvetica Neue", size: 15))
                .padding(.leading, 30 )
                .foregroundColor(.white)
                .lineLimit(1)
            
            MemeShowView(urlString: imageUrl)

        }
        .background(color)
        .cornerRadius(30)
        .frame(width: 246)
        .shadow(color: shadowColor, radius: 20, x: 0, y: 20)
    }
}
struct MemeList_Previews: PreviewProvider {
    static var previews: some View {
        MemeList()
    }
}

struct Meme: Identifiable {
    var id = UUID()
    var title: String
    var name: String
    var color: Color
    var shadowColor: Color
    var imageUrl: String
}


let memeData = [
    Meme(title: "Meme History", name: "#SomethingNew", color: .black, shadowColor: .gray, imageUrl: "https://s3.amazonaws.com/tweet.meme/1327795613463949315_JoJo_g8kygy.jpg"),
    Meme(title: "Avengers!", name: "#rocklee", color: .black, shadowColor: .gray, imageUrl: "https://s3.amazonaws.com/tweet.meme/1328419777069469696_avengers_orWB9J.jpg"),
    Meme(title: "Love it!", name: "#BLACKPINK #LISA", color: .black, shadowColor: .gray, imageUrl: "https://s3.amazonaws.com/tweet.meme/1326624451300106241_Blackpink_Px2cMN.jpg"),
    Meme(title: "Still Quanrantine?", name: "Hope the message is clear...", color: .black, shadowColor: .gray, imageUrl: "https://s3.amazonaws.com/tweet.meme/1328299243195363328_cats_dLjW3G.jpg"),
    Meme(title: "Happy Hour", name: "#naruto #anime", color: .black, shadowColor: .gray, imageUrl: "https://s3.amazonaws.com/tweet.meme/1328841251974750209_Naruto_4SwuD5.jpg"),
    Meme(title: "You made my day", name: "😆🤣🤣😆", color: .black, shadowColor: .gray, imageUrl: "https://s3.amazonaws.com/tweet.meme/1326608868877639680_dogs_Iyfa04.jpg")
    
]

