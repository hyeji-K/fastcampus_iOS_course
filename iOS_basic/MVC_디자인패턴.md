# MVC 디자인 패턴

<img src="https://github.com/hyeji-K/fastcampus_iOS_course/blob/main/image/MVC.png" width="800">
<img src="https://github.com/hyeji-K/fastcampus_iOS_course/blob/main/image/MVC2.jpg" width="800">


### **Controller**
How your model is presented to the user (UI logic)

- **Controller**s can always talk directly to their **Model**
    - 모델의 모든 걸 알고 있고 보내고 싶은 메시지를 보낼 수도 있음. 모델 통제
    - 역할은 사용자에게 모델에 있는 것(알고리즘이나 데이터)을 표현하거나 사용자로부터 정보를 받아 모델을 업데이트하는 것이기 때문에 전체적인 통제가 필요
- **Controller**s can also talk directly to their **View**
    - 자신의 뷰를 사용할 수 있어야 함
    - 컨트롤러와 뷰의 연결은 `outlet`을 통해 이루어짐
- **Controller**s interpret/format **Model** information for the **View**.
    - 뷰와 모델 사이의 해석기

<br>

### **Model**
what your application is (but not how it is displayed)

- Can the **Model** talk directly to the **Controller**? Absolutely NOT
    - 컨트롤러는 UI로직을 다루고 모델은 UI와 별개
- So what if the Model has information to update or something?
    - 네트워크 상에서 모델은 데이터를 대표하는데 누군가가 네트워크에 있는 뭔가를 바꿔서 그렇게 되면 모델은 어떻게 컨트롤러에게 알려줄까?
        
        ⇒ Notification & KVO(Key-Value Observing)
        
- 모델은 앱을 설계하는 쪽에 가까움. 모델을 설계하려면 앱이 근본적으로 무엇을 하는지 생각해야함
- 알고리즘이나 데이터, 데이터베이스 같은 것들

<br>

### **View**
your controller minions

- Can the **View** speak to its **Controller**? Yes or No
    - 뷰의 문제는 UIButton 이나 UILabel 같은 뷰의 미니언들이 모두 일반화 되어있는 객체임
    - 뷰와 컨트롤러간의 소통은 제한적
- The **Controller** sets itself as the **View**’s delegate.
- Views do not own the data they display.
- **Controller**s are almost always that data source (not Model!)

<br>

### **Model** ←❌→ **View**

The **Model** and **View** should never speak to each other. 

- 모델은 UI와 독립적
- 뷰는 완전히 UI에 의존적

<br>

🖍️ 일반적으로 iOS에선 MVC 한 개가 아이폰 화면 한 개를 제어하거나 혹은 아이패드 화면에서는 두 개나 세 개의 화면을 제어 ⇒ MVC는 앱의 작은 한 부분을 제어

🖍️ 앱을 만들기 위해서는 여러 MVC를 만들어서 결합해야 함
