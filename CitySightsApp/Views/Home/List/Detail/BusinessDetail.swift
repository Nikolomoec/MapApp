//
//  BusinessDetail.swift
//  CitySightsApp
//
//  Created by Nikita Kolomoec on 17.01.2023.
//

import SwiftUI

struct BusinessDetail: View {
    
    var business: Businesses
    
    var body: some View {
        
        VStack (alignment: .leading) {
            VStack (spacing: 0) {
                GeometryReader() { geo in
                    // Main Image
                    let uiImage = UIImage(data: business.imageData ?? Data())
                    Image(uiImage: uiImage ?? UIImage())
                        .frame(width: geo.size.width, height: geo.size.height)
                        .scaledToFill()
                        .clipped()
                    
                }
                //Open/Closed indicator
                Closed_OpenState(state: business.isClosed!)
            }
            .ignoresSafeArea()
            // Desc
            Group {
                    Text(business.name ?? "")
                        .font(.largeTitle)
                        .padding(.leading)
                    
                    if business.location?.displayAddress != nil {
                        ForEach(business.location!.displayAddress!, id: \.self) { address in
                            Text(address)
                                .padding(.leading)
                        }
                    
                }
                // Rating Stars
                
                Image("regular_\(business.rating ?? 0)")
                    .padding()
                
                Divider()
                
                Group {
                    //Phone
                    HStack {
                        
                        Text("Phone:")
                            .bold()
                        Text(business.displayPhone ?? "")
                        
                        Spacer()
                        
                        Link(destination: URL(string: "tel:\(business.phone ?? "")")!) {
                            Text("Call")
                                .bold()
                        }
                        
                    }
                    .padding()
                    
                    Divider()
                    // Reviews
                    HStack {
                        
                        Text("Reviews:")
                            .bold()
                        Text(String(business.reviewCount ?? 0))
                        
                        Spacer()
                        
                        Link(destination: URL(string: "\(business.url ?? "")")!) {
                            Text("Read")
                                .bold()
                        }
                        
                    }
                    .padding()
                    
                    Divider()
                    // Website
                    HStack {
                        
                        Text("Website:")
                            .bold()
                        Text(business.url ?? "")
                            .lineLimit(1)
                        Spacer()
                        
                        Link(destination: URL(string: "\(business.url ?? "")")!) {
                            Text("Visit")
                                .bold()
                        }
                        
                    }
                    .padding()
                }
                Divider()
            // Directions Button
                Button {
                    
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(height: 48)
                            .foregroundColor(.blue)
                            .cornerRadius(10)
                        Text("Get Directions")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
                .padding()
                

            }
        }
    }
}

