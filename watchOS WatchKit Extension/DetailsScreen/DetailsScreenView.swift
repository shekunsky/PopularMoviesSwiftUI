//
//  DetailsScreenView.swift
//  PopularMoviesSwiftUI
//
//  Created by Alex2 on 20.08.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import SwiftUI
import Core_watchOS
import KingfisherSwiftUI

struct DetailsScreenView: View {
    
    @ObservedObject var model: DetailsScreenViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var widthForPoster: CGFloat { ScreenSize.deviceWidth - 100 }
    let fontSize: CGFloat = 13
    
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
        if model.isFavoriteMovie {
            return Button(action: {
                model.makeActionOnMovie()
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("REMOVE FROM FAVORITE")
                    .font(.system(size: 14))
                    .fontWeight(.medium)
            }
            .buttonStyle(PlainButtonStyle())
            .frame(minWidth: 100, maxWidth: .infinity, minHeight: 40)
            .foregroundColor(.white)
            .background(Color.systemRed)
        } else {
            return Button(action: {
                model.makeActionOnMovie()
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("ADD TO FAVORITE")
                    .font(.system(size: 14))
                    .fontWeight(.medium)
            }
            .buttonStyle(PlainButtonStyle())
            .frame(minWidth: 100, maxWidth: .infinity, minHeight: 40)
            .foregroundColor(.white)
            .background(Color.systemGreen)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 5) {
                
                //Title
                Text(model.movieDetails.title ?? "")
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.blue)
                
                //Poster
                poster
                
                //description
                Text(model.movieDetails.overview ?? "")
                    .font(.system(size: 12))
                    .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                    .lineLimit(nil)
                
                // Info
                HStack {
                    VStack(alignment: .trailing, spacing: 5) {
                        Group {
                            Text("Release Date: ")
                                .font(.system(size: fontSize))
                                .fontWeight(.medium)
                            
                            Spacer(minLength: 5)
                            
                            Text("Adult: ")
                                .font(.system(size: fontSize))
                                .fontWeight(.medium)
                            
                            Spacer(minLength: 5)
                            
                            Text("Popularity: ")
                                .font(.system(size: fontSize))
                                .fontWeight(.medium)
                            
                            Spacer(minLength: 5)
                            
                            Text("Votes: ")
                                .font(.system(size: fontSize))
                                .fontWeight(.medium)
                            
                            Spacer(minLength: 5)
                            
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
                            
                            Spacer(minLength: 5)
                            
                            Text(model.movieDetails.adult ?? false ? "YES": "NO")
                                .font(.system(size: fontSize))
                                .italic()
                            
                            Spacer(minLength: 5)
                            
                            Text("\(model.movieDetails.popularity ?? 0, specifier: "%.3f")")
                                .font(.system(size: fontSize))
                                .italic()
                            
                            Spacer(minLength: 5)
                            
                            Text("\(model.movieDetails.vote_count ?? 0)")
                                .font(.system(size: fontSize))
                                .italic()
                            
                            Spacer(minLength: 5)
                            
                            Text("\(model.movieDetails.vote_average ?? 0, specifier: "%.1f")")
                                .font(.system(size: fontSize))
                                .italic()
                        }
                    }.fixedSize(horizontal: true, vertical: false)
                }.fixedSize().padding()
                
                // Action Button
                HStack {
                    actionButton
                        .cornerRadius(20)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                }
            }
        }
    }
}

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
                            useCases: Services(environment: AppEnvironment.development(.normal)), action: nil))
    }
}
