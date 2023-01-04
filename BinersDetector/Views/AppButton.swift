//
//  AppButton.swift
//  BinersDetector
//
//  Created by Mataranga, Vlad on 09.11.2022.
//

import SwiftUI

struct AppButton: View {
    
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Text(title)
                    .foregroundColor(.white)
                    .bold()
                Spacer()
            }
            .padding()
            .background(color)
            .cornerRadius(20)
           
        }
    }
}
