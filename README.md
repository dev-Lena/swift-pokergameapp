# LENA의 Poker Game App

# Poker Game App 

## 목차

- [pokergameapp-step1](#pokergameapp-step1): StackView를 통해 동일한 비율의 7개 카드(뒷면)가 동일한 간격으로 수평으로 나열 
- [pockerGameApp-step2](#pockerGameApp-step2): 카드 클래스 생성


### pokergameapp-step1
02.08 23:30


1. 코드로 StatusBar 스타일을 LightContent로 변경

  ```swift
   override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
   }
  ```

  ![](https://i.imgur.com/nP2o4mY.png)
  (왼쪽 스냅샷 : 설정 전, 오른쪽 스냅샷 : 설정 후)

2. view 배경에 들어갈 패턴 이미지를 Assets에 추가 후, 패턴 이미지 적용
![](https://i.imgur.com/hwgvBE0.png)

3. 카드 뒷면 이미지 Assets에 추가

02.09 20:50

![image-20200209190050604](/Users/keunnalee/Library/Application Support/typora-user-images/image-20200209190050604.png)

4. ViewController 클래스에서 코드로 화면을 균등하게 7등분해서 7개 UIImageView를 추가
   : 뷰를 7개 만들어서 Auto Layout으로 직접 하나하나 제약을 설정하는 방법 외에 다른 방법을 찾다가 UIStackView를 알게되서 StackView를 사용해서 구현.
- 4-1 StackView 생성
  : StackView.translatesAutoresizingMaskIntoConstraints = false로 설정 변경.
  axis(배치 방향 설정하는 속성)을 수평으로 설정.
  distribution(Axis와 동일한 축에서 subView의 크기와 배치방식 설정하는 속성)을 Fill Equally로 설정.
  spacing(수평/수직 간격 설정하는 속성) 설정.
- 4-2 card 생성 
: 가로 세로 비율을 1:1.27로 설정.
  비율을 유지하도록 Content Mode를 scaleAspectFit로 설정.
- 4-3 7개의 card를 만들어 StackView에 추가 
- 4-4 StackView 제약 설정

5. RootView에 Subview로 StackView 추가 

1. AutoLayout이 어떤 레이아웃 시스템이고 어떤 맥락에서 생겼는지 알게 됐습니다.

2. AutoLayout에서 제약을 추가할 때 필요한 키워드(multiplier, first item, second item, safe area 등)를 알게 됐습니다.

3. StackView관련 메소드와 StackView에 제약을 주는 키워드(axis,distribution,spacing,alignment)를 알게 됐고 써봤습니다.

### pockerGameApp-step2
02.10 21:00

0. testCode 작성
![](https://i.imgur.com/E5x9EX6.png)

1. Card class 생성

2. Suit enum 생성

3. Rank enum 생성

4. enum을 선택한 이유
**4-1.** 카드의 Rank와 Suit는 이미 정해져 있고(추후 수정되거나 추가되지 않기 때문에) 각각 같은 한 타입이기 때문에 배열이나 딕셔너리가 아닌 enum을 선택했습니다.
**4-2.** 사실 지금 메모리를 고려하는게 맞는지 모르겠지만 클래스 같은 경우에는 인스턴스 생성 후 인스턴스를 해지하지 않으면 메모리에 계속 남아있지만 enum은 사용을 다하면 자동으로 스택에서 사라지기 때문에 enum이 더 낫다고 생각했습니다.
**4-3.** 프로퍼티를 호출할 때 클래스에서는 프로퍼티를 호출할 때 마다 "Suit().hearts" 이런 식으로 명시해줘야 하지만 enum은 추론 가능할 때 ".eight"과 같이 표현할 수 있어서 더 편하다고 생각했습니다.

5. Card Class 프로퍼티와 init 메소드 추가 

6. 카드 정보를 출력하기 위한 문자열을 반환하는 메소드 구현

7. ViewController에 카드 정보를 출력하는 메소드 구현

   ![image-20200210212217610](/Users/keunnalee/Library/Application Support/typora-user-images/image-20200210212217610.png)

