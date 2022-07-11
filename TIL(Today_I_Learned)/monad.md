# 모나드

함수형 프로그래밍에서의 모나드는 **순서가 있는 연산을 처리할 때 자주 활용하는 디자인 패턴**

### 프로그래밍에서 모나드가 갖춰야 하는 조건
- 타입을 인자로 받는 타입(특정 타입의 값을 포장)
- 특정 타입의 값을 포장한 것을 반환하는 함수(메서드)가 존재
- 포장된 값을 변환하여 같은 형태로 포장하는 함수(메서드)가 존재

### 모나드를 사용한 예 중에 하나가 옵셔널
- 옵셔널은 값이 있을지 없을지 모르는 상태를 포장하는 것임

<br>

## 1. 컨텍스트(Context)

사전적 정의: 맥락, 전후 사정 <br>
= 콘텐츠(Contents)를 담은 그 무언가 <br>
즉, 물컵에 물이 담겨있으면 물은 콘텐츠고 물컵은 컨텍스트라고 볼 수 있음

<br>

### 옵셔널 예시
옵셔널은 열거형으로 구현되어 있어서 열거형 case의 연관 값을 통해 인스턴스 안에 연관 값을 갖는 형태 <br>
옵셔널에 값이 없다면 열거형의 `.none` case로, 값이 있다면 열거형의 `.some(value)` case로 값을 지니게 됨 <br>
옵셔널의 값을 추출한다는 것은 열거형 인스턴스 내부의 `.some(value)` case의 연관 값을 꺼내오는 것과 같음

- 2라는 숫자를 옵셔널로 둘러싸면, 컨텍스트 안에 2라는 콘텐츠가 들어가는 모양새. 그리고 ‘컨텍스트는 2라는 값을 가지고 있다’고 말할 수 있음
- 만약 값이 없는 옵셔널 상태라면 ‘컨텍스트는 존재하지만 내부에 값이 없다’고 할 수 있음
- Optional은 Wrapped 타입을 인자로 받는 (제네릭)타입임 → 모나드 첫 번째 조건 만족
- Optional 타입은 Optional<Int>, init(2)처럼 다른 타입(Int)의 값을 갖는 상태의 컨텍스트를 생성할 수 있음 → 모나드 두 번째 조건 만족

```swift
func addThree(_ num: Int) -> Int {
    return num + 3
}

addThree(2) // 5

addThree(Optional(2)) // 오류!! 
```

<br>

## 2. 함수객체(Functor)

맵은 컨테이너(컨테이너는 다른 타입의 값을 담을 수 있으므로 컨텍스트의 역할을 수행할 수 있음)의 값을 변형시킬 수 있는 고차함수 <br>

옵셔널은 컨테이너와 값을 갖기 때문에 맵 함수를 사용할 수 있음

```swift
Optional(2).map(addThree) // Optional(5)
```

맵을 사용하면 컨테이너 안의 값을 처리할 수 있음

```swift
var value: Int? = 2
value.map{ $0 + 3 } // Optional(5)
value = nil
value.map{ $0 + 3 } // nil
```

함수객체란 맵을 적용할 수 있는 컨테이너 타입이라고 말할 수 있기 때문 <br>
Array, Dictionary, Set 등등 스위프트의 많은 컬렉션 타입이 함수객체 <br>

### 함수객체에서 맵이 어떻게 동작하는지?

```swift
extension Optional {
    func map<U>(f: (Wrapped) -> U) -> U? {
        switch self {
        case .some(let x): return f(x)
        case .none: return .none
        }
    }
}
```

- 옵셔널의 map(_:) 메서드를 호출하면 옵셔널 스스로 값이 있는지 없는지 switch 구문으로 판단
- 값이 있다면 전달받은 함수에 자신의 값을 적용한 결과값을 다시 컨텍스트에 넣어 반환
- 그렇지 않다면 함수를 실행하지 않고 빈 컨텍스트를 반환

<br>

## 3. 모나드(Monad)

함수객체 중에서 자신의 컨텍스트와 같은 컨텍스트의 형태로 맵핑할 수 있는 함수객체를 닫힌 함수객체(Endofunctor)라고 함 <br>
모나드는 닫힌 함수객체
- 컨텍스트에 포장된 값을 처리하여 포장된 값을 컨텍스트에 다시 반환하는 함수(맵)을 적용할 수 있음
- 이 매핑의 결과가 함수객체와 같은 컨텍스트를 반환하는 함수객체를 모나드라고 할 수 있으며, 이런 맵핑을 수행하도록 플랫맵(flatMap)이라는 메서드를 활용
- 플랫맵은 맵과 같이 함수를 매개변수로 받고, 옵셔널은 모나드이므로 플랫맵을 사용할 수 있음

```swift
func doubledEven(_ num: Int) -> Int? {
    if num.isMultiple(of: 2) {
        return num * 2
    }
    return nil
}

Optional(3).flatMap(doubledEven) // nil
```

- 플랫맵은 맵과 다르게 컨텍스트 내부의 컨텍스트를 모두 같은 위상으로 평평하게 펼쳐준다는 차이가 있음
- 즉, 포장된 값 내부의 포장된 값의 포장을 풀어서 같은 위상으로 펼쳐줌
- flatMap(_:) 메서드를 Sequence 타입이 Optional 타입의 Element를 포장한 경우에 compactMap(_:)이라는 이름으로 사용
- 이 경우를 제외한 다른 경우에는 그대로 flatMap(_:)이라는 이름을 사용
- compactMap(_:)의 사용 방법은 flatMap(_:)과 같음. 다만 좀 더 분명한 뜻을 나타내기 위해서 사용
- 맵과 컴팩트의 차이

```swift
let optionals: [Int?] = [1, 2, nil, 5]

let mapped: [Int?] = optionals.map{ $0 }
let compactMapped: [Int] = optionals.compactMap{ $0 }

print(mapped) // [Optional(1), Optional(2), nil, Optional(5)]
print(compactMapped) // [1, 2, 5]
```

- optionals는 이중 컨테이너의 형태를 띄고 있음
- optionals는 Array라는 컨테이너의 내부에 Optional이라는 형태의 컨테이너들이 여러개 들어가 있는 형태
- 맵 메서드를 사용한 결과는 Array 컨테이너 내부의 값 타입이나 형태가 어찌 되었든, Array 내부에 값이 있으면 그 값을 그저 클로저의 코드에서만 실행하고 결과를 다시 Array 컨테이너에 담기만 함
- 플랫맵을 통해 클로저를 실행하면 알아서 내부 컨테이너까지 값을 추출함
- mapped는 다시 [Int?] 타입이 되며, compactMapped는 [Int] 타입이 됨

```swift
let multipleContainer = [[1, 2, Optional.none], [3, Optional.none], [4, 5, Optional.none]]

let mappedMultipleContainer = multipleContainer.map{ $0.map{ $0 } }
let flatmappedMultipleContainer = multipleContainer.flatMap{ $0.flatMap{ $0 } }
print(mappedMultipleContainer) // [[Optional(1), Optional(2), nil], [Optional(3), nil], [Optional(4), Optional(5), nil]]
print(flatmappedMultipleContainer) // [1, 2, 3, 4, 5]
```

- 플랫맵은 내부의 값을 1차원적으로 펼쳐놓는 작업도 하기 때문에, 값을 꺼내어 모두 동일한 위상으로 펼쳐놓는 모양새를 갖출 수 있음
- 스위프트에서 옵셔널에 관련된 여러 컨테이너의 값을 연달아 처리할 때, 바인딩을 통해 체인 형식으로 사용할 수 있기에 맵보다는 플랫맵이 더욱 유용하게 쓰임
- Int 타입을 String 타입으로, 그리고 String 타입을 Int 타입으로 변환하는 과정을 체인 형식으로 구현
