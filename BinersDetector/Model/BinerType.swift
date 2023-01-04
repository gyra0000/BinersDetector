//
//  BinerType.swift
//  BinersDetector
//
//  Created by Mataranga, Vlad on 09.11.2022.
//

enum BinerType: Identifiable {
    var id: String { return self.getBiner().name }
    
//    case petzlWilliam
    case bealOrientExpres
    case petzlSmd
    
    func getBiner() -> Biner {
        switch self {
        case .petzlSmd:
            return Biner(name: "Sm'D TL",
                         imageName: "petzlSmd",
                         brand: .petzl,
                         majorAxis: 23,
                         minorAxis: 8,
                         openGate: 7,
                         certifications: Certification.allCases,
                         link: "https://www.petzl.com/INT/en/Sport/Carabiners-and-quickdraws/Sm-D")
//        case .petzlWilliam:
//            return Biner(name: "William",
//                         imageName: "petzlWilliam",
//                         brand: .petzl,
//                         majorAxis: 27,
//                         minorAxis: 8,
//                         openGate: 8,
//                         certifications: Certification.allCases,
//                         link: "https://www.petzl.com/US/en/Sport/Carabiners-and-quickdraws/WILLIAM")
        case .bealOrientExpres:
            return Biner(name: "Orient Express",
                         imageName: "bealOrientExpress",
                         brand: .beal,
                         majorAxis: 25,
                         minorAxis: 7,
                         openGate: 7,
                         certifications: [.EN12275_2013_B_H, .UIAA],
                         link: "https://www.beal-planet.com/en/karabiners/1499-9246-orient-express.html")
        }
    }
}
