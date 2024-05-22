//
//  QRCameraView.swift
//  QVick
//
//  Created by dgsw8th16 on 1/23/24.
//

import SwiftUI
import Alamofire

struct QRCameraView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var inputImage: UIImage?
    @StateObject var cameraVM = QRCameraViewModel()
    
    let valueFromController = NotificationCenter.default.publisher(for: NSNotification.Name("QR Scan"))
    
    var body: some View {
        QRCameraRepresentable(image: $inputImage, value: $cameraVM.value)
            .onReceive(valueFromController) { (output) in
                
                let value = output.object as? String ?? ""
                
                if value != "" {
                    
                    
                    cameraVM.isCompleted = {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    
                    cameraVM.attendance(value: value)
                }
            }
            .overlay {
                VStack(spacing: 40) {
                    HStack {
                        Spacer()
                        
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.pretendard(.bold, 20))
                                .foregroundStyle(Color.black)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Text("QR 코드를 인식하여 출석체크를 해 주세요")
                        .font(.pretendard(.bold, 16))
                    
                    Image("QRFrame")
                    
                    Spacer()
                }
                .padding(.vertical, 10)
            }
    }
}
