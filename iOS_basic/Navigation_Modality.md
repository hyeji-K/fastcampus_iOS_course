# Navigation & Modality

## Modality

<div style="text-align : center;">
    <img src="https://github.com/hyeji-K/fastcampus_iOS_course/blob/main/image/Modality.png" width="400">
</div>

콘텐츠를 임시적으로 표시하는 디자인 기법 <br>
화면을 나가기 위한 명확한 행동이 요구됨 (닫기 버튼, 화면 스와이프 다운 등) <br>
사용자에게 일시적으로 집중을 요하는 컨텐츠를 표시할 때 사용하며, 중요한 정보를 주고 필요한 경우 조치를 취하도록 함 

<br>

### iOS 에서 제공해주는 시스템 모달 
- alerts
- activity views
- share sheets,
- action sheets. 

<br>

### 개발자가 직접 제공해주는 모달 (`UIModalPresentationStyle`)

**Automatic** <br>
Uses the default presentation style, typically a sheet.

**Fullscreen** <br> 
Covers the previous view, and requires a button for dismissal.

**Popover** <br>
Presents a popover in a horizontally regular environment and a sheet in compact environments.

**Page sheet and form sheet** <br> 
Partially covers the previous view; for guidance, see Sheets.

**Current context** <br> 
Covers a particular previous view.

**Custom** <br>
Uses custom animation to present content in a custom container.

<br>

### 구현
뷰컨트롤러의  **`present(_:animated:completion:)`**  메소드를 사용

<br>

## Navigation
보통 사용자들은 앱의 기능을 탐색할때, 타고 타고 들어가다가 빠져 나올때 당황하거나 어려움을 겪는 경향이 있음 <br>
이때 Navigation은 사용자가 당황하지 않게끔, 자연스럽게 지나왔던 곳을 돌아가게끔 도와주는 것

<br>

### iOS에서 주요 네비게이션 스타일 3가지
1. Hierarchical Navigation
<div style="text-align : center;">
<img src="https://github.com/hyeji-K/fastcampus_iOS_course/blob/main/image/NavigationHierarchical-Graphic_2x.png" width="400">
</div>

- 주로 화면에서 하나 선택하면 다음 화면으로 넘어감 
- 다른 화면으로 이동하려면 단계를 다시 추적하거나 처음부터 다시 시작하여 다른 선택을 해야 함
- EX. 설정앱

<br>

2. Flat Navigation

<div style="text-align : center;">
<img src="https://github.com/hyeji-K/fastcampus_iOS_course/blob/main/image/NavigationFlat-Graphic_2x.png" width="400">
</div>

- 여러 콘텐츠 카테고리 사이에서 변경되는 스타일 (탭바를 사용하는 앱)
- EX. 애플뮤직앱, 앱스토어

<br>

3. Content-Driven or Experience-Driven Navigation

<div style="text-align : center;">
<img src="https://github.com/hyeji-K/fastcampus_iOS_course/blob/main/image/NavigationExperienceDriven-Graphic_2x.png" width="400">
</div>

- 콘텐츠 자체가 네비게이션 스타일을 정의하는 스타일 (추천 로직이 들어간 앱)
- EX. 게임, 책 및 기타 몰입형 앱

<br>

| 결국 여러 스타일을 나누긴 했지만, 앱내에서는 각 스타일을 복합적으로 사용함

<br>

### 구현 

- 탭바 (**`TabbarController`**)
- 네비게이션 컨트롤러 (**`NavigationController`**)



<br>


### 참고

- https://developer.apple.com/design/human-interface-guidelines/ios/app-architecture/modality/
- https://developer.apple.com/design/human-interface-guidelines/ios/app-architecture/navigation/