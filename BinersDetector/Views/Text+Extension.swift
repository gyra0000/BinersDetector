//
//  Text+Extension.swift
//  BinersDetector
//
//  Created by Mataranga, Vlad on 09.11.2022.
//

import SwiftUI

extension Text {
    
    func title() -> some View {
        self.font(.title2)
            .bold()
            .foregroundColor(Color(UIColor.lightGray))
    }
}
