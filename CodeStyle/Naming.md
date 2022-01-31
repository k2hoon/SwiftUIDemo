# Naming
## Apple’s API Style Guidelines

swift.org에서 Apple [official Swift naming and API design guidelines](https://swift.org/documentation/api-design-guidelines/)은 이 스타일 가이드의 일부로 간주 되며, 
여기에서 전체적으로 반복되는 것처럼 따릅니다.

## Naming Conventions Are Not Access Control

제한된 접근 제어(`internal`, `fileprivate` 또는 `private`)는 네이밍 규칙보다 클라이언트로 부터 정보를 숨기기 위해 선호됩니다.

네이밍 규칙(예: 선행 밑줄 접두사)은 언어 제한을 해결하기 위해 원하는 것보다 더 높은 가시성을 선언에 제공해야 하는 드문 상황에서만 사용됩니다. 
예를 들어 모듈 경계를 넘어 `public`으로 선언되어야 하는 라이브러리 구현의 다른 부분에서만 호출하도록 의도된 메서드가 있는 타입입니다.

## Identifiers

일반적으로 식별자에는 7비트 ASCII 문자만 포함됩니다. 
유니코드 식별자는 코드 기반의 문제 영역에서 명확하고 합법적인 의미(예: 수학 개념을 나타내는 그리스 문자)를 갖고 코드를 소유한 팀에서 잘 이해하는 경우 허용 됩니다.

```swift
✅ Preferred
let smile = "😊"
let deltaX = newX - previousX
let Δx = newX - previousX

⛔️ Not Preferred
let 😊 = "😊"
```

## Initializers

명확성을 위해, 저장된 속성에 직접 대응하는 초기화 인수는 속성과 이름이 같습니다. 명시적 `self.`는 할당하는 동안 명확하게 하기 위해 사용됩니다.

```swift
✅ Preferred
public struct Person {
  public let name: String
  public let phoneNumber: String

  // GOOD.
  public init(name: String, phoneNumber: String) {
    self.name = name
    self.phoneNumber = phoneNumber
  }
}

⛔️ Not Preferred
public struct Person {
  public let name: String
  public let phoneNumber: String

  // AVOID.
  public init(name otherName: String, phoneNumber otherPhoneNumber: String) {
    name = otherName
    phoneNumber = otherPhoneNumber
  }
}
```

## Static and Class Properties

선언하는 타입의 인스턴스를 반환하는 `static` 및 `class` 속성에는 타입 이름이 접미사로 붙지 않습니다.

```swift
✅ Preferred
public class UIColor {
  public class var red: UIColor {                // GOOD.
    // ...
  }
}

public class URLSession {
  public class var shared: URLSession {          // GOOD.
    // ...
  }
}

⛔️ Not Preferred
public class UIColor {
  public class var redColor: UIColor {           // AVOID.
    // ...
  }
}

public class URLSession {
  public class var sharedSession: URLSession {   // AVOID.
    // ...
  }
}
```

`static` 또는 `class` 속성이 선언하는 타입의 단일 인스턴스로 평가될 때, `shared` 및 `default` 이름이 일반적으로 사용 되지만, 해당 스타일 가이드는 이에 대한 특정 이름을 요구하지 않습니다. 
작성자는 타입에 맞는 이름을 선택해야 합니다.

## Global Constants

다른 변수와 마찬가지로, 전역(글로벌) 상수는 `lowerCamelCase`입니다. 앞에 `g` 또는 `k`와 같은 헝가리어 표기법은 사용 되지 않습니다.

```swift
✅ Preferred
let secondsPerMinute = 60

⛔️ Not Preferred
let SecondsPerMinute = 60
let kSecondsPerMinute = 60
let gSecondsPerMinute = 60
let SECONDS_PER_MINUTE = 60
```

## Delegate Methods

대리자 프로토콜과 유사 대리자 프로토콜(예: 데이터 소스)의 메서드는 `Cocoa`의 프로토콜에서 영감을 받은 아래 설명된 언어 구문을 사용하여 이름이 지정됩니다.

> "대리자의 소스 객체"라는 용어는 대리자에서 메서드를 호출하는 객체를 나타냅니다. 
> 예를 들어 `UITableView`는 해당 뷰의 `delegate` 속성으로 설정된 `UITableViewDelegate`의 메서드를 호출하는 소스 객체입니다.

모든 메서드는 대리자의 소스 객체를 첫 번째 인수로 취합니다.

대리자의 소스 객체를 유일한 인수로 취하는 메서드의 경우:

- 만약 메서드가 `Void`를 반환하면(예: 대리자에게 이벤트가 발생했음을 알리는데 사용됨), 해당 메서드의 기본 이름은 대리자의 소스 타입 뒤에 이벤트를 설명하는 직설적 동사구가 옵니다. 
해당 인수에 레이블이 지정되지 않았습니다.

```swift
✅ Preferred
func scrollViewDidBeginScrolling(_ scrollView: UIScrollView)
```

- 만약 메서드가 `Bool`을 반환하는 경우(예: 대리자의 소스 객체 자체에 대한 가정 설정문(`assertion`)을 만드는 메서드), 
해당 메서드의 이름은 대리자의 소스 타입 뒤에 해당 표명을 설명하는 직설적 이거나 또는 조건 동사구가 옵니다. 해당 인수에 레이블이 지정되지 않았습니다.

```swift
✅ Preferred
func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool
```

- 만약 메서드가 다른 값(예: 대리자의 소스 객체 속성에 대한 정보를 쿼리 하는 값)을 반환하는 경우, 해당 메서드의 기본 이름은 쿼리 되는 속성을 설명하는 명사구입니다. 
해당 인수는 명사구와 대리자의 소스 객체를 적절하게 결합하는 전치사 또는 후행 전치사가 있는 구로 라벨이 지정됩니다.

```swift
✅ Preferred
func numberOfSections(in scrollView: UIScrollView) -> Int
```

대리자의 소스 객체 뒤에 추가 인수를 사용하는 메서드의 경우, 메서드의 기본 이름은 그 자체로 대리자의 소스 타입이고 첫 번째 인수에는 레이블이 지정되지 않습니다. 그 다음은 아래와 같습니다.

- 만약 해당 메서드가 `Void`를 반환하면, 두 번째 인수는 직접 목적어 또는 전치사 목적어로 인수가 있는 이벤트를 설명하는 직설 동사 구로 레이블이 지정되고 다른 인수(있는 경우)는 추가 컨텍스트를 제공합니다.

```swift
✅ Preferred
func tableView(
  _ tableView: UITableView,
  willDisplayCell cell: UITableViewCell,
  forRowAt indexPath: IndexPath)
```

- 만약 해당 메서드가 `Bool`을 반환하는 경우, 두 번째 인수는 반환 값을 인수 측면에서 설명하는 직설적인 또는 조건부 동사 구로 레이블이 지정되고, 다른 인수(있는 경우)는 추가 컨텍스트를 제공합니다.

```swift
✅ Preferred
func tableView(
  _ tableView: UITableView,
  shouldSpringLoadRowAt indexPath: IndexPath,
  with context: UISpringLoadedInteractionContext
) -> Bool
```

- 만약 메서드가 다른 값을 반환하면, 두 번째 인수에 명사구와 인수 측면에서 반환 값을 설명하는 후행 전치사로 레이블이 지정되고, 다른 인수(있는 경우)는 추가 컨텍스트를 제공합니다.

```swift
✅ Preferred
func tableView(
  _ tableView: UITableView,
  heightForRowAt indexPath: IndexPath
) -> CGFloat
```
