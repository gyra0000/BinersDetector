//
//  ReportWrongClasificationView.swift
//  BinersDetector
//
//  Created by Mataranga, Vlad on 09.11.2022.
//

import SwiftUI

struct ReportWrongClasificationView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    @State var isFeedbackSubscribed: Bool = false
    
    let didSendFeedback: () -> Void
    
    let biners: [BinerType] = [.bealOrientExpres,.petzlSmd]
    
    var body: some View {
        if isFeedbackSubscribed {
            thanksForFeedback
        } else {
            askForFeedback
        }
       
    }
    
    var askForFeedback: some View {
        VStack {
            VStack {
                Group {
                    Text("Your feedback help us to improve your experience.")
                    Text("Please choose the true model that you scanned.")
                }.foregroundColor(.gray)
            }.padding()
                .padding(.top, 30)
           
            
            List {
                ForEach(biners) {
                    ReportCell(biner: $0.getBiner())
                }
            }
            AppButton(title: "Send your feedback", color: .blue) {
                didSendFeedback()
                isFeedbackSubscribed = true
            }.padding()
        }
    }
    
    var thanksForFeedback: some View {
        
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: "checkmark.circle")
                .resizable()
                .foregroundColor(.green)
                .frame(width: 70, height: 70)
            Text("Thank you for the feedback.")
                .font(.title2)
                .bold()
                .foregroundColor(.gray)
            Spacer()
            
            AppButton(title: "Close", color: .red, action: { presentationMode.wrappedValue.dismiss() })
                .padding()
        }
       
    }
}

struct ReportCell: View {
    
    let biner: Biner
    @State var isSelected: Bool = false
    
    var body: some View {
        HStack {
            Image(biner.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            Image(biner.brand.getImageName())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            Text(biner.name)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
                    .resizable()
                    .bold()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(.green)
            }
        }
        .onTapGesture {
            isSelected.toggle()
        }
    }
}
