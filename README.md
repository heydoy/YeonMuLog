![표지](https://user-images.githubusercontent.com/51395335/196216841-b89e4883-09ab-4df0-aa5b-dd88f4f6a4c3.png)


# 연뮤로그, 연극과 뮤지컬을 기록합니다.
- 사용 언어: `Swift`
- 디자인 패턴 및 사용한 프레임워크: `MVC` | `UIKit` 
- 라이브러리: `Snapkit` `Then` `Realm` `Alamofire` `Charts` `Toast` `Firebase Cloud Messaging` `Firebase Analytics & Crashlytics` `SwiftLint`
- 사용 API: [공연예술통합전산망 KOPIS API](https://www.kopis.or.kr/por/cs/openapi/openApiList.do?menuId=MNU_00074&tabId=tab1_2)
- 사용한 툴: `Xcode` `Figma` `Notion`

### [📝 기획서 링크](https://kimdee.notion.site/9b7be1912159480faa66935928db5870) 
### [📲 앱스토어 링크](https://apps.apple.com/us/app/%EC%97%B0%EB%AE%A4%EB%A1%9C%EA%B7%B8/id6443663023)

<br>

## 업데이트 기록
| 버전 | 날짜 | 업데이트 내용 | 
| --  | --- | --|
| 1.1.16 | 2022.12.08 | ・ 리뷰완료 토스트 메시지에 다국어 적용이 안된 부분을 수정<br>・ 리뷰 셀과 버튼 레이아웃 제약조건을 수정하여 UI 요소가 짤리거나 겹치지 않도록 수정 |
| 1.1.15 | 2022.11.27 | ・ 기존 콜렉션뷰를 테이블뷰로 바꾸고 셀 오토레이아웃 설정을 수정하여, 리뷰가 길어질 경우 trailing이나 셀 크기가 적용 안되는 부분을 수정 <br>・ 리뷰에서 최상단으로 가는 버튼을 추가하여 리뷰내용이 많아져도 바로 위로 올라갈 수 있게 함.<br>・ 리뷰 작성 시 가장 최신 리뷰로 테이블뷰 위치를 스크롤하여 사용성을 개선 |
| 1.1.13 | 2022.11.19 | ・ 네트워크 문제로 중복 생성된 파일 제거, 쓰지 않는 코드 및 불필요한 주석 제거 |
| 1.1.12  | 2022.11.07 | ・ 캐스팅이 없을 경우의 컨디셔널 렌더링 <br>・ '관극추가'화면에서 캐스팅 숫자에 따라 영역이 가변적으로 보이게 수정 |
| 1.1.11  | 2022.11.04 | ・ `SwipeableTabBar`를 적용하여 탭바에서 스와이프를 통해 다른 탭으로 이동할 수 있게 변경<br>・ 통계와 관극기록 추가화면에서 다국어(영어)가 적용안된 부분을 개선 |
| 1.1.9  | 2022.10.30 | ・ 관극기록을 제목순, 관극날짜순으로 정렬할 수 있도록 `Realm` 데이터베이스에 필터링하여 fetch 해오는 로직 추가 <br>・ 검색을 통해 캐스팅, 극 제목, 장소, 리뷰가 일치하는 필터링 메서드를 네비게이션 아이템으로 추가. <br>・ 앱 무드와 어울리도록 기존의 기본 시스템  |
| 1.1.6  | 2022.10.28 | ・ 관극기록 목록 화면에서 Trailing 액션을 추가하여 오른쪽 스와이프를 해서 삭제할 수 있게 추가 |
| 1.1.5  | 2022.10.26 | ・ 관극기록과 리뷰 저장 화면에서 버튼을 계속 탭할 경우 중복으로 저장되는 걸 막기 위해서, 한 번 탭한 이후에 유저인터랙션을 막아서 한 번만 저장되도록 개선   |
| 1.1.4  | 2022.10.18 | ・ 관극기록 삭제 시, `Realm`에서 `List`로 추가된 리뷰를 먼저 삭제하고 관극기록을 삭제하여, 리뷰가 제거되지 않는 부분을 수정 |
| 1.1.3  | 2022.10.16 | ・ 검색 중임을 알 수 있게 공연 검색 시 로딩아이콘을 `Lottie`로 추가  |
| 1.1.2  | 2022.10.13 |  ・ `Firebase`의 `Analytics`, `Crashlitycs`를 붙여서 앱 이용기록과 충돌기록을 수집 <br>・ 푸시 알림 기능 추가 <br>・ 영어 다국어 추가<br>・ 통계 페이지의 차트색상을 앱 무드에 맞게 수정 |
| 1.0.0  | 2022.10.07 | 첫 출시!  |
