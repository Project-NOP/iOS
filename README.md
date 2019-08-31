# NOP - iOS App

### 개요
불매운동 플랫폼 서비스 iOS 앱 클라이언트 Repo입니다.

### 사용 기술
Swift를 통해 개발을 진행했으며 RxSwift + MVVM 패턴으로 개발이 진행되었습니다.

**바코드 인식**  
iOS의 AVFoundation을 사용하여 바코드를 인식하도록 개발하였습니다.

**Social Auth**  
Firebase에서 제공하는 FirebaseAuthUI를 바탕으로 개발하였으며
현재 Google, Facebook, Twitter의 Social Auth를 지원합니다.

**Network**  
Moya의 RxMoya를 기반으로 개발하였습니다.

기타 각각의 Animation, UI 작업은 UIKit의 도움을 받아 개발하였습니다.
