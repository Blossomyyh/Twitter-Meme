//
//  MemeShowView.swift
//  NewsApp
//
//  Created by yuhan yin on 11/21/20.
//  Copyright © 2020 SchwiftyUI. All rights reserved.
//

import SwiftUI

struct MemeShowView: View {
    
    @ObservedObject var urlImageModel: UrlImageModel
    static var defaultUrlImage = UIImage(named: "NewsIcon")
    
    init(urlString: String?) {
        urlImageModel = UrlImageModel(urlString: urlString)
    }
    
    var body: some View {
        Image(uiImage: urlImageModel.image ?? MemeShowView.defaultUrlImage!)
            .resizable()
            .renderingMode(.original)
            .aspectRatio(contentMode: .fit)
            .frame(width: 260, height: 160)
            .padding(.bottom, 30)
    }
}

struct MemeShowView_Previews: PreviewProvider {
    static var previews: some View {
        MemeShowView(urlString: nil)
    }
}
