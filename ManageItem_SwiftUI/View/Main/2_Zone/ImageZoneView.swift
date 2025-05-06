//
//  ImageZoneView.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/3/25.
//

import SwiftUI

struct ImageZoneView: View  {
    @EnvironmentObject var viewRouter: ViewRouter
    
    let zone: String
    
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    
    @EnvironmentObject var tabBarState: MainTabBarState
    
    
    var body: some View {
            GeometryReader { geometry in
                let screenWidth = geometry.size.width
                let screenHeight = geometry.size.height

                Image("test")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: screenWidth)
                    .scaleEffect(scale)
                    .offset(offset)
                    .gesture(
                        SimultaneousGesture(
                            MagnificationGesture()
                                .onChanged { value in
                                    scale = max(1.0, lastScale * value)
                                }
                                .onEnded { _ in
                                    lastScale = scale
                                    // 확대가 1배 이하로 내려가면 위치 리셋
                                    if scale <= 1.0 {
                                        offset = .zero
                                        lastOffset = .zero
                                    }
                                },
                            DragGesture()
                                .onChanged { value in
                                    // 확대 상태에서만 드래그 허용
                                    guard scale > 1.0 else { return }
                                    offset = CGSize(
                                        width: lastOffset.width + value.translation.width,
                                        height: lastOffset.height + value.translation.height
                                    )
                                }
                                .onEnded { _ in
                                    lastOffset = offset
                                }
                        )
                    )
                    .position(x: screenWidth / 2, y: screenHeight / 2)
            }
            .ignoresSafeArea()
            .background(Color.black)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                   
                    viewRouter.popZone()
                    
                }) {
                    Image(systemSymbol: .chevronBackward)
                        .foregroundColor(.defaultColor)
                })
            .navigationTitle("\(zone) 구역")
            .onAppear() {
                tabBarState.isHidden = true
            }
            .onDisappear() {
                tabBarState.isHidden = false
            }
        }
    
}
