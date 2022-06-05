# Combine

<!-- <span style="color:pink">**iOS 13.0+**</span> -->
<img alt="iOS 13.0+" src ="https://img.shields.io/badge/13.0+-000000?&style=flat&logo=iOS&logoColor=white">

+ 프로토콜, unowned self, 

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
<img src="https://github.com/hyeji-K/fastcampus_iOS_course/blob/main/image/Combine2.png" width="400">
</div>

<div align="center">
<img src="https://github.com/hyeji-K/fastcampus_iOS_course/blob/main/image/operator.png" width="800">
</div>

<br>

## Publisher 구현
Publisher를 직접 구현하기 보단, Combine Framework가 제공하는 방식으로 구현하기를 권장함
- Subject (`PassthroughSubject`, `CurrentValueSubject`)
- @Published

<br>

### Subject
`send(_:)` 메서드를 호출하여 값을 주입시킬 수 있는 Publisher

1. PassthroughSubject

    ```swift
    final class PassthroughSubject<Output, Failure> where Failure : Error
    ```
    - 값이 주입되는 시점에서만 Subscriber가 새로운 값을 받을 수 있게 됨
    - 초기 값이나 최근 값의 버퍼를 가지고 있지 않음

<br>

2. CurrentValueSubject

    ```swift
    final class CurrentValueSubject<Output, Failure> where Failure : Error
    ```
    - 초기 값이나 최근 값의 버퍼를 가지고 있음
    - 그래서 최근 값을 전달 후에 받은 값을 전달함

<br>

### @Published
클래스의 프로퍼티인 경우, 앞에 `@Published` 를 적어서 Publisher를 만들 수 있음
<br>`$`를 사용해서 Publisher에 접근할 수 있음
<br>데이터의 변경이 잦은 것에 사용됨

<br>

## Subscriber 구현
- `sink(receiveCompletion:receiveValue:)`는 새로운 값를 받을 때마다 임의의 클로저를 실행

- `assign(to:on:)`은 새로 받은 값을 주어진 인스턴스의 키패스에 할당

### Subscription
Subscriber가 Publisher를 구독
<br>Cancellable 프로토콜을 따르고 있기 때문에, `cancel()`로 구독을 취소할 수 있음

<br>

## Scheduler
언제(시간), 어떻게(스레드) 클로저를 실행할 지 정해주는 프로토콜
<br>기본적으로 Scheduler는 element가 생성된 스레드와 동일한 스레드를 사용

- `subscribe(on:)`은 Publisher가 어느 스레드에서 수행할 지 결정해주는 것 

- `receive(on:)`을 이용해서 operator, subscriber 가 어느 스레드에서 수행할 지 결정해주는 것

<br>

## 참고
- https://developer.apple.com/videos/play/wwdc2019/722/
- https://jcsoohwancho.github.io/2020-01-18-Combine-%EC%8B%9C%EC%9E%91%ED%95%98%EA%B8%B0(1)-Overview/