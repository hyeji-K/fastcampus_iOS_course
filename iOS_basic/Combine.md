# Combine

<span style="color:pink">**iOS 13.0+**</span>
<img src="https://img.shields.io/badge/iOS_13.0+-000000?style=flat&logo=iOS&logoColor=white"/>


## 동기(synchronous)와 비동기(Asynchronous)
### 동기(synchronous)
- 설계가 간단하고 직관적임
- 요청한 작업의 결과가 주어질 때까지 다음 작업을 실행하지 않고 대기함
- 작업이 순서대로 실행 됨

### 비동기(Asynchronous)
- 동기보다 복잡한 설계 방식
- 요청한 작업의 결과가 주어지는데 시간이 걸리더라고 결과를 기다리지 않고 바로 다른 작업을 실행 함
- 자원을 효율적으로 사용할 수 있음
- 예시: 서버에서 데이터를 받아와서 보여주기, 사용자의 버튼 인터랙션 등

<br>

## Combine
> `A unified, declarative API for processing values over time`
<br>시간에 따른 값들을 처리하기 위한 통합적이고 선언적인 API

- 효율적으로 비동기 작업을 처리하기 위해 사용

<br>

## 3가지 주요 컴퍼넌트
- Publisher
- Subscriber
- Operator

### Publisher
Defines how values and errors are produced
> 값과 에러를 만들어내는 방법이 정의되어 있는 객체

Value type
> 이 프로토콜을 채택하는 타입은 값타입(struct)이어야 함

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
> Publisher로부터 값을 받아서 사용하는 객체

Reference type
> identity가 있어야 되기 때문에 참조 타입(class)이어야 함

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
<br>Describes a behavior for changing values
<br>Subscribes to a `Publisher` ("upstream")
<br>Sends result to a `Subscriber` ("downstream")
<br>Value type

<div align="center">
<img src="https://github.com/hyeji-K/fastcampus_iOS_course/blob/main/image/operator.png" width="800">
</div>




## 참고
- https://developer.apple.com/videos/play/wwdc2019/722/
- https://jcsoohwancho.github.io/2020-01-18-Combine-%EC%8B%9C%EC%9E%91%ED%95%98%EA%B8%B0(1)-Overview/