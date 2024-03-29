//
//  DetailsScreenView.swift
//  PopularMoviesSwiftUI
//
//  Created by Alex2 on 20.08.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import SwiftUI
import Core
import KingfisherSwiftUI

struct DetailsScreenView: View {
    
    @ObservedObject var model: DetailsScreenViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isFavorite: Bool
    
    var widthForPoster: CGFloat = 200
    let fontSize: CGFloat = 17
    let spacing: CGFloat = 5
    
    private var poster: some View {
        let url = URL(string: model.posterPath ?? "")
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
            .frame(width: widthForPoster, height: widthForPoster*1.5)
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
    
    private var actionButton: some View {
        if isFavorite {
            return Button(action: {
                buttonAction()
            }) {
                Text("REMOVE FROM FAVORITE")
            }
            .buttonStyle(PlainButtonStyle())
            .frame(minWidth: 200, minHeight: 40)
            .foregroundColor(.white)
            .background(Color.systemRed)
        } else {
            return Button(action: {
                buttonAction()
            }) {
                Text("ADD TO FAVORITE")
            }
            .buttonStyle(PlainButtonStyle())
            .frame(minWidth: 200, minHeight: 40)
            .foregroundColor(.white)
            .background(Color.systemGreen)
        }
    }
    
    var body: some View {
        VStack {
            //Title
            Text(model.movieDetails.title ?? "")
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .padding(EdgeInsets(top: 50, leading: 15, bottom: 0, trailing: 15))
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(nil)
                .multilineTextAlignment(.center)
            
            //Poster and Description
            HStack {
                poster
                
                VStack {
                    
                    Text(model.movieDetails.overview ?? "")
                        .font(.system(size: 12))
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 10))
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                }
            }
            
            // Info
            HStack {
                VStack(alignment: .trailing, spacing: spacing) {
                    Group {
                        Text("Release Date: ")
                            .font(.system(size: fontSize))
                            .fontWeight(.medium)
                        
                        Spacer(minLength: spacing)
                        
                        Text("Adult: ")
                            .font(.system(size: fontSize))
                            .fontWeight(.medium)
                        
                        Spacer(minLength: spacing)
                        
                        Text("Popularity: ")
                            .font(.system(size: fontSize))
                            .fontWeight(.medium)
                        
                        Spacer(minLength: spacing)
                        
                        Text("Votes: ")
                            .font(.system(size: fontSize))
                            .fontWeight(.medium)
                        
                        Spacer(minLength: spacing)
                        
                        Text("Votes Average: ")
                            .font(.system(size: fontSize))
                            .fontWeight(.medium)
                    }
                }.fixedSize(horizontal: true, vertical: false)
                
                VStack(alignment: .leading, spacing: 5) {
                    Group {
                        Text(model.movieDetails.release_date ?? "")
                            .font(.system(size: fontSize))
                            .italic()
                        
                        Spacer(minLength: spacing)
                        
                        Text(model.movieDetails.adult ?? false ? "YES": "NO")
                            .font(.system(size: fontSize))
                            .italic()
                        
                        Spacer(minLength: spacing)
                        
                        Text("\(model.movieDetails.popularity ?? 0, specifier: "%.3f")")
                            .font(.system(size: fontSize))
                            .italic()
                        
                        Spacer(minLength: spacing)
                        
                        Text("\(model.movieDetails.vote_count ?? 0)")
                            .font(.system(size: fontSize))
                            .italic()
                        
                        Spacer(minLength: spacing)
                        
                        Text("\(model.movieDetails.vote_average ?? 0, specifier: "%.1f")")
                            .font(.system(size: fontSize))
                            .italic()
                    }
                }.fixedSize(horizontal: true, vertical: false)
            }.fixedSize().padding()
            
            // Action Button
            HStack {
                Spacer(minLength: 30)
                actionButton
                    .cornerRadius(20)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
                
                Spacer(minLength: 30)
            }
            Spacer()
        }
        .frame(minWidth: 400, minHeight: 600)
    }
    
    private func buttonAction() {
        model.makeActionOnMovie()
        isFavorite.toggle()
    }
    
    private func appName() -> String? {
        guard let dictionary = Bundle.main.infoDictionary else { return nil }
        if let version: String = dictionary["CFBundleName"] as? String {
            return version
        } else {
            return nil
        }
    }
}

#if DEBUG
struct DetailsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsScreenView(model: DetailsScreenViewModel(
                            movieDetails: PopularMovie(poster_path: "https://github.com/onevcat/Kingfisher/blob/master/images/kingfisher-1.jpg?raw=true",
                                                       adult: false,
                                                       overview: "Overview",
                                                       release_date: "Date",
                                                       genre_ids: nil,
                                                       id: 1,
                                                       original_title: "original_title",
                                                       original_language: "Eng",
                                                       title: "Title",
                                                       backdrop_path: "",
                                                       popularity: 100,
                                                       vote_count: 11,
                                                       video: false,
                                                       vote_average: 6),
                            isFavoriteMovie: false,
                            useCases: Services(environment: AppEnvironment.development(.normal)), action: nil), isFavorite: false)
    }
}
#endif
