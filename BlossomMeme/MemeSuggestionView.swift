//
//  MemeSuggestionView.swift
//  BlossomMeme
//
//  Created by yuhan yin on 11/20/20.
//

import SwiftUI
import WaterfallGrid

struct MemeSuggestionView: View {
    var suggestMemes = suggestMemeData
//    var gridItems = getItems(suggestMemes)
    var body: some View {
        LazyVGrid(columns: getItems(suggestMemes: suggestMemes), content: {
            
            ForEach(0..<8) { idx in
                if idx == 4 {Color.clear}
                Text("This is meme")
            }
        }).frame(width: 470)
    }
    
    func getItems(suggestMemes : [SuggestMeme])-> [GridItem]{
        var gridItems =  [GridItem(.fixed(150), spacing: 10, alignment: .leading)]
        for suggest in suggestMemes {
            gridItems.append(GridItem(.fixed(150), spacing: 10, alignment: .leading))
        }
        return gridItems
    }
}

struct MemeSuggestionView_Previews: PreviewProvider {
    static var previews: some View {
        MemeSuggestionView()
    }
}

struct SuggestMeme: Identifiable {
    var id = UUID()
    var title: String
    var image: String
    var color: Color
    var shadowColor: Color
}

let suggestMemeData = [
    SuggestMeme(title: "Meme of the day", image: "", color: .black, shadowColor: .gray),
    SuggestMeme(title: "Second Meme", image: "", color: .black, shadowColor: .gray)
]

