//
//  SwiftyBeaver+.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/19/25.
//

import Foundation
import SwiftyBeaver

public let MANGO = SwiftyBeaver.self

public func configureSwiftyBeaver() {
    let console = ConsoleDestination()
    
    
    /*
     $C: 로그 레벨에 따른 색상 태그입니다. 이는 콘솔 출력에서 로그 레벨을 시각적으로 구분하기 위한 것입니다.
     $c: 로그 레벨의 축약된 이름(예: "💚 DEBUG")을 표시합니다.
     $L: 로그를 호출한 함수 또는 메소드의 이름입니다.
     $N: 로그를 호출한 클래스 또는 네임스페이스의 이름입니다.
     [Line $l]: 로그를 호출한 소스 코드의 라인 번호입니다
     $M: 실제 로그 메시지 내용입니다.
     $F: 함수 이름
     */
    
    
    console.format = "$Dyyyy-MM-dd HH:mm:ss.SSS$d $C[$L] 🌼 $N 🖼️ $F [Line $l] $M"
    SwiftyBeaver.addDestination(console)
}
