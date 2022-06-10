# Property와 Method

## 1. 프로퍼티

- **저장 프로퍼티(Stored Properties)**
    - 인스턴스의 변수 또는 상수를 의미
    - 구조체와 클래스에서만 사용
    - 특정 타입의 인스턴스에 사용되는 것
- **연산 프로퍼티(Computed Properties)**
    - 값을 저장한 것이 아니라 **특정 연산을 실행한 결과값**을 의미
    - 클래스, 구조체, 열거형에 사용
    - 특정 타입의 인스턴스에 사용되는 것
- **타입 프로퍼티(Type Properties)**
    - 특정 타입에 사용되는 것
    - 클래스의 변수
- **프로퍼티 감시자(Property Observers)**
    - **프로퍼티의 값이 변하는 것을 감시**
    - 프로퍼티의 값이 변할 때 **값의 변화에 따른 특정 작업을 실행**
    - 저장 프로퍼티에 적용할 수 있으며 부모클래스로부터 상속받을 수 있음

### 1-1. 저장 프로퍼티**(Stored Properties)**

- 클래스 또는 구조체의 인스턴스와 연관된 값을 저장하는 가장 단순한 개념의 프로퍼티
- `var` 키워드를 사용하면 변수 저장 프로퍼티, `let` 키워드를 사용하면 상수 저장 프로퍼티
- 저장 프로퍼티를 정의할 때, 프로퍼티 기본값과 초기값을 지정해줄 수 있음

<aside>
💡 구조체와 클래스의 저장 프로퍼티
구조체의 저장 프로퍼티가 옵셔널이 아니더라도, 구조체는 저장 프로퍼티를 모두 포함하는 이니셜라이저를 자동으로 생성함
클래스의 저장 프로퍼티는 옵셔널이 아니라면 프로퍼티 기본값을 지정해주거나 사용자 정의 이니셜라이저를 통해 반드시 초기화해주어야 함. 또, 클래스 인스턴트의 상수 프로퍼티는 인스턴스가 초기화(이니셜라이즈)될 때 한 번만 값을 할당할 수 있으며, 자식클래스에서 이 초기화를 변경(재정의)할 수 없음

</aside>

- 저장 프로퍼티의 선언 및 인스턴스 생성
    
    ```swift
    struct CoordinatePoint {
        var x: Int
        var y: Int
    }
    
    let yagomPoint: CoordinatePoint = CoordinatePoint(x: 10, y: 5)
    
    class Position {
        var point: CoordinatePoint
        let name: String
        
        init(name: String, currentPoint: CoordinatePoint) {
            self.name = name
            self.point = currentPoint
        }
    }
    
    let yagomPosition: Position = Position(name: "yagom", currentPoint: yagomPoint)
    ```
    
- 구조체는 프로퍼티에 맞는 이니셜라이저를 자동으로 제공하지만 클래스는 아님
- 클래스의 저장 프로퍼티에 초기값을 지정해주면 따로 사용자 정의 이니셜라이저를 구현해주지 않아도 됨
    
    ```swift
    struct CoordinatePoint {
        var x: Int = 0
        var y: Int = 0
    }
    
    let yagomPoint: CoordinatePoint = CoordinatePoint()
    
    let wizplanPoint: CoordinatePoint = CoordinatePoint(x: 10, y: 5)
    
    print("yagom's point: \(yagomPoint.x), \(yagomPoint.y)")
    // yagom's point: 0, 0
    print("wizplan's point: \(wizplanPoint.x), \(wizplanPoint.y)")
    // wizplan's point: 10, 5
    
    class Position {
        var point: CoordinatePoint = **CoordinatePoint()**
        var name: String = **"Unknown"**
    }
    
    let yagomPosition: Position = Position()
    
    yagomPosition.point = yagomPoint
    yagomPosition.name = "yagom"
    ```
    

- 인스턴스를 생성할 때 이니셜라이저를 통해 초기값을 보내야 하는 이유?
    - 프로퍼티가 옵셔널이 아닌 값으로 선언되어 있기 때문
    - 그러므로 인스턴스는 생성할 때 프로퍼티에 값이 꼭 있는 상태여야 함
- 저장 프로퍼티의 값이 옵셔널이라면 초기값을 넣어주지 않아도 됨
    
    ⇒ 이니셜라이저에서 옵셔널 프로퍼티에 꼭 값을 할당해주지 않아도 됨
    
    ```swift
    struct CoordinatePoint {
        var x: Int
        var y: Int
    }
    
    class Position {
        var point: CoordinatePoint**?**
        var name: String
    
        init(name: String) {
            self.name = name
        }
    }
    
    let yagomPosition: Position = Position(name: "yagom")
    
    yagomPosition.point = CoordinatePoint(x: 20, y: 10)
    ```
    

### 1-2. 지연 저장 프로퍼티(Lazy Stored Properties)

- 필요할 때 값이 할당
- 호출이 있어야 값을 초기화하며, 이때 `lazy` 키워드 사용
- `var` 키워드를 사용하여 변수로 정의함
    - 상수는 인스턴스가 완전히 생성되기 전에 초기화해야 하므로 필요할 때 값을 할당하는 지연 저장 프로퍼티와는 맞지 않음
- 주로 복잡한 클래스나 구조체를 구현할 때 많이 사용됨
- 잘 사용하면 불필요한 성능저하나 공간 낭비를 줄일 수 있음
- 언제 사용?
    - 클래스 인스턴스의 저장 프로퍼티로 다른 클래스 인스턴스나 구조체 인스턴스를 할당해야 할 때
        - 인스턴스를 초기화하면서 저장 프로퍼티로 쓰이는 인스턴스들이 한 번에 생성되어야 한다면?
        - 굳이 모든 저장 프로퍼티를 사용할 필요가 없다면?

```swift
struct CoordinatePoint {
    var x: Int = 0
    var y: Int = 0
}

class Position {
    **lazy** var point: CoordinatePoint = CoordinatePoint()
    var name: String

    init(name: String) {
        self.name = name
    }
}

let yagomPosition: Position = Position(name: "yagom")

// point 프로퍼티로 처음 접근할 때 point 프로퍼티의 CoordinatePoint가 생성됨
print(yagomPosition.point) // CoordinatePoint(x: 0, y: 0)
```

### 1-3. 연산 프로퍼티**(Computed Properties)**

- 실제 값을 저장하는 프로퍼티가 아니라, **특정 상태에 따른 값을 연산**하는 프로퍼티
- 인스턴스 내/외부의 값을 연산하여 적절한 값을 돌려주는 접근자(getter)의 역할이나 은닉화된 내부의 프로퍼티 값을 간접적으로 설정하는 설정자(setter)의 역할을 할 수도 있음
- 클래스, 구조체, 열거형에 사용
- 굳이 메서드를 두고 왜 연산 프로퍼티를 쓸까?
    - 인스턴스 외부에서 메서드를 통해 인스턴스 내부 값에 접근하려면 메서드를 두 개(접근자, 설정자) 구현해야 함
    - 이를 감수하고 메서드로 구현한다 해도 두 메서드가 분산 구현되어 코드의 가독성이 나빠질 위험이 있음
    - 프로그래머 입장에서는 프로퍼티가 메서드 형식보다 훨씬 더 간편하고 직관적이기도 함
- 읽기 전용 상태로 구현하기 쉽지만, 쓰기 전용 상태로 구현할 수 없다는 단점이 있음

- 메서드로 구현된 접근자와 설정자
    
    ```swift
    struct CoordinatePoint {
        var x: Int
        var y: Int
        
        // 대칭점을 구하는 메서드 - 접근자
        func oppositePoint() -> Self {
            return CoordinatePoint(x: -x, y: -y)
        }
        
        // 대칭점을 설정하는 메서드 - 설정자
        mutating func setOppositePoint(_ opposite: CoordinatePoint) {
            x = -opposite.x
            y = -opposite.y
        }
    }
    
    var yagomPosition: CoordinatePoint = CoordinatePoint(x: 10, y: 20)
    // 현재 좌표
    print(yagomPosition) // CoordinatePoint(x: 10, y: 20)
    // 대칭 좌표
    print(yagomPosition.oppositePoint()) // CoordinatePoint(x: -10, y: -20)
    // 대칭 좌표를 (15, 10)으로 설정하면
    yagomPosition.setOppositePoint(CoordinatePoint(x: 15, y: 10))
    // 현재 좌표
    print(yagomPosition) // CoordinatePoint(x: -15, y: -10)
    ```
    
    - 접근자와 설정자 이름의 일관성을 유지하기 힘들며, 해당 포인트에 접근할 때와 설정할 때 사용되는 코드를 한 번에 읽기도 쉽지 않음

- 연산 프로퍼티의 정의와 사용
    
    ```swift
    struct CoordinatePoint {
        var x: Int
        var y: Int
        
        // 대칭 좌표
        var oppositePoint: CoordinatePoint {
            // 접근자
            **get** {
                return CoordinatePoint(x: -x, y: -y)
            }
            
            // 설정자
            **set**(opposite) {
                x = -opposite.x
                y = -opposite.y
            }
        }
    }
    
    var yagomPosition: CoordinatePoint = CoordinatePoint(x: 10, y: 20)
    // 현재 좌표
    print(yagomPosition) // CoordinatePoint(x: 10, y: 20)
    // 대칭 좌표
    print(yagomPosition.oppositePoint) // CoordinatePoint(x: -10, y: -20)
    // 대칭 좌표를 (15, 10)으로 설정하면
    yagomPosition.oppositePoint = CoordinatePoint(x: 15, y: 10)
    // 현재 좌표
    print(yagomPosition) // CoordinatePoint(x: -15, y: -10)
    ```
    
    - 설정자의 매개변수로 원하는 이름을 소괄호 안에 명시해주면 `set` 메서드 내부에서 전달받은 전달인자를 사용할 수 있음
    - 매개변수를 따로 표기하지 않고 관용적인 표현 `newValue`로 매개변수 이름을 대신할 수 있음
    - 접근자 내부의 코드가 단 한 줄이고, 그 결과값의 타입이 프로퍼티의 타입과 같다면 `return` 키워드를 생략해도 그 결과값이 접근자의 반환값이 됨
        
        ```swift
        struct CoordinatePoint {
            var x: Int
            var y: Int
            
            // 대칭 좌표
            var oppositePoint: CoordinatePoint {
                // 접근자
                get {
                    **CoordinatePoint(x: -x, y: -y)**
                }
                
                // 설정자
                set {
                    x = -**newValue**.x
                    y = -**newValue**.y
                }
            }
        }
        ```
        
    - **읽기 전용** 연산 프로퍼티
        
        ```swift
        struct CoordinatePoint {
            var x: Int
            var y: Int
            
            // 대칭 좌표
            var oppositePoint: CoordinatePoint {
                // 접근자
                get {
                    return CoordinatePoint(x: -x, y: -y)
                }
            }
        }
        ```
        
    

### 1-4. 프로퍼티 감시자(Property Observers)

- 프로퍼티의 값이 변경됨에 따라 적절한 작업을 취할 수 있음
- 프로퍼티의 값이 새로 할당될 때마다 호출 → 이때 변경되는 값이 현재의 값과 같더라도 호출함
- 저장 프로퍼티뿐만 아니라 프로퍼티를 재정의해 상속받은 저장 프로퍼티 또는 연산 프로퍼티에도 적용할 수 있음
- 상속받지 않은 연산 프로퍼티에는 프로퍼티 감시자를 사용할 필요가 없으며 할 수도 없음
    - 연산 프로퍼티의 접근자와 설정자를 통해 프로퍼티 감시자를 구현할 수 있기 때문
    - 연산 프로퍼티는 상속받았을 때만 프로퍼티 재정의를 통해 프로퍼티 감시자를 사용함
- `willSet` 메서드: 프로퍼티의 값이 변경되기 직전에 호출
    - 전달되는 전달인자는 프로퍼티가 변경될 값
    - 매개변수의 이름을 따로 지정하지 않으면 `newValue` 매개변수 이름이 자동 지정
- `didSet` 메서드: 프로퍼티의 값이 변경된 직후에 호출
    - 전달되는 전달인자는 프로퍼티가 변경되기 전의 값
    - 매개변수의 이름을 따로 지정하지 않으면 `oldValue` 매개변수 이름이 자동 지정

<aside>
💡 oldValue와 didSet
didSet 감시자 코드 블록 내부에서 oldValue 값을 참조하지 않거나 매개변수 목록에 명시적으로 매개변수를 적어주지 않으면 didSet 코드 블록이 실행되지 않음

</aside>

- 프로퍼티 감시자
    
    ```swift
    class Account {
        var credit: Int = 0 {
            **willSet** {
                print("잔액이 \(credit)원에서 \(newValue)원으로 변경될 예정입니다.")
            }
            
            **didSet** {
                print("잔액이 \(oldValue)원에서 \(credit)원으로 변경되었습니다.")
            }
        }
    }
    
    let myAccount: Account = Account() 
    // 잔액이 0원에서 1000원으로 변경될 예정입니다.
    myAccount.credit = 1000
    // 잔액이 0원에서 1000원으로 변경되었습니다.
    ```
    
    - 클래스를 상속받았다면 기존의 연산 프로퍼티를 재정의하여 프로퍼티 감시자를 구현할 수도 있음
    - 연산 프로퍼티를 재정의해도 기존의 연산 프로퍼티 기능(접근자와 설정자, get과 set 메서드)은 동작함

- 연산 프로퍼티인 dollarValue가 포함되어 있는 Account 클래스를 상속받은 ForeignAccount 클래스에서 기존 dollarValue 프로퍼티를 재정의하여 프로퍼티 감시자를 구현하는 예제
    
    ```swift
    class Account {
        var credit: Int = 0 {
            willSet {
                print("잔액이 \(credit)원에서 \(newValue)원으로 변경될 예정입니다.")
            }
            
            didSet {
                print("잔액이 \(oldValue)원에서 \(credit)원으로 변경되었습니다.")
            }
        }
        
        // 연산 프로퍼티
        var dollarValue: Double {
            get {
                return Double(credit)
            }
            
            set {
                credit = Int(newValue * 1000)
                print("잔액을 \(newValue)달러로 변경하는 중입니다.")
            }
        }
    }
    
    class ForeignAccount: Account {
        **override** var dollarValue: Double {
            willSet {
                print("잔액이 \(dollarValue)달러에서 \(newValue)달러로 변경될 예정입니다.")
            }
            
            didSet {
                print("잔액이 \(oldValue)달러에서 \(dollarValue)달러로 변경되었습니다.")
            }
        }
    }
    
    let myAccount: ForeignAccount = ForeignAccount()
    // 잔액이 0원에서 1000원으로 변경될 예정입니다.
    myAccount.credit = 1000
    // 잔액이 0원에서 1000원으로 변경되었습니다.
    
    // 잔액이 1000.0달러에서 2.0달러로 변경될 예정입니다.
    // 잔액이 1000원에서 2000원으로 변경될 예정입니다.
    // 잔액이 1000원에서 2000원으로 변경되었습니다.
    
    myAccount.dollarValue = 2 // 잔액을 2.0달러로 변경하는 중입니다.
    // 잔액이 1000.0달러에서 2000.0달러로 변경되었습니다.
    ```
    

<aside>
💡 입출력 매개변수와 프로퍼티 감시자
만약 프로퍼티 감시자가 있는 프로퍼티를 함수의 입출력 매개변수의 전달인자로 전달한다면 항상 willSet과 didSet 감시자를 호출합니다. 함수 내부에서 값이 변경되든 되지 않든 간에 함수가 종료되는 시점에 값을 다시 쓰기 때문

</aside>

### 1-5. 전역변수와 지역변수

- 전역변수: 함수, 메소드, 클로저 또는 type context **외부**에 정의되는 변수
- 지역변수: 함수, 메소드 또는 클로저 context **내**에 정의되는 변수
- 연산 프로퍼티와 프로퍼티 감시자는 전역변수와 지역변수 모두에 사용할 수 있음. 따라서 프로퍼티에 한정하지 않고, 전역에서 쓰일 수 있는 변수와 상수에도 두 기능을 사용할 수 있음
- 함수나 메서드, 클로저, 클래스, 구조체, 열거형 등의 범위 안에 포함되지 않았던 변수나 상수는 모두 전역변수 또는 전역상수에 해당됨
- 전역변수 또는 지역변수 = 저장변수(저장 프로퍼티처럼 값을 저장하는 역할)
- 전역변수나 지역변수를 연산변수로 구현할 수도 있으며, 프로퍼티 감시자를 구현할 수도 있음
- 전역변수 또는 전역상수는 지연 저장 프로퍼티처럼 처음 접근할 때 최초로 연산이 이루어짐
    - `lazy` 키워드를 사용하지 않아도 됨
- 반대로 지역변수 및 지역상수는 절대로 지연 연산되지 않음

- 저장변수의 감시자와 연산변수
    
    ```swift
    // 저장변수에 감시자 구현
    var wonInPocket: Int = 2000 {
        willSet {
            print("주머니의 돈이 \(wonInPocket)원에서 \(newValue)원으로 변경될 예정입니다.")
        }
        
        didSet {
            print("주머니의 돈이 \(oldValue)원에서 \(wonInPocket)원으로 변경되었습니다.")
        }
    }
    
    // 저장변수에 연산변수 구현
    var dollarInPocket: Double {
        get {
            return Double(wonInPocket)
        }
        
        set {
            wonInPocket = Int(newValue * 1000.0)
            print("주머니의 달러를 \(newValue)달러로 변경 중입니다.")
        }
    }
    
    // 주머니의 돈이 2000원에서 3500원으로 변경될 예정입니다.
    // 주머니의 돈이 2000원에서 3500원으로 변경되었습니다.
    dollarInPocket = 3.5 // 주머니의 달러를 3.5달러로 변경 중입니다.
    ```
    

### 1-6. 타입 프로퍼티

- 이제까지 알아본 프로퍼티 개념은 모두 타입을 정의하고 해당 타입의 인스턴스가 생성되었을 때 사용할 수 있는 인스턴스 프로퍼티임. 인스턴스 프로퍼티는 인스턴스를 새로 생성할 때마다 초기값에 해당하는 값이 프로퍼티의 값이 되고, 인스턴스마다 다른 값을 지닐 수 있음
- 각각의 인스턴스가 아닌 타입 자체에 속하는 프로퍼티 → `static` 키워드 사용
- 타입 자체에 영향을 미치는 프로퍼티
- 인스턴스의 생성 여부와 상관없이 타입 프로퍼티의 값은 하나며, 그 타입의 모든 인스턴스가 공통으로 사용하는 값, 모든 인스턴스에서 공용으로 접근하고 값을 변경할 수 있는 변수 등을 정의할 때 유용
- 두 가지의 타입 프로퍼티
    - **저장 타입 프로퍼티**
        - 변수 또는 상수로 선언할 수 있음
        - 반드시 초기값을 설정해야 하며 지연 연산됨
            - 타입 자체에는 저장 타입 프로퍼티(Stored type Property)에 값을 할당할 initializer가 없음
            - 지연 저장 프로퍼티와는 조금 다르게 다중 스레드 환경이라고 하더라도 단 한 번만 초기화된다는 보장을 받음 → 지연 연산 된다고 해서 lazy 키워드로 표시해주지는 않음
    - **연산 타입 프로퍼티**
        - 변수로만 선언할 수 있음

- 타입 프로퍼티와 인스턴스 프로퍼티
    
    ```swift
    class AClass {
        // 저장 타입 프로퍼티
        **static** var typeProperty: Int = 0
        
        // 저장 인스턴스 프로퍼티
        var instanceProperty: Int = 0 {
            didSet {
                Self.typeProperty = instanceProperty + 100
            }
        }
        
        // 연산 타입 프로퍼티
        **static** var typeComputedProperty: Int {
            get {
                return typeProperty
            }
            
            set {
                typeProperty = newValue
            }
        }
    }
    
    AClass.typeProperty = 123
    
    let classInstance: AClass = AClass()
    classInstance.instanceProperty = 100
    
    print(AClass.typeProperty) // 200
    print(AClass.typeComputedProperty) // 200
    ```
    
    - 타입 프로퍼티는 인스턴스를 생성하지 않고도 사용할 수 있으며 타입에 해당하는 값임
    - 그래서 인스턴스에 접근할 필요 없이 타입 이름만으로도 프로퍼티를 사용할 수 있음
    
- 타입 프로퍼티의 사용
    
    ```swift
    class Account {
        static let dollarExchangeRate: Double = 1000.0
        
        var credit: Int = 0
        
        var dollarValue: Double {
            get {
                return Double(credit) / Self.dollarExchangeRate
            }
            
            set {
                credit = Int(newValue * Account.dollarExchangeRate)
                print("잔액을 \(newValue)달러로 변경 중입니다.")
            }
        }
    }
    ```
    

### 1-7. 키 경로

- 함수는 일급시민으로서 상수나 변수에 참조를 할당할 수 있음
    
    ```swift
    func someFunction(paramA: Any, paramB: Any) {
        print("someFunction called...")
    }
    
    var functionReference = someFunction(paramA:paramB:)
    ```
    
- 함수를 참조해두고 나중에 원할 때 호출할 수 있고, 다른 함수를 참조하도록 할 수도 있음
    
    ```swift
    functionReference("A", "B")
    functionReference = anotherFunction(paramA:paramB:)
    ```
    
- 프로퍼티도 이처럼 값을 바로 꺼내오는 것이 아니라 어떤 프로퍼티의 위치만 참조되도록 할 수 있음. 바로 키 경로(KeyPath)를 활용하는 방법임
- 키 경로를 사용하여 간접적으로 특정 타입의 어떤 프로퍼티 값을 가리켜야 할지 미리 지정해두고 사용할 수 있음
- 키 경로 타입은 AnyKeyPath라는 클래스로부터 파생됨
- 제일 많이 확장된 키 경로 타입은 `WritableKeyPath<Root, Value>`와 `ReferenceWritableKeyPath<Root, Value>` 타입임
- `WritableKeyPath<Root, Value>` 타입은 값 타입에 키 경로 타입으로 읽고 쓸 수 있는 경우에 적용되며, `ReferenceWritableKeyPath<Root, Value>` 타입은 참조 타입, 즉 클래스 타입에 키 경로 타입으로 읽고 쓸 수 있는 경우에 적용됨
- 키 경로는 역슬래시(`\`)와 타입, 마침표(`.`)경로로 구성됨
- `\타입이름.경로.경로.경로`
    - 여기서 경로는 프로퍼티 이름이라고 생각하면 됨
- 키 경로 타입의 타입 확인
    
    ```swift
    class Person {
        var name: String
        
        init(name: String) {
            self.name = name
        }
    }
    
    struct Stuff {
        var name: String
        var owner: Person
    }
    
    print(type(of: \Person.name)) // ReferenceWritableKeyPath<Person, String>
    print(type(of: \Stuff.name)) // WritableKeyPath<Stuff, String>
    ```
    
- 키 경로는 기존의 키 경로에 하위 경로를 덧붙여 줄 수도 있음
- 키 경로 타입의 경로 연결
    
    ```swift
    let keyPath = \Stuff.owner
    let nameKeyPath = keyPath.appending(path: \.name)
    ```
    
- 각 인스턴스의 keyPath 서브스크립트 메서드에 키 경로를 전달하여 프로퍼티에 접근 할 수도 있음
- keyPath 서브스크립트와 키 경로 활용
    
    ```swift
    class Person {
        let name: String
        
        init(name: String) {
            self.name = name
        }
    }
    
    struct Stuff {
        var name: String
        var owner: Person
    }
    
    let yagom = Person(name: "yagom")
    let hana = Person(name: "hana")
    let macbook = Stuff(name: "MacBook Pro", owner: yagom)
    var iMac = Stuff(name: "iMac", owner: yagom)
    let iPhone = Stuff(name: "iPhone", owner: hana)
    
    let stuffNameKeyPath = \Stuff.name
    let ownerKeyPath = \Stuff.owner
    
    let ownerNameKeyPath = ownerKeyPath.appending(path: \.name)
    
    // 키 경로와 서브스크립트를 이용해 프로퍼티에 접근하여 값을 가져옴
    print(macbook[keyPath: stuffNameKeyPath]) // MacBook Pro
    print(iMac[keyPath: stuffNameKeyPath]) // iMac
    print(iPhone[keyPath: stuffNameKeyPath]) // iPhone
    
    print(macbook[keyPath: ownerNameKeyPath]) // yagom
    print(iMac[keyPath: ownerNameKeyPath]) // yagom
    print(iPhone[keyPath: ownerNameKeyPath]) // hana
    
    // 키 경로와 서브스크립트를 이용해 프로퍼티에 접근하여 값을 변경함
    iMac[keyPath: stuffNameKeyPath] = "iMac Pro"
    iMac[keyPath: ownerKeyPath] = hana
    
    print(iMac[keyPath: stuffNameKeyPath]) // iMac Pro
    print(iMac[keyPath: ownerNameKeyPath]) // hana
    
    // 상수로 지정한 값 타입과 읽기 전용 프로퍼티는 키 경로 서브스크립트로도 값을 바꿔줄 수 없습니다.
    macbook[keyPath: stuffNameKeyPath] = "macbook pro touch bar" // let macbook 오류!! 
    yagom[keyPath: \Person.name] = "bear" // key path is read-only 오류!!
    ```
    
- 키 경로를 잘 활용하면 프로토콜과 마친가지로 타입 간의 의존성을 낮추는데 많은 도움을 줌
- 또, 애플의 프레임워크는 키-값 코딩 등 많은 곳에 키 경로를 활용하므로, 애플 프레임워크 기반의 애플리케이션을 만든다면 잘 알아두길 바람

<aside>
💡 접근수준과 키 경로
키 경로는 타입 외부로 공개된 **인스턴스 프로퍼티 혹은 서브스크립트**에 한하여 표현할 수 있음

</aside>

- 자신을 나타내는 키 경로인 `\.self`를 사용하면 인스턴스 그 자체를 표현하는 키 경로가 됨. 또, 컴파일러가 타입을 유추할 수 있는 경우에는 키 경로에서 타입 이름을 생략할 수도 있음
- 클로저를 대체할 수 있는 키 경로 표현
    
    ```swift
    struct Person {
        let name: String
        let nickname: String?
        let age: Int
        
        var isAdult: Bool {
            return age > 18
        }
    }
    
    let yagom: Person = Person(name: "yagom", nickname: "bear", age: 100)
    let hana: Person = Person(name: "hana", nickname: "na", age: 100)
    let happy: Person = Person(name: "happy", nickname: nil, age: 3)
    
    let family: [Person] = [yagom, hana, happy]
    let names: [String] = family.map(\.name) // ["yagom", "hana", "happy"]
    let nicknames: [String] = family.compactMap(\.nickname) // ["bear", "na"]
    let adults: [String] = family.filter(\.isAdult).map(\.name) // ["yagom", "hana"]
    ```
    
    - family 배열은 [Person] 타입이며, 이 타입의 map은 (Person) → T를, compactMap은 (Person) → T?를, filter는 (Person) → Bool 타입의 클로저를 매개변수를 통해 전달받을 것임
    - 이에 따라 \.name 표현은 (Person) → T 타입의 클로저를 대체하여 표현하였고, 이는 클로저 표현인 {$0.name}의 표현과 같은 역할을 수행함
    - \.nickname과 \.isAdult 표현도 같은 방식으로 동작하는 것을 알 수 있음

[Expressions - The Swift Programming Language (Swift 5.5)](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html)

## 2. 메서드

- 특정 타입에 관련된 함수
- 구조체와 열거형이 메서드를 가질 수 있다는 것은 기존 프로그래밍 언어와 스위프트간의 큰 차이점임
- 스위프트에서는 프로그래머가 정의하는 타입(클래스, 구조체, 열거형 등)에 자유롭게 메스드를 정의할 수 있음

### 2-1. 인스턴스 메서드

- 특정 타입의 인스턴스에 속한 메서드
- 인스턴스 내부의 프로퍼티 값을 변경하거나 특정 연산 결과를 반환하는 등 인스턴스와 관련된 기능을 실행함
- 함수와 문법이 같음
- 함수와 달리 특정 타입 내부에 구현함 → 인스턴스가 존재할 때만 사용할 수 있음

- 클래스의 인스턴스 메서드
    
    ```swift
    class LevelClass {
        //현재 레벨을 저장하는 저장 프로퍼티
        var level: Int = 0 {
            //프로퍼티 값이 변경되면 호출하는 프로퍼티 감시자
            didSet {
                print("Level \(level)")
            }
        }
        // 레벨이 올랐을 때 호출할 메서드
        func levelUp() {
            print("Level Up!")
            level += 1
        }
        
        // 레벨이 감소했을 때 호출할 메서드
        func levelDown() {
            print("Level Down")
            level -= 1
            if level < 0 {
                reset()
            }
        }
        
        // 특정 레벨로 이동할 때 호출할 메서드
        func jumpLevel(to: Int) {
            print("Jump to \(to)")
            level = to
        }
        
        // 레벨을 초기화할 때 호출할 메서드
        func reset() {
            print("Reset!")
            level = 0
        }
    }
    
    var levelClassInstance: LevelClass = LevelClass()
    levelClassInstance.levelUp() // Level Up!
    // Level 1
    levelClassInstance.levelDown() // Level Down
    // Level 0
    levelClassInstance.levelDown() // Level Down
    // Level -1
    // Reset!
    // Level 0
    levelClassInstance.jumpLevel(to: 3) // Jump to 3
    // Level 3
    ```
    
    - LevelClass의 인스턴스 메서드는 level 인스턴스 프로퍼티의 값을 수정하는 코드가 있음
    - 자신의 프로퍼티 값을 수정할 때 클래스의 인스턴스 메서드는 크게 신경 쓸 필요가 없지만, 구조체나 열거형 등은 값 타입이므로 메서드 앞에 `mutating` 키워드를 붙여서 해당 메서드가 인스턴스 내부의 값을 변경한다는 것을 명시해야 함
- `mutating` 키워드 사용
    
    ```swift
    **struct** LevelStruct {
        var level: Int = 0 {
            didSet {
                print("Level \(level)")
            }
        }
        
        **mutating** func levelUp() {
            print("Level Up!")
            level += 1
        }
        
        **mutating** func levelDown() {
            print("Level Down")
            level -= 1
            if level < 0 {
                reset()
            }
        }
        
        **mutating** func jumpLevel(to: Int) {
            print("Jump to \(to)")
            level = to
        }
        
        **mutating** func reset() {
            print("Reset!")
            level = 0
        }
    }
    
    var levelStructInstance: LevelStruct = LevelStruct()
    levelStructInstance.levelUp() // Level Up!
    Level 1
    levelStructInstance.levelDown() // Level Down
    // Level 0
    levelStructInstance.levelDown() // Level Down
    // Level -1
    // Reset!
    // Level 0
    levelStructInstance.jumpLevel(to: 3) // Jump to 3
    // Level 3
    ```
    

### self 프로퍼티

- 모든 인스턴스는 암시적으로 생성된 `self` 프로퍼티를 갖음
- **인스턴스 자기 자신을 가리키는 프로퍼티**
- 인스턴스를 더 명확히 지칭하고 싶을 때 사용
- 위의 코드처럼 level 변수를 사용할 때, 스위프트는 자동으로 메서드 내부에 선언된 지역변수를 먼저 사용하고, 그다음 메서드 매개변수, 그다음 인스턴스의 프로퍼티를 찾아서 level이 무엇을 지칭하는지 유추함
- 그런데 메서드 매개변수의 이름이 level인데, 이 level 매개변수가 아닌 인스턴스 프로퍼티인 level을 지칭하고 싶다면 `self` 프로퍼티를 사용함

- self 프로퍼티의 사용
    
    ```swift
    class LevelClass {
        var level: Int = 0 {
            
        func jumpLevel(to level: Int) {
            print("Jump to \(level)")
            **self.level = level**
        }
    }
    ```
    
- self 프로퍼티의 다른 용도는 값 타입 인스턴스 자체의 값을 치환할 수 있음
- 클래스의 인스턴스는 참조 타입이라서 self 프로퍼티에 다른 참조를 할당할 수 없는데, 구조체나 열거형 등은 self 프로퍼티를 사용하여 자신 자체를 치환할 수도 있음

- self 프로퍼티와 mutating 키워드
    
    ```swift
    class LevelClass {
        var level: Int = 0
    
        func reset() {
    				// 오류! self 프로퍼티 참조 변경 불가!
            self = LevelClass()
        }
    }
    
    struct LevelStruct {
        var level: Int = 0
        
        **mutating** func levelUp() {
            print("Level Up!")
            level += 1
        }
        
        **mutating** func reset() {
            print("Reset!")
            **self = LevelStruct()**
        }
    }
    
    var levelStructInstance: LevelStruct = LevelStruct()
    levelStructInstance.levelUp() // Level Up!
    print(levelStructInstance.level) // 1
    
    levelStructInstance.reset() // Reset!
    print(levelStructInstance.level) // 0
    
    enum OnOffSwitch {
        case on, off
        **mutating** func nextState() {
            self = self == .on ? .off : .on
        }
    }
    
    var toggle: OnOffSwitch = OnOffSwitch.off
    toggle.nextState()
    print(toggle) // on
    ```
    

### 인스턴스를 함수처럼 호출하도록 하는 메서드

- 사용자 정의 명목 타입의 호출 가능한 값(Callable values of user-defined nominal types)을 구현하기 위해 인스턴스를 함수처럼 호출할 수 있도록 하는 메서드(call-as-function method)가 있음
- 특정 타입의 인스턴스를 문법적으로 함수를 사용하는 것처럼 보이게 할 수 있다는 뜻임
- 인스턴스를 함수처럼 호출할 수 있도록 하려면 `callAsFunction`이라는 이름의 메서드를 구현하면 됨
- 이 메서드는 매개변수와 반환 타입만 다르다면 개수에 제한 없이 원하는 만큼 만들 수 있음
- `mutating` 키워드도 사용할 수 있고, `throw`와 `rethrows`도 함께 사용할 수 있음

```swift
struct Puppy {
    var name: String = "멍멍이"
    
    func callAsFunction() {
        print("멍멍")
    }
    
    func callAsFunction(destination: String) {
        print("\(destination)(으)로 달려갑니다")
    }
    
    func callAsFunction(something: String, times: Int) {
        print("\(something)(을)를 \(times)번 반복합니다.")
    }
    
    func callAsFunction(color: String) -> String {
        return "\(color) 응가"
    }
    
    mutating func callAsFunction(name: String) {
        self.name = name
    }
}

var doggy: Puppy = Puppy()
doggy.callAsFunction() // 멍멍
doggy() // 멍멍
doggy.callAsFunction(destination: "집") // 집(으)로 달려갑니다
doggy(destination: "뒷동산") // 뒷동산(으)로 달려갑니다
doggy(something: "재주넘기", times: 3) // 재주넘기(을)를 3번 반복합니다.
print(doggy(color: "무지개색")) // 무지개색 응가
doggy(name: "댕댕이")
print(doggy.name) // 댕댕이
```

- `doggy()` 표현과 `doggy.callAsFunction()` 표현은 완전히 똑같은 표현임
- `doggy(destination: "집")`과 `doggy.callAsFunction(destination: "집")`도 같은 표현임
- 하지만 메서드를 호출하는 것 외에 함수 표현으로는 사용할 수 없음
- 즉, `let function: (String) → Void = doggy(destination:)`처럼은 사용할 수 없음
- 대신에 `let function: (String) → Void = doggy.callAsFunction(destination:)`로 표현해야 함

### 2-2. 타입 메서드

- 타입 자체에 호출이 가능한 메서드
- 메서드 앞에 `static` 키워드를 사용
- 클래스의 타입 메서드는 `static` 키워드와 `class` 키워드를 사용할 수 있음
    - `static`으로 정의하면 상속 후 메서드 재정의 불가능
    - `class`로 정의하면 상속 후 메서드 재정의 가능
    
    ```swift
    class AClass {
        **static** func staticTypeMethod() {
            print("AClass staticTypeMethod")
        }
        
        **class** func classTypeMethod() {
            print("AClass classTypeMethod")
        }
    }
    
    class BClass: AClass {
    		// 오류! 재정의 불가!
        // override static func staticTypeMethod() {
        // }
        
        override class func classTypeMethod() {
            print("BClass classTypeMehtod")
        }
    }
    
    AClass.staticTypeMethod() // AClass staticTypeMethod
    AClass.classTypeMethod() // AClass classTypeMethod
    BClass.classTypeMethod() // BClass classTypeMehtod
    ```
    
- 타입 메서드는 인스턴스 메서드와는 달리 `self` 프로퍼티가 타입 그 자체를 가리킨다는 점이 다름
- 인스턴스 메서드에서는 self가 인스턴스를 가리킨다면 타입 메서드의 self는 타입을 가리킴
- 그래서 타입 메서드 내부에서 타입 이름과 self는 같은 뜻이라고 볼 수 있음
- 그래서 타입 메서드에서 self 프로퍼티를 사용하면 타입 프로퍼티 및 타입 메서드를 호출할 수 있음
    
    ```swift
    // 내비게이션 역할은 여러 인스턴스가 수행할 수 있음
    class Navigation {
        // 내비게이션 인스턴스마다 음량을 따로 설정할 수 있음
        var volume: Int = 5
        
        // 길 안내 음성 재생
        func guideWay() {
            // 내비게이션 외 다른 재생원 음소거
            SystemVolume.mute()
        }
        
        // 길 안내 음성 종료
        func finishGuideWay() {
            // 기존 재생원 음량 복구
            SystemVolume.volume = self.volume
        }
    }
    
    SystemVolume.volume = 10
    
    let myNavi: Navigation = Navigation()
    
    myNavi.guideWay()
    print(SystemVolume.volume) // 0
    
    myNavi.finishGuideWay()
    print(SystemVolume.volume) // 5
    ```