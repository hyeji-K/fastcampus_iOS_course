# Combine이란?

**iOS 13.0+** 

## 동기와 비동기
동기: 요청과 그 결과가 동시에
비동기: 요청과 그 결과가 동시가 아님
비동기 예시 - 서버에서 데이터 받아와서 보여주기, 사용자의 버튼 인터랙션

## Combine을 사용하는 이유?
효율적인 비동기 처리 
A unifued, declarative API for processing values over time

## 3가지 주요 컴퍼넌트
- Publisher
- Subscriber
- Operator

### Publisher
Defines how values and errors are produced
Value type
Allows registration of a `Subscriber`
```swift
protocol Publisher {
    associatedtype Output
    associatedtype Failure: Error

    func subscribe<S: Subscriber>(_ subscriber: S)
        where S.Input == Output, S.Failure == Failure
}
```

### Subscriber
Receives values and a completion
Reference type
```swift
protocol Subscriber {
    associatedtype Input
    associatedtype Failure: Error

    func receive(subscription: Subscription)
    func receive(_ input: Input) -> Subscribers.Demand
    func receive(completion: Subscribers.Completion<Failure>)
}
```
- Assign
```swift
extension Subscribers {
    class Assign<Root, Input>: Subscriber, Cancellable {
        typealias Failure = Never
        init(object: Root, keyPath: ReferenceWritableKeyPath<Root, Input>)
    }
}
```

### Subscriber & Publisher Pattern

<div align="center">
<img src="https://github.com/hyeji-K/fastcampus_iOS_course/blob/main/image/Combine.png" width="800">
</div>

### Operator
Adopts `Publisher`
Describes a behavior for changing values
Subscribes to a `Publisher` ("upstream")
Sends result to a `Subscriber` ("downstream")
Value type

<div align="center">
<img src="https://github.com/hyeji-K/fastcampus_iOS_course/blob/main/image/operator.png" width="400">
</div>




## 참고
- https://developer.apple.com/videos/play/wwdc2019/722/