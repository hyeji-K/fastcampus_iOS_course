# 모나드
- 모나드라는 용어는 수학의 범주론에서부터 시작
- 함수형 프로그래밍에서의 모나드는 **순서가 있는 연산을 처리할 때 자주 활용하는 디자인 패턴**
- 사용하는 곳에 따라 수학의 범주론에서 말하는 모나드인지 특정 디자인 패턴을 따르는 모나드인지가 다름
- 프로그래밍에서 사용하는 모나드는 범주론의 모나드의 의미를 완벽히 구현하려고 하지 않기 때문에 범주론의 모나드 개념을 차용한 정도의 의미를 갖음
- 그래서 모나드의 성질을 완벽히 갖추지 못했지만 대부분의 성질을 갖추었다고 하여 프로그래밍에서의 모나드를 모나딕(Monadic)이라고 표현
- 혹은 모나드의 성질을 갖는 타입이나 함수를 모나딕 타입 혹은 모나딕 함수 등으로 표현

### **프로그래밍에서 모나드가 갖춰야 하는 조건**

- 타입을 인자로 받는 타입(특정 타입의 값을 포장)
- 특정 타입의 값을 포장한 것을 반환하는 함수(메서드)가 존재
- 포장된 값을 변환하여 같은 형태로 포장하는 함수(메서드)가 존재

- ‘타입을 인자로 받는다’ → 제네릭으로 구현 가능
- 모나드(Monad)를 이해하는 출발점은 값을 어딘가에 포장하는 개념을 이해하는 것에서 출발
- 모나드를 사용한 예 중에 하나가 옵셔널
    - 옵셔널은 값이 있을지 없을지 모르는 상태를 포장하는 것임
- 함수객체(Functor)와 모나드는 특정 기능이 아닌 디자인 패턴 혹은 자료구조라고 할 수 있음

## 1. 컨텍스트(Context)

- 사전적 정의: 맥락, 전후 사정
- = 콘텐츠(Contents)를 담은 그 무엇인가
- 즉, 물컵에 물이 담겨있으면 물은 콘텐츠고 물컵은 컨텍스트라고 볼 수 있음
- 옵셔널은 열거형으로 구현되어 있어서 열거형 case의 연관 값을 통해 인스턴스 안에 연관 값을 갖는 형태
- 옵셔널에 값이 없다면 열거형의 `.none` case로, 값이 있다면 열거형의 `.some(value)` case로 값을 지니게 됨
- 옵셔널의 값을 추출한다는 것은 열거형 인스턴스 내부의 `.some(value)` case의 연관 값을 꺼내오는 것과 같음
- 2라는 숫자를 옵셔널로 둘러싸면, 컨텍스트 안에 2라는 콘텐츠가 들어가는 모양새
- 그리고 ‘컨텍스트는 2라는 값을 가지고 있다’고 말할 수 있음
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

## 2. 함수객체(Functor)

- 맵은 컨테이너(컨테이너는 다른 타입의 값을 담을 수 있으므로 컨텍스트의 역할을 수행할 수 있음)의 값을 변형시킬 수 있는 고차함수
- 옵셔널은 컨테이너와 값을 갖기 때문에 맵 함수를 사용할 수 있음

```swift
Optional(2).map(addThree) // Optional(5)
```

- 맵을 사용하면 컨테이너 안의 값을 처리할 수 있음

```swift
var value: Int? = 2
value.map{ $0 + 3 }
value = nil
value.map{ $0 + 3 }
```

- 함수객체란 맵을 적용할 수 있는 컨테이너 타입이라고 말할 수 있기 때문
- Array, Dictionary, Set 등등 스위프트의 많은 컬렉션 타입이 함수객체
- 함수객체에서 맵이 어떻게 동작하는지?

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

## 3. 모나드(Monad)

- 함수객체 중에서 자신의 컨텍스트와 같은 컨텍스트의 형태로 맵핑할 수 있는 함수객체를 닫힌 함수객체(Endofunctor)라고 함
- 모나드는 닫힌 함수객체
- 컨텍스트에 포장된 값을 처리하여 포장된 값을 컨텍스트에 다시 반환하는 함수(맵)을 적용할 수 있음
- 이 매핑의 결과가 함수객체와 같은 컨텍스트를 반환하는 함수객체를 모나드라고 할 수 있으며, 이런 맵핑을 수행하도록 플랫맵(flatMap)이라는 메스드를 활용
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

```swift
func stringToInteger(_ string: String) -> Int? {
    return Int(string)
}

func integerToString(_ integer: Int) -> String? {
    return "\(integer)"
}

var optionalString: String? = "2"

let flattenResult = optionalString.flatMap(stringToInteger)
    .flatMap(integerToString)
    .flatMap(stringToInteger)

print(flattenResult) // Optional(2)

let mappedResult = optionalString.map(stringToInteger)
print(mappedResult) // Optional(Optional(2))
```

- String 타입을 Int 타입으로 변환하는 것은 실패할 가능성을 내포하기 때문에 결과값을 옵셔널 타입으로 반환
- Int 타입에서 String 타입으로의 변환은 실패 가능성은 없지만 예를 들고자 옵셔널 타입으로 반환해줌
- 플랫맵을 사용하여 체인을 연결했을 때 결과는 옵셔널 타입
- 그러나 맵을 사용하여 체인을 연결하면 옵셔널의 옵셔널 형태로 반환됨
    - 플랫맵은 함수의 결과값에 값이 있다면 추출해서 평평하게 만드는 과정을 내포하고 맵은 그렇지 않기 때문
    - 즉, 플랫맵은 항상 같은 컨텍스트를 유지할 수 있으므로 이같은 연쇄 연산도 가능

```swift
func map<U>(_ transform: (Wrapped) throws -> U) rethrows -> U?
func flatMap<U>(_ transform: (Wrapped) throws -> U?) rethrows -? U?
```

- 플랫맵을 사용하지 않으면서도 플랫맵과 같은 효과를 얻으려면 바인딩을 직접 해줘야함

```swift
var result: Int?
if let string: String = optionalString {
    if let number: Int = stringToInteger(string) {
        if let finalString: String = integerToString(number) {
            if let finalNumber: Int = stringToInteger(finalString) {
                result = Optional(finalNumber)
            }
        }
    }
}

print(result) // Optional(2)

if let string: String = optionalString,
   let number: Int = stringToInteger(string),
   let finalString: String = integerToString(number),
   let finalNumber: Int = stringToInteger(finalString) {
    result = Optional(finalNumber)
}

print(result) // Optional(2)
```

- 플랫맵을 사용하는 것보다 간단하지 않음
- 플랫맵은 체이닝 중간에, 연산에 실패하는 경우나 값이 없어지는 경우(.none이 된다거나 nil이 된다는 등)에는 별도의 예외 처리없이 빈 컨테이너를 반환

```swift
func integerToNil(param: Int) -> String? {
    return nil
}

optionalString = "2"

result = optionalString.flatMap(stringToInteger)
    .flatMap(integerToNil)
    .flatMap(stringToInteger)

print(result) // nil 
```

- flatMap(integerToNil) 부분에서 nil, 즉 Optional.none을 반환받기 때문에 이후에 호출되는 메서드는 무시함