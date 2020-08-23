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
    @Environment(\.presentationMode) var presentationMode
    @Binding var needRefresh: Bool
    
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
        .frame(width: (UIScreen.main.bounds.width - 45)/2, height: (UIScreen.main.bounds.width - 45)*1.5/2)
    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
    
    private var actionButton: some View {
        if model.isFavoriteMovie {
            return Button(action: {
                self.model.makeActionOnMovie()
                self.needRefresh.toggle()
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("REMOVE FROM FAVORITE")
            }
            .buttonStyle(PlainButtonStyle())
            .frame(minWidth: 200, maxWidth: .infinity, minHeight: 40)
            .foregroundColor(.white)
            .background(Color.systemRed)
        } else {
            return Button(action: {
                self.model.makeActionOnMovie()
                self.needRefresh.toggle()
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("ADD TO FAVORITE")
            }
            .buttonStyle(PlainButtonStyle())
            .frame(minWidth: 200, maxWidth: .infinity, minHeight: 40)
            .foregroundColor(.white)
            .background(Color.systemGreen)
        }
    }
    
    var body: some View {
        VStack {
            //Close button
            HStack{
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "multiply.circle.fill")
                        .renderingMode(.template)
                        .foregroundColor(.red)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
                }
                Spacer()
            }
            
            //Title
            Text(model.movieDetails.title ?? "")
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(nil)
                .multilineTextAlignment(.center)
            
            //Poster and Description
            HStack {
                poster
                
                Text(model.movieDetails.overview ?? "")
                    .font(.system(size: 12))
                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 10))
                    .frame(width: (UIScreen.main.bounds.width - 45)/2, height: (UIScreen.main.bounds.width - 45)*1.5/2, alignment: .top)
                    
            }
            
            // Info
            HStack {
                VStack(alignment: .trailing, spacing: 5) {
                    Group {
                        Text("Release Date: ")
                            .font(.system(size: 17))
                            .fontWeight(.medium)
                        
                        Spacer(minLength: 5)
                        
                        Text("Adult: ")
                            .font(.system(size: 17))
                            .fontWeight(.medium)
                        
                        Spacer(minLength: 5)
                        
                        Text("Popularity: ")
                            .font(.system(size: 17))
                            .fontWeight(.medium)
                        
                        Spacer(minLength: 5)
                        
                        Text("Votes: ")
                            .font(.system(size: 17))
                            .fontWeight(.medium)
                        
                        Spacer(minLength: 5)
                        
                        Text("Votes Average: ")
                            .font(.system(size: 17))
                            .fontWeight(.medium)
                    }
                }.fixedSize(horizontal: true, vertical: false)
                
                VStack(alignment: .leading, spacing: 5) {
                    Group {
                        Text(model.movieDetails.release_date ?? "")
                            .font(.system(size: 17))
                            .italic()
                        
                        Spacer(minLength: 5)
                        
                        Text(model.movieDetails.adult ?? false ? "YES": "NO")
                            .font(.system(size: 17))
                            .italic()
                        
                        Spacer(minLength: 5)
                        
                        Text("\(model.movieDetails.popularity ?? 0, specifier: "%.2f")")
                            .font(.system(size: 17))
                            .italic()
                        
                        Spacer(minLength: 5)
                        
                        Text("\(model.movieDetails.vote_count ?? 0)")
                            .font(.system(size: 17))
                            .italic()
                        
                        Spacer(minLength: 5)
                        
                        Text("\(model.movieDetails.vote_average ?? 0, specifier: "%.2f")")
                            .font(.system(size: 17))
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
            useCases: Services(environment: AppEnvironment.development(.normal)), coordinator: FaforiteMoviesCoordinator(useCases: Services(environment: AppEnvironment.development(.normal))), action: nil), needRefresh: .constant(false))
    }
}
