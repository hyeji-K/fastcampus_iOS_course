# Property

**저장 프로퍼티(Stored Properties)**
- 인스턴스의 변수 또는 상수를 의미 
- 구조체와 클래스에서만 사용
- 특정 타입의 인스턴스에 사용되는 것

**연산 프로퍼티(Computed Properties)**
- 값을 저장한 것이 아니라 **특정 연산을 실행한 결과값**을 의미
- 클래스, 구조체, 열거형에 사용
- 특정 타입의 인스턴스에 사용되는 것

**타입 프로퍼티(Type Properties)**
- 특정 타입에 사용되는 것
- 클래스의 변수

**프로퍼티 감시자(Property Observers)**
- **프로퍼티의 값이 변하는 것을 감시**
- 프로퍼티의 값이 변할 때 **값의 변화에 따른 특정 작업을 실행**
- 저장 프로퍼티에 적용할 수 있으며 부모클래스로부터 상속받을 수 있음

<br>

## 1. 저장 프로퍼티(Stored Properties)

- 클래스 또는 구조체의 인스턴스와 연관된 값을 저장하는 가장 단순한 개념의 프로퍼티
- `var` 키워드를 사용하면 변수 저장 프로퍼티, `let` 키워드를 사용하면 상수 저장 프로퍼티
- 저장 프로퍼티를 정의할 때, 프로퍼티 기본값과 초기값을 지정해줄 수 있음


> 💡 구조체와 클래스의 저장 프로퍼티 <br>
구조체의 저장 프로퍼티가 옵셔널이 아니더라도, 구조체는 저장 프로퍼티를 모두 포함하는 이니셜라이저를 자동으로 생성함 <br>
클래스의 저장 프로퍼티는 옵셔널이 아니라면 프로퍼티 기본값을 지정해주거나 사용자 정의 이니셜라이저를 통해 반드시 초기화해주어야 함. 또, 클래스 인스턴트의 상수 프로퍼티는 인스턴스가 초기화(이니셜라이즈)될 때 한 번만 값을 할당할 수 있으며, 자식클래스에서 이 초기화를 변경(재정의)할 수 없음

<br>

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
        var point: CoordinatePoint = CoordinatePoint()
        var name: String = "Unknown"
    }
    
    let yagomPosition: Position = Position()
    
    yagomPosition.point = yagomPoint
    yagomPosition.name = "yagom"
    ```
    

> 인스턴스를 생성할 때 이니셜라이저를 통해 초기값을 보내야 하는 이유? <br>
    - 프로퍼티가 옵셔널이 아닌 값으로 선언되어 있기 때문 <br>
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
    
<br>

## 2. 지연 저장 프로퍼티(Lazy Stored Properties)

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
    lazy var point: CoordinatePoint = CoordinatePoint()
    var name: String

    init(name: String) {
        self.name = name
    }
}

let yagomPosition: Position = Position(name: "yagom")

// point 프로퍼티로 처음 접근할 때 point 프로퍼티의 CoordinatePoint가 생성됨
print(yagomPosition.point) // CoordinatePoint(x: 0, y: 0)
```

<br>

## 3. 연산 프로퍼티(Computed Properties)

- 실제 값을 저장하는 프로퍼티가 아니라, **특정 상태에 따른 값을 연산**하는 프로퍼티
- 인스턴스 내/외부의 값을 연산하여 적절한 값을 돌려주는 접근자(getter)의 역할이나 은닉화된 내부의 프로퍼티 값을 간접적으로 설정하는 설정자(setter)의 역할을 할 수도 있음
- 클래스, 구조체, 열거형에 사용
- 굳이 메서드를 두고 왜 연산 프로퍼티를 쓸까?
    - 인스턴스 외부에서 메서드를 통해 인스턴스 내부 값에 접근하려면 메서드를 두 개(접근자, 설정자) 구현해야 함
    - 이를 감수하고 메서드로 구현한다 해도 두 메서드가 분산 구현되어 코드의 가독성이 나빠질 위험이 있음
    - 프로그래머 입장에서는 프로퍼티가 메서드 형식보다 훨씬 더 간편하고 직관적이기도 함
- 읽기 전용 상태로 구현하기 쉽지만, 쓰기 전용 상태로 구현할 수 없다는 단점이 있음

- 연산 프로퍼티의 정의와 사용
    
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
            
            // 설정자
            set(opposite) {
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
                    CoordinatePoint(x: -x, y: -y)
                }
                
                // 설정자
                set {
                    x = -newValue.x
                    y = -newValue.y
                }
            }
        }
        ```

<br> 

## 4. 프로퍼티 감시자(Property Observers)

- 프로퍼티의 값이 새로 할당될 때마다 호출 → 이때 변경되는 값이 현재의 값과 같더라도 호출함
- 저장 프로퍼티뿐만 아니라 프로퍼티를 재정의해 상속받은 저장 프로퍼티 또는 연산 프로퍼티에도 적용할 수 있음
- 상속받지 않은 연산 프로퍼티에는 프로퍼티 감시자를 사용할 필요가 없으며 할 수도 없음
    - 연산 프로퍼티의 접근자와 설정자를 통해 프로퍼티 감시자를 구현할 수 있기 때문
    - 연산 프로퍼티는 상속받았을 때만 프로퍼티 재정의를 통해 프로퍼티 감시자를 사용함
- `willSet` 메서드: 프로퍼티의 값이 **변경되기 직전**에 호출
    - 전달되는 전달인자는 프로퍼티가 변경될 값
    - 매개변수의 이름을 따로 지정하지 않으면 `newValue` 매개변수 이름이 자동 지정
- `didSet` 메서드: 프로퍼티의 값이 **변경된 직후**에 호출
    - 전달되는 전달인자는 프로퍼티가 변경되기 전의 값
    - 매개변수의 이름을 따로 지정하지 않으면 `oldValue` 매개변수 이름이 자동 지정


> 💡 oldValue와 didSet <br>
didSet 감시자 코드 블록 내부에서 oldValue 값을 참조하지 않거나 매개변수 목록에 명시적으로 매개변수를 적어주지 않으면 didSet 코드 블록이 실행되지 않음

<br>

- 프로퍼티 감시자
    
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
    }
    
    let myAccount: Account = Account() 
    // 잔액이 0원에서 1000원으로 변경될 예정입니다.
    myAccount.credit = 1000
    // 잔액이 0원에서 1000원으로 변경되었습니다.
    ```

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
        override var dollarValue: Double {
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
    
> 💡 입출력 매개변수와 프로퍼티 감시자 <br>
만약 프로퍼티 감시자가 있는 프로퍼티를 함수의 입출력 매개변수의 전달인자로 전달한다면 항상 willSet과 didSet 감시자를 호출합니다. 함수 내부에서 값이 변경되든 되지 않든 간에 함수가 종료되는 시점에 값을 다시 쓰기 때문

<br>

## 5. 전역변수와 지역변수

- 전역변수: 함수, 메소드, 클로저 또는 type context **외부**에 정의되는 변수
- 지역변수: 함수, 메소드 또는 클로저 context **내**에 정의되는 변수
- 연산 프로퍼티와 프로퍼티 감시자는 전역변수와 지역변수 모두에 사용할 수 있음.
- 전역변수 또는 지역변수 = 저장변수(저장 프로퍼티처럼 값을 저장하는 역할)
- 전역변수 또는 전역상수는 지연 저장 프로퍼티처럼 처음 접근할 때 최초로 연산이 이루어짐
    - `lazy` 키워드를 사용하지 않아도 됨
- 지역변수 및 지역상수는 절대로 지연 연산되지 않음

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
    
<br>

## 6. 타입 프로퍼티

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
        static var typeProperty: Int = 0
        
        // 저장 인스턴스 프로퍼티
        var instanceProperty: Int = 0 {
            didSet {
                Self.typeProperty = instanceProperty + 100
            }
        }
        
        // 연산 타입 프로퍼티
        static var typeComputedProperty: Int {
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