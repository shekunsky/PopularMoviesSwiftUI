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
    var widthForText: CGFloat { ScreenSize.deviceWidth - posterHeight - 20 }
    
    let favoriteColor: Color = .blue
    let commonColor: Color = .gray
    let posterHeight: CGFloat = 70
    
    private var poster: some View {
        let url = URL(string: posterPath ?? "")
        return KFImage(url)
            .placeholder {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: posterHeight, height: posterHeight)
                    .opacity(0.3)
            }
            .resizable()
            .scaledToFit()
            .frame(width: posterHeight, height: posterHeight)
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
                            .fontWeight(.bold)
                            .padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5))
                            .lineLimit(2)
                        
                        Button(action: {
                            favoriteAction?()
                        }) {
                            Image(systemName: "star.fill")
                                .renderingMode(.template)
                                .foregroundColor(isFavorite ? favoriteColor : commonColor)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }.frame(width: widthForText, height: nil, alignment: .center)
                }
            }.padding(.top, 5)
        }.background(Color.clear)
    }
}

#if DEBUG
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
#endif
