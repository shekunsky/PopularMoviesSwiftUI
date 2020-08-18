//
//  PopularMovieTableRow.swift
//  PopularMoviesSwiftUI
//
//  Created by Alex2 on 17.08.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct PopularMovieTableRow: View {
    var posterPath: String?
    var title: String?
    var description: String?
    var isFavorite: Bool = false
    @State var isPreloading: Bool = false
    var favoriteAction: (()->())? = nil
    
    let favoriteColor: Color = .blue
    let commonColor: Color = .gray
    
    private var poster: some View {
        let url = URL(string: posterPath ?? "")
        return KFImage(url)
            .placeholder {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .opacity(0.3)
        }
        .resizable()
        .frame(width: 80, height: 80)
    }
    
    //MARK: - Body
    var body: some View {
        HStack {
            if isPreloading {
                ActivityIndicator()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.blue)
            } else {
                poster
                VStack(alignment: .center) {
                    Text(title ?? "")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(5)
                    
                    Text(description ?? "")
                        .lineLimit(3)
                }.layoutPriority(1)
                Image(systemName: "star.fill")
                    .renderingMode(.template)
                    .foregroundColor(isFavorite ? favoriteColor : commonColor)
            }
        }
    }
}

struct PopularMovieTableRow_Previews: PreviewProvider {
    static var previews: some View {
        PopularMovieTableRow(posterPath: "https://github.com/onevcat/Kingfisher/blob/master/images/kingfisher-1.jpg?raw=true",
                             title: "Test movie Title",
                             description: "Description of Test Movie\n2-nd line\n3-rd line\n4-line",
                             isFavorite: true,
                             isPreloading: false,
                             favoriteAction: nil)
    }
}
