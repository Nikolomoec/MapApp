//
//  BusinessDetail.swift
//  CitySightsApp
//
//  Created by Nikita Kolomoec on 17.01.2023.
//

import SwiftUI

struct BusinessDetail: View {
    
    var business: Businesses
    @State private var showDirections = false
    
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
                    
                BusinessDesc(business: business)
                    .padding()
                
                DashedDivider()
                    .padding(.horizontal)
                
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
                    
                    DashedDivider()
                        .padding(.horizontal)
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
                    
                    DashedDivider()
                        .padding(.horizontal)
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
                DashedDivider()
                    .padding(.horizontal)
                
                Button {
                    showDirections = true
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
                .sheet(isPresented: $showDirections) {
                    DirectionsView(business: business)
                }

            }
        }
    }
}

