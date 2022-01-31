# Formatting Specific Constructs

## Non-Documentation Comments

문서가 아닌 주석은 항상 이중 슬래시 형식(`//`)을 사용하며, C 스타일 블록 형식(`/* ... */`)은 사용하지 않습니다.

## Properties

지역 변수는 범위를 최소화하기 위해 (합리적으로) 처음 사용 되는 지점에 가깝게 선언됩니다.
튜플 구조 해제를 제외하고 모든 `let` 또는 `var` 문(속성이든 로컬 변수이든)은 정확히 하나의 변수를 선언합니다.

```swift
✅ Preferred
var a = 5
var b = 10

let (quotient, remainder) = divide(100, 9)

⛔️ Not Preferred
var a = 5, b = 10
```

## Switch Statements

`Case`문은 속해 있는 `switch`문과 동일하게 들여쓰기 됩니다. 그런 다음 case 블록 내부의 명령문은 +2칸 들여쓰기 됩니다.

```swift
✅ Preferred
switch order {
case .ascending:
  print("Ascending")
case .descending:
  print("Descending")
case .same:
  print("Same")
}

⛔️ Not Preferred
switch order {
  case .ascending:
    print("Ascending")
  case .descending:
    print("Descending")
  case .same:
    print("Same")
}

⛔️ Not Preferred
switch order {
case .ascending:
print("Ascending")
case .descending:
print("Descending")
case .same:
print("Same")
}
```

## Enum Cases

일반적으로 `enum`에는 한 줄에 하나의 `case`만 있습니다. 
쉼표로 구분된 형식은 
- `associated value`이나 `raw value`가 없는 case
- 모든 케이스가 한 줄에 들어가거나
- case 이름의 의미가 분명해서 추가 문서가 필요하지 않은 경우에만 사용할 수 있습니다.

```swift
✅ Preferred
public enum Token {
  case comma
  case semicolon
  case identifier
}

public enum Token {
  case comma, semicolon, identifier
}

public enum Token {
  case comma
  case semicolon
  case identifier(String)
}

⛔️ Not Preferred
public enum Token {
  case comma, semicolon, identifier(String)
}
```

`enum`의 모든 케이스가 `indirect`이어야 하는 경우, `enum` 자체가 `indirect`로 선언되고 개별 케이스에서 해당 키워드가 생략됩니다.

```swift
✅ Preferred
public indirect enum DependencyGraphNode {
  case userDefined(dependencies: [DependencyGraphNode])
  case synthesized(dependencies: [DependencyGraphNode])
}

⛔️ Not Preferred
public enum DependencyGraphNode {
  indirect case userDefined(dependencies: [DependencyGraphNode])
  indirect case synthesized(dependencies: [DependencyGraphNode])
}
```

`enum` 케이스에 `associated value`이 없으면, 빈 괄호로 절대 표시되지 않습니다.

```swift
✅ Preferred
public enum BinaryTree<Element> {
  indirect case node(element: Element, left: BinaryTree, right: BinaryTree)
  case empty  // GOOD.
}

⛔️ Not Preferred
public enum BinaryTree<Element> {
  indirect case node(element: Element, left: BinaryTree, right: BinaryTree)
  case empty()  // AVOID.
}
```

열거형의 케이스는 설명할 수 있는 논리적 순서를 따라야 합니다. 분명한 논리적인 순서가 없는 경우, 케이스 이름을 기반으로 사전 순서를 사용합니다.

다음 예에서는, 기본 HTTP 상태 코드를 기반으로 케이스를 숫자 순서로 정렬하고 빈 줄을 사용하여 그룹을 구분합니다.

```swift
✅ Preferred
public enum HTTPStatus: Int {
  case ok = 200

  case badRequest = 400
  case notAuthorized = 401
  case paymentRequired = 402
  case forbidden = 403
  case notFound = 404

  case internalServerError = 500
}
```

다음 버전은 동일한 열거형 이지만 가독성이 떨어집니다. 케이스가 사전순으로 정렬되어 있지만, 관련 값의 의미 있는 그룹화가 손실 되었습니다.

```swift
⛔️ Not Preferred
public enum HTTPStatus: Int {
  case badRequest = 400
  case forbidden = 403
  case internalServerError = 500
  case notAuthorized = 401
  case notFound = 404
  case ok = 200
  case paymentRequired = 402
}
```

## Trailing Closures

함수는 두 개의 `overload`가 후행 클로저의 **인수 이름**에 의해서만 달라 지도록 `overload`되어서는 안 됩니다. 
이렇게 하면 후행 클로저 구문 사용이 방지되어, 레이블이 없으면 후행 클로저가 있는 함수에 대한 호출이 모호해집니다.

다음 예는 후행 클로저 구문을 사용하여, `greet`가 모호하게 호출되는 상황입니다.

```swift
⛔️ Not Preferred
func greet(enthusiastically nameProvider: () -> String) {
  print("Hello, \(nameProvider())! It's a pleasure to see you!")
}

func greet(apathetically nameProvider: () -> String) {
  print("Oh, look. It's \(nameProvider()).")
}

greet { "John" }  // error: ambiguous use of 'greet'
```

다음 예시는 클로저 인수가 아닌 함수 이름으로 구별하도록 수정되었습니다.

```swift
✅ Preferred
func greetEnthusiastically(_ nameProvider: () -> String) {
  print("Hello, \(nameProvider())! It's a pleasure to see you!")
}

func greetApathetically(_ nameProvider: () -> String) {
  print("Oh, look. It's \(nameProvider()).")
}

greetEnthusiastically { "John" }
greetApathetically { "not John" }
```

만약 함수 호출에 여러 개의 클로저 인수가 있으면, 모두 후행 클로저 구문을 사용하여 호출하지 않습니다. 모두 인수 목록 괄호 안에 중첩 시키고 레이블을 지정합니다.

```swift
✅ Preferred
UIView.animate(
  withDuration: 0.5,
  animations: {
    // ...
  },
  completion: { finished in
    // ...
  })

⛔️ Not Preferred
UIView.animate(
  withDuration: 0.5,
  animations: {
    // ...
  }) { finished in
    // ...
  }
```

함수에 단일 클로저 인수가 있고 해당 클로저가 최종 인수인 경우, 모호성 또는 구문 분석 오류를 해결하기 위해 다음과 같은 경우를 제외하고 항상 후행 클로저 구문을 사용하여 호출됩니다.

- 위에서 설명한 대로, 레이블이 지정된 클로저 인수는 모호한 동일한 인수 목록이 있는 두 오버로드 사이를 명확하게 하는데 사용해야 합니다.
- 레이블이 지정된 클로저 인수는 후행 클로저의 본문이 제어 흐름 문의 본문으로 구문 분석되어(`parse`) 제어 흐름 문에서 사용해야 합니다.

```swift
✅ Preferred
Timer.scheduledTimer(timeInterval: 30, repeats: false) { timer in
  print("Timer done!")
}

if let firstActive = list.first(where: { $0.isActive }) {
  process(firstActive)
}

⛔️ Not Preferred
Timer.scheduledTimer(timeInterval: 30, repeats: false, block: { timer in
  print("Timer done!")
})

// This example fails to compile.
if let firstActive = list.first { $0.isActive } {
  process(firstActive)
}
```

후행 클로저 구문으로 호출된 함수가 다른 인수를 취하지 않으면, 함수 이름 뒤에 빈 괄호(`()`)가 절대 표시되지 않습니다.

```swift
✅ Preferred
let squares = [1, 2, 3].map { $0 * $0 }

⛔️ Not Preferred
let squares = [1, 2, 3].map({ $0 * $0 })
let squares = [1, 2, 3].map() { $0 * $0 }
```

## Trailing Commas

`array` 및 `dictionary` 리터럴의 후행 쉼표는 각 요소가 자체 행에 배치될 때 필요합니다. 이렇게 하면 나중에 항목이 해당 리터럴에 추가될 때 더 깨끗한 `diff`가 생성됩니다.

```swift
✅ Preferred
let configurationKeys = [
  "bufferSize",
  "compression",
  "encoding", // GOOD.
]

⛔️ Not Preferred
let configurationKeys = [
  "bufferSize",
  "compression",
  "encoding" // AVOID.
]
```

## Numeric Literals

긴 숫자 리터럴(10진수, 16진수, 8진수 및 2진수)은 리터럴에 숫자 값이 있거나 도메인 별 그룹이 있는 경우, 가독성을 위해 밑줄(`_`) 구분 기호를 사용하여 숫자를 그룹화하는 것이 권장되지만 필수는 아닙니다.

권장되는 그룹화는 10진수의 경우 3자리(천 단위 구분 기호), 16진수의 경우 4자리, 2진 리터럴의 경우 4 또는 8자리 또는 값별 필드 경계가 있는 경우(예: 8진수 파일 권한의 경우 3자리)입니다.

만약 리터럴이 의미 있는 숫자 값이 없는 불투명한 식별자인 경우 숫자를 그룹화 하지 않습니다.

## Attributes

매개변수화된 속성(예: `@availability(...)` 또는 `@objc(...)`)은 각각 해당 속성이 적용되는 선언 직전에 자체 행에 작성되고 사전순으로 정렬 되며, 선언과 동일한 수준에서 들여쓰기 됩니다.

```swift
✅ Preferred
@available(iOS 9.0, *)
public func coolNewFeature() {
  // ...
}

⛔️ Not Preferred
@available(iOS 9.0, *) public func coolNewFeature() {
  // ...
}
```

매개변수가 없는 속성은 사전순으로 정렬 되며, 줄을 다시 묶지 않고도 해당 줄에 맞는 경우에만 선언과 같은 줄에 배치할 수 있습니다. 
만약 선언과 같은 줄에 속성을 배치하기 위해 이전에는 래핑할 필요가 없었던 선언을 래핑해야 하는 경우, 속성은 자체 줄에 배치됩니다.

```swift
✅ Preferred
public class MyViewController: UIViewController {
  @IBOutlet private var tableView: UITableView!
}
```
