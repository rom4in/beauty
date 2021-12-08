//
//  PhotoView.swift
//  beauty
//
//  Created by Ubicolor on 07/12/2021.
//

import SwiftUI

struct PhotoView: View {
    
    @State var photo: Photo
    @State private var showButtons = false
    @State private var showAR = false
    
    var body: some View {
        
        ZStack {
            asyncPhoto
                .padding(.horizontal)
                .padding(.bottom)
                .shadow(color: Color(hex: photo.averageColor), radius: 10, y: 10)
                .onTapGesture {
                    showButtons.toggle()
                }
            if showButtons {
                withAnimation {
                    buttonsView
                }
            }
        }
        
    }
    
    var buttonsView: some View {
        
        HStack(spacing: 30) {
            
            Button {
                shareSheet()
            } label: {
                Image(systemName: "square.and.arrow.up")
            }
            
            
            Button {
                showAR = true
            } label: {
                Image(systemName: "arkit")
            }
            .sheet(isPresented: $showAR, onDismiss: { showAR = false ; showButtons = false }) {
                ARView(photo: photo).ignoresSafeArea()
            }
            
        }.buttonStyle(PhotoShareButtonStyle())
    }
    
    var asyncPhoto: some View {
        AsyncImage(url: URL(string: photo.src[Photo.Size.large.rawValue]!),
                   transaction: Transaction(animation: .easeIn)) { phase in
            switch phase {
            case .empty:
                ZStack {
                    Color(hex: photo.averageColor)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                }.aspectRatio(photo.ratio, contentMode: .fit)
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(photo.ratio, contentMode: .fit)
                    .transition(.scale(scale: 1.05, anchor: .center).combined(with: .opacity).animation(.easeInOut))
                    .blur(radius: showButtons ? 20 : 0)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .animation(.easeInOut(duration: 0.2), value: showButtons)
                
            case .failure(_):
                ZStack {
                    Color(hex: photo.averageColor)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    Image(systemName: "square.stack.3d.down.right.fill")
                        .font(.largeTitle)
                }.aspectRatio(Double(photo.width)/Double(photo.height), contentMode: .fit)
            @unknown default: EmptyView()
            }
        }
                  
    }
    
    private func shareSheet() {
        
                guard let photoString = photo.src[Photo.Size.large.rawValue],
                      let url = URL(string: photoString ),
                      let image = try? Data(contentsOf: url)
                else { return }

        
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        UIApplication.shared.currentUIWindow()?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
}
