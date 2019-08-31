//
//  Dummy.swift
//  Combine6
//
//  Created by 이병찬 on 01/09/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import Foundation

struct BrandDummy {
    let all: [Brand] = [
        Brand(name: "나이키", description: "세계 최고의 의류회사", imageURL: URL(string: "https://i.pinimg.com/originals/f4/9e/5a/f49e5a68589a4fc5193c583a482a29a0.png")!),
        Brand(name: "애플", description: "실리콘 밸리 하드웨어 제작회사", imageURL: URL(string: "https://storage.googleapis.com/webdesignledger.pub.network/WDL/maxresdefault.jpg")!),
        Brand(name: "소니", description: "일본 하드웨어 제작회사", imageURL: URL(string: "https://www.freevector.com/uploads/vector/preview/3324/FreeVector-Sony-Vector-Logo.jpg")!),
        Brand(name: "디즈니", description: "미국 애니메이션 제작회사", imageURL: URL(string: "https://pmcvariety.files.wordpress.com/2018/03/disney-logo.jpg?w=1000")!),
        Brand(name: "이케아", description: "미국 가구회사", imageURL: URL(string: "https://static.dezeen.com/uploads/2019/04/ikea-logo-new-hero-1.jpg")!),
        Brand(name: "금성침대", description: "한국 가구회사", imageURL: URL(string: "http://yerimdni.com/files/attach/images/131/829/ed208f44e242b3678c282b4f54549025.gif")!),
        Brand(name: "델몬트", description: "과일 전문회사", imageURL: URL(string: "http://photos.prnewswire.com/prn/20140314/NY82883LOGO-a")!),
        Brand(name: "시스코", description: "세계 최고 네트워크 제작회사", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Cisco_logo_blue_2016.svg/1200px-Cisco_logo_blue_2016.svg.png")!),
        Brand(name: "세콤", description: "일본 보안 전문회사", imageURL: URL(string: "https://www.logosurfer.com/wp-content/uploads/2018/03/Secom.png")!),
        Brand(name: "언더아머", description: "삼대 500 이상 입을 수 있는 의류회사", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Under_armour_logo.svg/1200px-Under_armour_logo.svg.png")!),
        Brand(name: "스파오", description: "국내 의류 회사", imageURL: URL(string: "https://i.pinimg.com/originals/93/38/a3/9338a36099ed3d5a444acd20b8b7b45a.jpg")!)
    ]
    
    let japan: [Brand] = [
        Brand(name: "유니클로", description: "일본 의류회사", imageURL: URL(string: "http://15.ie/wp-content/uploads/2016/03/UniQlo-Logo.jpg")!),
        Brand(name: "캐논", description: "일본 카메라 제작회사", imageURL: URL(string: "https://global.canon/en/corporate/logo/img/logo_01.png")!),
        Brand(name: "닌텐도", description: "일본 게임&게임기 제조회사", imageURL: URL(string: "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/d2a7fa0d-5fd4-4d4d-a4c9-c673b80862d4/dbjyfvc-82c7a4e1-e499-4b97-9c60-aa94b16b4753.png/v1/fill/w_1024,h_387,strp/nintendo_logo_transparent_by_epycwyn_dbjyfvc-fullview.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9Mzg3IiwicGF0aCI6IlwvZlwvZDJhN2ZhMGQtNWZkNC00ZDRkLWE0YzktYzY3M2I4MDg2MmQ0XC9kYmp5ZnZjLTgyYzdhNGUxLWU0OTktNGI5Ny05YzYwLWFhOTRiMTZiNDc1My5wbmciLCJ3aWR0aCI6Ijw9MTAyNCJ9XV0sImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl19.o4pFRxPxzxuj1PYgiQtuHG2A3T5RjGY2VUFI7EToHK4")!),
        Brand(name: "ABC마트", description: "일본 신발 아울렛매장", imageURL: URL(string: "https://sapporofactory.jp/img/factory/store/storage/w1000xh1000/2_3f_abcmartmega_logo.jpg")!),
    ]
}

struct ProductDummy {
    let pocari = Product(name: "포카리스웨트", imageURL: URL(string: "https://t1.daumcdn.net/cfile/tistory/9916743359DED58528?download")!)
    let ionTheFit = Product(name: "IonTheFit", imageURL: URL(string: "https://post-phinf.pstatic.net/MjAxOTA0MjlfMjc3/MDAxNTU2NTA0NDc5MTIy.je-3OkldkItsMFBHWZlF3z-Dyxd6YqTokpmiADWNKlsg.zQIdyFfXaBuF0y03rZT9HqXT2Rkc2aVxa9uzSWjuV3sg.PNG/image.png?type=w1200")!)
}
