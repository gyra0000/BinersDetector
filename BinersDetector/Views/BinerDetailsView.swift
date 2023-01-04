//
//  BinerDetailsView.swift
//  BinersDetector
//
//  Created by Mataranga, Vlad on 09.11.2022.
//

import SwiftUI

struct BinerDetailsView: View {
    
    let biner: Biner
    
    init(binerType: BinerType) {
        self.biner = binerType.getBiner()
    }
    
    var body: some View {
        content
    }
     
    var content: some View {
        VStack {
            VStack {
                VStack(spacing: 5) {
                    Text("Name")
                        .title()
                        .offset(y: 5)
                    
                    Text(biner.name)
                        .font(.largeTitle)
                        .bold()
                    
                    ZStack {
                        Circle()
                            .fill(Gradient(colors: [Color(UIColor.lightGray), .gray]))
                            .shadow(radius: 7)
                            .frame(width: 157, height: 157)
                        
                        Image(biner.imageName)
                            .resizable()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                    }
                }
                
                VStack(spacing: 5) {
                    Text("Producer")
                        .title()
                    
                    Image(biner.brand.getImageName())
                        .resizable()
                        .frame(width: 100, height: 55)
                        .offset(y: -5)
                }
                
                VStack(spacing: 5) {
                    Text("Strenght")
                        .title()
                    
                    VStack(spacing: 0) {
                        HStack(spacing: 30) {
                            Image("majorAxis")
                            Image("minorAxis")
                            Image("openGate")
                        }
                        HStack(spacing: 45) {
                            Group {
                                Text("\(biner.majorAxis) kN")
                                Text("\(biner.minorAxis) kN")
                                Text("\(biner.openGate) kN")
                            }.bold()
                        }
                    }
                    
                }
                
                VStack(spacing: 5) {
                    Text("Safty Standars")
                        .title()
                    Group {
                        ForEach(biner.certifications) { Text($0.rawValue) }
                    }.bold()
                }.padding(.top, 10)
                 
                if let url = URL(string: biner.link) {
                    Link(destination: url) {
                        Text("Producer website")
                    }.bold()
                    .padding(.top, 10)
                }
            }
        }
    }
}
