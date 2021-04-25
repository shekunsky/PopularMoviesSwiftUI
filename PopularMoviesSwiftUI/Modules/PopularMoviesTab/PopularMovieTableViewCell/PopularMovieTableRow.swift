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
    @Binding var isFavorite: Bool
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
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .opacity(0.3)
        }
        .resizable()
        .scaledToFit()
        .frame(width: 80, height: 80)
    }
    
    //MARK: - Body
    var body: some View {
        VStack {
            HStack {
                if isPreloading {
                    ActivityIndicator()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.blue)
                } else {
                    poster
                    
                    VStack(alignment: .center) {
                        Text(title ?? "")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                            .padding(5)
                            .lineLimit(1)
                        
                        Text(description ?? "")
                            .font(.system(size: 14))
                            .italic()
                            .lineLimit(3)
                    }.layoutPriority(1)
                    
                    Button(action: {
                        favoriteAction?()
                    }) {
                        Image(systemName: "star.fill")
                            .renderingMode(.template)
                            .foregroundColor(isFavorite ? favoriteColor : commonColor)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            //Separator
            Color.black.frame(height:CGFloat(2) / UIScreen.main.scale)
        }
    }
}

struct PopularMovieTableRow_Previews: PreviewProvider {
    static var previews: some View {
        PopularMovieTableRow(posterPath: "https://github.com/onevcat/Kingfisher/blob/master/images/kingfisher-1.jpg?raw=true",
                             title: "Test movie Title",
                             description: "Description of Test Movie\n2-nd line\n3-rd line\n4-line",
                             isFavorite: Binding.constant(true),
                             isPreloading: false,
                             favoriteAction: nil)
    }
}
