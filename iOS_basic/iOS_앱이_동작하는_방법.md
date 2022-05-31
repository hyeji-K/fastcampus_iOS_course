# iOS 앱이 동작하는 방법 (App's Life Cycle)

앱이 foreground 혹은 background에 있을 때, 시스템 알림에 응답하고 기타 중요한 시스템 관련 이벤트를 처리함

(foreground) 사용자가 앱을 실행하면, 시스템은 그 앱에게 리소스를 몰아줌

(background) 가능한 한 적은 작업을 수행하거나 아무 것도 하지 않는 게 좋음

이렇게 앱의 상태가 변경 됨에 따라 대응 할 수 있게 앱을 만들어주어야 함

앱의 상태가 변경되면 UIKit은 적절한 delegate object methods를 호출하여 알려줌

- iOS 13 이상에서는 UISceneDelegate 객체를 사용하여 scene-based app의 life-cycle 이벤트에 응답함
- iOS 12 및 이전 버전에서는 UIApplicationDelegate 객체를 사용하여 life-cycle 이벤트에 응답함

## Respond to Scene-Based Life-Cycle Events

UIKit은 각각에 대해 별도의 수명 주기 이벤트를 제공하며, scene은 기기에서 실행되는 앱 UI의 한 인스턴스를 나타냄

사용자는 각 앱에 대해 여러 장면을 만들고 별도로 표시하거나 숨길 수 있음
각 장면에는 고유한 수명 주기가 있기 때문에 각각 다른 실행 상태에 있을 수 있음

이는 선택 기능이며 활성화하려면 [Specifying the Scenes Your App Supports](https://developer.apple.com/documentation/uikit/app_and_environment/scenes/specifying_the_scenes_your_app_supports)에 설명된 대로 UIApplicationSceneManifest 키를 앱의 Info.plist 파일에 추가해야 함

<img src="https://github.com/hyeji-K/fastcampus_iOS_course/blob/main/image/scene-state.png" width="400">

다음과 같은 작업을 수행함
- UIKit이 scene을 앱에 연결할 때 scene의 초기 UI를 구성하고 scene에 필요한 데이터를 로드
- foreground-active 상태로 전환할 때 UI를 구성하고 사용자와 상호 작용할 준비를 함
- foreground-active 상태를 벗어나면 데이터를 저장하고 앱의 동작을 조용하게 만듬
- background 상태에 들어가면 중요한 작업을 완료하고 최대한 많은 메모리를 확보하고 앱 스냅샷을 준비
- scene 연결 해제 시 scene과 연결된 공유 리소스를 정리
- scene 관련 이벤트 외에도 UIApplicationDelegate 객체를 사용하여 앱 시작에 응답해야 함

## Respond to App-Based Life-Cycle Events

UIKit은 모든 수명 주기 이벤트를 UIApplicationDelegate 객체에 전달 <br>
app delegate는 별도의 화면에 표시되는 창을 포함하여 앱의 모든 창을 관리 <br>
결과적으로 앱 상태 전환은 외부 디스플레이의 콘텐츠를 포함하여 앱의 전체 UI에 영향을 줌 

실행 후 시스템은 UI가 화면에 나타날지 여부에 따라 앱을 inactive 또는 background 상태로 전환 <br>
foreground로 시작할 때 시스템은 앱을 자동으로 active 상태로 전환 <br>
그 후에는 앱이 종료될 때까지 상태가 active과 background 사이에서 변동함

<img src="https://github.com/hyeji-K/fastcampus_iOS_course/blob/main/image/app-state.png" width="400">

다음과 같은 작업을 수행함
- 시작 시 앱의 데이터 구조와 UI를 초기화
- 활성화 시 UI 구성을 완료하고 사용자와 상호 작용할 준비
- 비활성화 시 데이터를 저장하고 앱의 동작을 조용하게 함
- background 상태에 들어가면 중요한 작업을 완료하고 최대한 많은 메모리를 확보하고 앱 스냅샷을 준비
- 종료 시 모든 작업을 즉시 중지하고 공유 리소스를 해제

**Not Running** - 앱이 시작되지 않았거나 실행되었지만 시스템에 의해 종료된 상태 <br>
**Inactive** - 앱이 전면에서 실행 중이지만, 아무런 이벤트를 받지 않고 있는 상태 <br>
**Active** - 앱이 전면에서 실행 중이며, 이벤트를 받고 있는 상태 <br>
**Background** - 앱이 백그라운드에 있지만 여전히 코드가 실행되고 있는 상태. 대부분의 앱은 Suspended 상태로 이행하는 도중에 일시적으로 이 상태에 진입하지만, 파일 다운로드나 업로드, 연산 처리 등 여분의 실행 시간이 필요한 경우 특정 시간 동안 이 상태로 남아 있게 되는 경우도 있음 <br>
**Suspended** - 앱이 메모리에 유지되지만 실행되는 코드가 없는 상태. 메모리가 부족한 상황이 오면 iOS 시스템은 포그라운드에 있는 앱의 여유 메모리 공간을 확보하기 위해 Suspended 상태에 있는 앱들을 특별한 알림 없이 정리함