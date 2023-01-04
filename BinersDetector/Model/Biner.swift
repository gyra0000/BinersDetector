//
//  Biner.swift
//  BinersDetector
//
//  Created by Mataranga, Vlad on 09.11.2022.
//

enum Brand {
    case petzl
    case beal
    
    func getImageName() -> String {
        switch self {
        case .petzl:
            return "petzl"
        case .beal:
            return "beal"
        }
    }
}

enum Certification: String, CaseIterable, Identifiable {
    var id: String { return self.rawValue }
    
    case EN362_2004_B = "EN 362: 2004 B"
    case EN12275_2013_B_H = "EN 12275: 2013 B/H"
    case UIAA = "UIAA"
}

struct Biner {
    let name: String
    let imageName: String
    let brand: Brand
    let majorAxis: Int
    let minorAxis: Int
    let openGate: Int
    let certifications: [Certification]
    let link: String
    
//    init(name: String,
//         imageName: String,
//         brand: Brand = .petzl,
//         majorAxis: Int = 0,
//         minorAxis: Int = 0,
//         openGate: Int,
//         certifications: [Certification] = [],
//         link: String = "") {
//        self.name = name
//        self.imageName = imageName
//        self.brand = brand
//        self.majorAxis = majorAxis
//        self.minorAxis = minorAxis
//        self.openGate = openGate
//        self.certifications = certifications
//        self.link = link
//    }
}
