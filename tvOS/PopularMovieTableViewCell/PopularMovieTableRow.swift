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
    
    let imageWidth: CGFloat = 150
    var imageHeight: CGFloat { imageWidth*5/3 }
    
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
                    .frame(width: imageWidth, height: imageHeight)
                    .opacity(0.3)
            }
            .resizable()
            .scaledToFit()
            .frame(width: imageWidth, height: imageHeight)
    }
    
    //MARK: - Body
    var body: some View {
        VStack {
            HStack {
                if isPreloading {
                    ActivityIndicator(isAnimating: .constant(true), style: .large, color: .systemBlue)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.blue)
                } else {
                    poster
                    
                    VStack(alignment: .center) {
                        Text(title ?? "")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .padding(5)
                            .lineLimit(2)
                        
                        Text(description ?? "")
                            .font(.system(size: 17))
                            .italic()
                            .foregroundColor(.label)
                            .lineLimit(8)
                        
                        Image(systemName: "star.fill")
                            .renderingMode(.template)
                            .foregroundColor(isFavorite ? favoriteColor : commonColor)
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 10))
                    }
                    .frame(width: imageWidth*1.5, height: imageHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
            }.padding()
        }
        .background(Color.clear)
    }
}

struct PopularMovieTableRow_Previews: PreviewProvider {
    static var previews: some View {
        PopularMovieTableRow(posterPath: "https://github.com/onevcat/Kingfisher/blob/master/images/kingfisher-1.jpg?raw=true",
                             title: "Test movie Title",
                             description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas ut aliquet nunc. Sed ac tristique nulla. Pellentesque varius mauris a elit ornare mollis. Sed nec leo sit amet lorem consectetur convallis quis sit amet lacus. Quisque dictum hendrerit congue. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Curabitur diam metus, vestibulum at rutrum et, faucibus vel libero. Vivamus nec elementum est, non bibendum risus. Maecenas viverra augue at posuere pharetra.Fusce egestas leo ac volutpat ornare. Proin molestie dictum erat vitae dignissim. Curabitur ultricies augue vel massa porttitor, eu placerat nisi malesuada. Aenean eleifend imperdiet auctor. Sed accumsan vestibulum elit ac fermentum. Nulla bibendum erat elit, bibendum aliquam velit lobortis ut. Sed non velit vitae leo dignissim venenatis. Sed suscipit orci sem, nec gravida urna vulputate nec. Nunc vulputate ultricies posuere. Curabitur egestas quam vel enim rhoncus, at pretium ligula bibendum. Cras sapien enim, aliquam sed nisi id, volutpat molestie lectus. Nulla semper urna ex, a scelerisque tortor ultricies sed. Proin eget ante pellentesque, sagittis nunc ut, fringilla arcu.",
                             isFavorite: Binding.constant(true),
                             isPreloading: false,
                             favoriteAction: nil)
    }
}
