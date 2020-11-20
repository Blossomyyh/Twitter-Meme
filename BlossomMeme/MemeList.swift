//
//  MemeList.swift
//  BlossomMeme
//
//  Created by yuhan yin on 11/20/20.
//

import SwiftUI

struct MemeList: View {
    
    var memes = memeData
    @State var showContent = false
    
    var body: some View {
        VStack {
            // title
            HStack{
                VStack (alignment: .leading) {
                    Text("Twitter Meme")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    Text("Meme of the day")
                       .foregroundColor(.gray)
                }
                Spacer()
                
            }.padding(.leading, 60.0)
            
            // meme scroll view
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30.0) {
                    ForEach(memes) { item in
                        Button(action: { self.showContent.toggle() }){
                            GeometryReader { geometry in
                                MemeView(title: item.title,
                                         image: item.image,
                                         color: item.color,
                                         shadowColor: item.shadowColor)
                                    .rotation3DEffect(Angle(degrees:
                                       Double(geometry.frame(in: .global).minX - 30) / -40), axis: (x: 0, y: 10.0, z: 0))
                                    .sheet(isPresented: self.$showContent) { MemeSuggestionView() }
                                
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
    var image = "Illustration1"
    var color = Color("background3")
    var shadowColor = Color("backgroundShadow3")
    
    var body: some View{
        return VStack(alignment: .leading) {
            Text(title)
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .padding(30)
                .lineLimit(4)
            Spacer()
            Image(image)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .frame(width: 246, height: 150)
                .padding(.bottom, 30)
        }
        .background(color)
        .cornerRadius(30)
        .frame(width: 246, height: 360)
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
    var image: String
    var color: Color
    var shadowColor: Color
}

let memeData = [
    Meme(title: "Meme of the day", image: "", color: .black, shadowColor: .gray),
    Meme(title: "Second Meme", image: "", color: .black, shadowColor: .gray)
]
