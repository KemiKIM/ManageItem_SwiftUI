//
//  ZoneDetailView+Body.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/7/25.
//

import SwiftUI

extension ZoneDetailView {
    var body: some View {
            GeometryReader { geometry in
                let screenWidth = geometry.size.width
                let screenHeight = geometry.size.height

                Image(returnImage(zone: zone))
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
                        .foregroundColor(.mSignature)
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
