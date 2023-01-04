//
//  ContentView.swift
//  BinersDetector
//
//  Created by Mataranga, Vlad on 08.11.2022.
//

import SwiftUI
import PhotosUI
import Combine

enum TestEnum {
    case one
    case two
    case three(SecondEnumTest)
}

enum SecondEnumTest {
    case test1
    case test2
}

class MainVMTest: ObservableObject {
    @Published var test: TestEnum
    
    init(test: TestEnum) {
        self.test = test
    }
}

final class VMTest: ObservableObject {
    let test: SecondEnumTest
    
    init(test: SecondEnumTest) {
        self.test = test
    }
}


struct VMTestContentView: View {
    
    var viewModel: VMTest
    
    var body: some View {
        content
    }
    
    @ViewBuilder
    var content: some View {
        switch viewModel.test {
        case .test1:
            Text("Test 1")
        case .test2:
            Text("Test 2")
        }
    }
}

struct ContentView: View {
    @State var isCameraOpen: Bool = false
    @State var isReportScreenOpen: Bool = false
    @State var selectedImage: UIImage?
    
    @StateObject var viewModel: MainVMTest = .init(test: .one)
    
    let classifierManager: ClassifierManager = .init()
    
    var body: some View {
        background
            .overlay(scrolView)
            .sheet(isPresented: $isCameraOpen) {
                ImagePicker(selectedImage: $selectedImage)
            }
            .sheet(isPresented: $isReportScreenOpen) {
                ReportWrongClasificationView() {
                    selectedImage = nil
                }
            }
    }
    
    @ViewBuilder
    var testView: some View {
        switch viewModel.test {
        case .one, .two:
            Button("One", action: {
                viewModel.test = .one
            })
        case .three(let value):
            VMTestContentView(viewModel: VMTest(test: value))
        }
    }
    
    var buttonsView: some View {
        VStack {
            Button("Three 1", action: {
                viewModel.test = .three(.test1)
            })
            Button("Three 2", action: {
                viewModel.test = .three(.test2)
            })
        }
    }
    
    var scrolView: some View {
        ScrollView {
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    
                    if let _ = selectedImage {
                        detailsView
                    } else {
                        testView
                        buttonsView
                        scaneView
                    }
                   
                    Spacer()
                }
                Spacer()
            }
        }
    }
    
    var detailsView: some View {
        VStack {
            Group {
                HStack {
                    Spacer()
                    if let image = selectedImage,
                       let type = classifierManager.classifiImage(image) {
                        BinerDetailsView(binerType: type)
                    } else {
                        Text("Can't detect your biner.")
                    }
                    Spacer()
                }.padding()
                    .background(Color.white)
                .cornerRadius(20)
                
                
                AppButton(title: "Scan another carabiner", color: .blue) { isCameraOpen = true }
                AppButton(title: "Report wrong clasification", color: .red) { isReportScreenOpen = true }
            }.shadow(radius: 20)
        }.frame(width: UIScreen.main.bounds.width - 50)
    }
    
    var scaneView: some View {
        VStack {
            Spacer(minLength: 250)
            VStack {
                ZStack {
                    Circle()
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                        .frame(width: 100, height: 100)
                    
                    Image(systemName: "camera.circle")
                        .resizable()
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            .linearGradient(colors: [Color(UIColor.lightGray), Color(UIColor.darkGray)], startPoint: .topLeading, endPoint: .bottomTrailing),
                            .linearGradient(colors: [Color(UIColor.lightGray), Color(UIColor.darkGray)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 100, height: 100)
                }
                
                Text("Use the camera to scan a carabiner.")
                    .lineLimit(1)
                    .bold()
                    .foregroundColor(Color(UIColor.darkGray))
            }
            .padding(30)
            .background(Color.white)
            .cornerRadius(20)
            AppButton(title: "Scan", color: .blue) {
                isCameraOpen = true
            }
        }.frame(width: 320)
        .shadow(radius: 20)
    }
    
    var background: some View {
        Image("background")
            .resizable()
            .blur(radius: 2)
            .opacity(0.35)
    }
}
