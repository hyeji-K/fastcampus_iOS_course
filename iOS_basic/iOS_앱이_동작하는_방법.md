# iOS 앱이 동작하는 방법 (App's Life Cycle)

앱이 foreground 혹은 background에 있을 때, 시스템 알림에 응답하고 기타 중요한 시스템 관련 이벤트를 처리함

(foreground) 사용자가 앱을 실행하면, 시스템은 그 앱에게 리소스를 몰아줌

(background) 가능한 한 적은 작업을 수행하거나 아무 것도 하지 않는 게 좋음

이렇게 앱의 상태가 변경 됨에 따라 대응 할 수 있게 앱을 만들어주어야 함

앱의 상태가 변경되면 UIKit은 적절한 delegate object methods를 호출하여 알려줌

- iOS 13 이상에서는 UISceneDelegate 객체를 사용하여 scene-based app의 life-cycle 이벤트에 응답함

- iOS 12 및 이전 버전에서는 UIApplicationDelegate 객체를 사용하여 life-cycle 이벤트에 응답함

## Respond to Scene-Based Life-Cycle Events

UIKit은 각각에 대해 별도의 수명 주기 이벤트를 제공합니다. scene은 기기에서 실행되는 앱 UI의 한 인스턴스를 나타냅니다. 사용자는 각 앱에 대해 여러 장면을 만들고 별도로 표시하거나 숨길 수 있습니다. 각 장면에는 고유한 수명 주기가 있기 때문에 각각 다른 실행 상태에 있을 수 있습니다.

이는 선택 기능이며 활성화하려면 [Specifying the Scenes Your App Supports](https://developer.apple.com/documentation/uikit/app_and_environment/scenes/specifying_the_scenes_your_app_supports)에 설명된 대로 UIApplicationSceneManifest 키를 앱의 Info.plist 파일에 추가하세요.

The following figure shows the state transitions for scenes. When the user or system requests a new scene for your app, UIKit creates it and puts it in the unattached state. User-requested scenes move quickly to the foreground, where they appear onscreen. A system-requested scene typically moves to the background so that it can process an event. For example, the system might launch the scene in the background to process a location event. When the user dismisses your app's UI, UIKit moves the associated scene to the background state and eventually to the suspended state. UIKit can disconnect a background or suspended scene at any time to reclaim its resources, returning that scene to the unattached state.

![image](https://github.com/hyeji-K/fastcampus_iOS_course/blob/main/image/scene-state.png)