# General Formatting

## Column Limit
코드의 열 제한은 100자 입니다. 아래에 명시된 경우들을 제외하고, 열 제한을 초과하는 모든 줄은 아래 설명된 대로 줄 바꿈을 해야 합니다.

**Exceptions:**
1. 주석에 열 제한을 초과하는 긴 `URL`이 있는 경우 처럼, 줄 바꿈을 하지 않아야 의미가 있는 텍스트 단위는 열 제한을 준수하지 않아도 됩니다.
2. `import` 문.
3. 다른 도구에서 생성된 코드.

## Braces
일반적으로, 중괄호는 비어 있지 않은 블록에서 `Kernighan and Ritchie(K&R)` 스타일을 따릅니다.
- 줄 바꿈 규칙 적용이 필요한 경우가 아니라면, 여는 중괄호(`{`) 앞에 줄 바꿈이 없습니다.
- 아래 예외를 제외하고, 여는 중괄호(`{`) 뒤에 줄 바꿈을 적용합니다.
    - 클로저에서, 클로저의 기호가 중괄호와 같은 줄에 있는 경우, `in` 키워드 다음에 줄 바꿈 할 수 있습니다.
    - 아래 `One Statement Per Line`에 설명된 대로 줄 바꿈을 생략할 수도 있습니다.
    - 빈 블록은 `{}`로 쓸 수 있습니다.
- 줄 바꿈과 함께 닫는 중괄호(`}`) 함께 사용합니다. 단, `One Statement Per Line`에 설명된 대로 생략하거나 빈 블록을 완성하는 경우는 예외 입니다.
- 닫는 중괄호(`}`) 뒤에 줄 바꿈은 해당 중괄호가 명령문이나 선언문 본문을 종료하는 경우에만 해당되며, 예를 들어, `else` 블록은 같은 경우는 줄에 두 중괄호를 사용하여 `} else {`로 작성됩니다.

## Semicolons
세미콜론(`;`)은 사용 되지 않습니다. **즉, 세미콜론이 사용할 수 있는 유일한 위치는 문자열 리터럴 또는 주석 내부 뿐입니다.**

```swift
✅ Preferred
func sum(_ a: Int, _ b: Int) {
  let sum = a + b
  print(sum)
}

⛔️ Not Preferred
func sum(_ a: Int, _ b: Int) {
  let sum = a + b;
  print(sum);
}
```

## One Statement Per Line
한 줄에 최대 하나의 명령문이 있으며, 각 명령문 뒤에는 줄 바꿈이 옵니다. 단, 0개 또는 1개의 명령문이 포함된 블록으로 줄이 끝나는 경우는 예외로 줄 바꿈을 안 해도 됩니다.

```swift
✅ Preferred
guard let someValue = value else { return 0 }

defer { file.close() }

switch someEnum {
  case .first: return 1
  case .second: return 2
  case .third: return 3
}

let squares = numbers.map { $0 * $0 }

var someProperty: Int {
  get { return someObject.property }
  set { someObject.property = newValue }
}

var someProperty: Int { return someObject.somethingElse() }

required init?(coder aDecoder: NSCoder) { fatalError("no coder") }
```

위와 같이 단일 명령문 블록의 본문을 한 줄로 묶는 것이 허용 되며, 조건문과 본문을 같은 줄에 배치할지의 결정은 작성자가 상황에 따라 잘 판단하면 됩니다.
예를 들어, 한 줄 조건문은 조기 반환 이나 기본 정리 작업에 유용하지만, 본문에 로직 작성 시, 함수 호출이 포함된 경우에 가독성이 떨어진다거나 판단이 확실하지 않은 경우, 여러 줄로 작성하면 됩니다.

## Line-Wrapping
**용어 참고**: 줄 바꿈은 한 줄을 차지할 수 있는 여러 줄로 코드를 눕니다. 
`Swift` 코드 스타일을 위해, 많은 선언(예: 타입 선언 및 함수 선언)과 기타 표현식(예: 함수 호출)은 **분리할 수 없는** 구분 토큰 시퀀스로 구분되는 **분리 가능한** 단위로 분할될 수 있습니다.

예를 들어, 다음과 같이 복잡한 함수 선언은 줄 바꿈이 필요합니다. (전체 예시를 보려면 가로로 스크롤 하면 됩니다.) 

```swift
⛔️ Not Preferred
public func index<Elements: Collection, Element>(of element: Element, in collection: Elements) -> Elements.Index? where Elements.Element == Element, Element: Equatable {
  // ...
}
```

해당 선언은 다음과 같이 나뉩니다. 
**분리할 수 없는** 토큰 시퀀스는 주황색으로 표시되고, **분리 가능한** 시퀀스는 파란색으로 표시됩니다.

```swift
public func index< Elements: Collection, Element >( 
  of element: Element, 
  in collection: Elements
) -> Elements.Index? 
where 
  Elements.Element == Element, 
  Element: Equatable {
  // ...
}
```

1. 제네릭 인수 리스트를 시작하는 여는 꺾쇠 괄호(`<`) 까지 **분리할 수 없는** 토큰 시퀀스(**`public func index<`**) 입니다. 
2. **분리 가능한** 제네릭 인수 리스트(**`Elements: Collection, Element`**)입니다. 
3. 형식 인수에서 일반 인수를 구분하는 **분리할 수 없는** 토큰 시퀀스(`**>(**`) 입니다.
4. 쉼표로 구분된 **분리 가능한** 형식 인수 목록(**`of element: Element, in collection: Elements`**)입니다. 
5. 닫는 괄호(`)`)부터 반환 타입 앞에 오는 화살표(`->`)까지 **분리할 수 없는** 토큰 시퀀스 입니다.
6. **분리 가능한** 반환 유형(**`Elements.Index?`**)입니다. 
7. 제네릭 제약 조건 리스트를 시작하는 **분리할 수 없는** `where`키워드 입니다.
8. 쉼표로 구분된 **분리 가능한** 제네릭 제약 조건 리스트(**`Elements.Element == Element, Element: Equatable`**)입니다.

이러한 개념을 사용하여, 줄 바꿈을 위한 `Swift` 스타일의 기본 규칙은 다음과 같습니다.

1. 만약 전체 선언, 명령문 그리고 표현식이 한 줄로 표현이 가능한 경우, 한 줄로 표현하면 됩니다.
2. 쉼표로 구분된 리스트는 가로 또는 세로 방향으로만 배치됩니다. 즉, 모든 요소를 같은 줄에 작성하거나 각 요소를 줄 바꿈으로 작성되어야 합니다.
가로 방향으로 표현되는 요소 리스트는 첫 번째 요소 앞과 마지막 요소 뒤에도 줄 바꿈을 하지 않습니다.
제어 흐름 문을 제외하고, 세로 방향으로 표현되는 요소 리스트는 첫 번째 요소 앞과 각 요소 뒤에 줄 바꿈을 합니다.
3. 분리할 수 없는 토큰 시퀀스로 시작하는 연속된 줄은 첫 줄과 같은 수준으로 들여쓰기 됩니다.
4. 세로 방향으로 쉼표와 함께 구분되는 리스트는 첫 줄에서 정확히 두칸(`+2`) 들여쓰기 됩니다.
5. 여는 중괄호(`{`)가 줄 바꿈 이나 표현식 뒤에 올 때, 해당 줄이 원래 줄에서 두칸(`+2`)로 들여쓰기 되지 않는 한, 최종 라인과 같은 라인에 있습니다. 
이 경우, 연속되는 라인이 뒤에 오는 블록의 본문과 시각적으로 혼합되는 것을 방지하기 위해 중괄호가 자체적인 라인에 배치 됩니다.

```swift
✅ Preferred
public func index<Elements: Collection, Element>(
  of element: Element,
  in collection: Elements
) -> Elements.Index?
where
  Elements.Element == Element,
  Element: Equatable
{  // GOOD.
  for current in elements {
    // ...
  }
}

⛔️ Not Preferred
public func index<Elements: Collection, Element>(
  of element: Element,
  in collection: Elements
) -> Elements.Index?
where
  Elements.Element == Element,
  Element: Equatable {  // AVOID.
  for current in elements {
    // ...
  }
}

```

제네릭 제약 조건이 뒤에 오는 `where` 절을 포함하는 선언의 경우, 추가 규칙이 적용됩니다.
1. 만약 제네릭 제약 조건 리스트가 반환 타입과 동일한 라인에 배치될 때, 열 제한을 초과하면 `where` 키워드 앞에 줄 바꿈을 먼저 하고, `where` 키워드는 원래 라인과 같은 수준에서 들여쓰기 됩니다.
2. 만약 위의 줄 바꿈을 한 후에도, 제네릭 제약 조건 리스트가 열 제한을 초과하는 경우, 제약 조건 리스트는 `where` 키워드 뒤에 줄 바꿈이 있고 최종 제약 조건 뒤에 줄 바꿈이 있는 세로 방향으로 지정됩니다.

이에 대한 구체적인 예는 아래 관련 하위 섹션에 나와 있습니다.

위와 같은 줄 바꿈 스타일을 사용하면, 파일 전체에 동일한 들여쓰기 수준을 유지하면서 들여쓰기와 줄 바꿈을 사용하여 가독성을 높일 수 있고,
특히 다른 언어에서 여는 괄호를 기반으로 인수를 들여쓰는 경우 나타날 수 있는 지그재그 효과를 방지할 수 있습니다.

```swift
⛔️ Not Preferred
public func index<Elements: Collection, Element>(of element: Element,  // AVOID.
                                                 in collection: Elements) -> Elements.Index?
    where Elements.Element == Element, Element: Equatable {
  doSomething()
}
```

## Function Declarations

```swift
modifiers func name( formal arguments ) {

modifiers func name( formal arguments ) -> result {

modifiers func name< generic arguments >( formal arguments ) throws -> result {

modifiers func name< generic arguments >( formal arguments ) throws -> result where generic constraints {
```

위의 예시를 줄 바꿈 규칙에 적용하면 다음과 같이 나타낼수 있습니다.
```swift
✅ Preferred
public func index<Elements: Collection, Element>(
  of element: Element,
  in collection: Elements
) -> Elements.Index? where Elements.Element == Element, Element: Equatable {
  for current in elements {
    // ...
  }
}
```

닫는 괄호(`)`)로 끝나는 프로토콜의 함수 선언은 괄호를 최종 인수와 같은 줄 또는 줄을 바꿀수 있습니다.
```swift
✅ Preferred
public protocol ContrivedExampleDelegate {
  func contrivedExample(
    _ contrivedExample: ContrivedExample,
    willDoSomethingTo someValue: SomeValue)
}

public protocol ContrivedExampleDelegate {
  func contrivedExample(
    _ contrivedExample: ContrivedExample,
    willDoSomethingTo someValue: SomeValue
  )
}
```

만약 타입이 복잡하거나 깊게 중첩된 경우, 인수, 제약 리스트 또는 반환 타입의 개별 요소도 래핑 해야 할 수도 있습니다. 드문 경우 지만, 선언 자체에 적용되는 것과 동일한 줄 바꿈 규칙이 적용됩니다.
```swift
✅ Preferred
public func performanceTrackingIndex<Elements: Collection, Element>(
  of element: Element,
  in collection: Elements
) -> (
  Element.Index?,
  PerformanceTrackingIndexStatistics.Timings,
  PerformanceTrackingIndexStatistics.SpaceUsed
) {
  // ...
}
```

하지만 `typealiases`나 다른 수단은 가능할 때마다 복잡한 선언을 단순화하는 더 좋은 방법인 경우가 많습니다.

## Type and Extension Declarations
아래 예제는 `class`, `struct`, `enum`, `extension` 및 `protocol`에 동일하게 적용됩니다. (첫 번째만 상속 목록에 슈퍼클래스가 없다는 점을 제외하고 구조적으로 유사다.)

```swift
modifiers class Name {

modifiers class Name: superclass and protocols {

modifiers class Name< generic arguments >: superclass and protocols {

modifiers class Name< generic arguments >: superclass and protocols where generic constraints {
```
```swift
✅ Preferred
class MyClass:
  MySuperclass,
  MyProtocol,
  SomeoneElsesProtocol,
  SomeFrameworkProtocol
{
  // ...
}

class MyContainer<Element>:
  MyContainerSuperclass,
  MyContainerProtocol,
  SomeoneElsesContainerProtocol,
  SomeFrameworkContainerProtocol
{
  // ...
}

class MyContainer<BaseCollection>:
  MyContainerSuperclass,
  MyContainerProtocol,
  SomeoneElsesContainerProtocol,
  SomeFrameworkContainerProtocol
where BaseCollection: Collection {
  // ...
}

class MyContainer<BaseCollection>:
  MyContainerSuperclass,
  MyContainerProtocol,
  SomeoneElsesContainerProtocol,
  SomeFrameworkContainerProtocol
where
  BaseCollection: Collection,
  BaseCollection.Element: Equatable,
  BaseCollection.Element: SomeOtherProtocolOnlyUsedToForceLineWrapping
{
  // ...
}
```

## Function Calls
함수 호출이 줄 바꿈될 때, 각 인수는 원래 줄에서 두칸(`+2`) 들여쓰기로 줄 바꿈되어 작성됩니다.
함수 선언과 마찬가지로, 만약 함수 호출이 명령문을 종료하고 닫는 괄호(`)`)로 끝나는 경우, (즉, 후행 클로저가 없는 경우) 괄호는 최종 인수와 같은 줄 또는 자체 줄에 위치할 수 있습니다.

```swift
✅ Preferred
let index = index(
  of: veryLongElementVariableName,
  in: aCollectionOfElementsThatAlsoHappensToHaveALongName)

let index = index(
  of: veryLongElementVariableName,
  in: aCollectionOfElementsThatAlsoHappensToHaveALongName
)
```

만약 함수 호출이 후행 클로저로 끝나고 클로저의 기호가 래핑 되어야 하는 경우, 자체 줄에 배치하고 인수 리스트를 바로 아래에 있는 클로저 본문과 구별하기 위해 괄호로 묶습니다.
```swift
✅ Preferred
someAsynchronousAction.execute(withDelay: howManySeconds, context: actionContext) {
  (context, completion) in
  doSomething(withContext: context)
  completion()
}
```

## Control Flow Statements
제어 흐름 문(예: `if`, `guard`, `while` 또는 `for`)이 래핑 되면, 첫 번째 연속 행이 제어 흐름 키워드 다음에 오는 토큰과 동일한 위치로 들여쓰기 됩니다. 
추가 연속 행이 만약 구문적으로 병렬 요소인 경우, 동일한 위치에서 들여쓰거나, 구문적으로 중첩된 경우, 해당 위치에서 두칸 (`+2`) 들여씁니다.

제어 흐름 문의 본문 앞의 여는 중괄호(`{`)는 마지막 연속 행과 같은 행에 배치하거나 제어 흐름 문의 시작과 같은 들여쓰기 수준에서 다음 줄에 둘 수 있습니다. 
`guard` 문의 경우, `else {`는 같은 행이나 다음 줄에 함께 유지되어야 합니다.
```swift
✅ Preferred
if aBooleanValueReturnedByAVeryLongOptionalThing() &&
   aDifferentBooleanValueReturnedByAVeryLongOptionalThing() &&
   yetAnotherBooleanValueThatContributesToTheWrapping() {
  doSomething()
}

if aBooleanValueReturnedByAVeryLongOptionalThing() &&
   aDifferentBooleanValueReturnedByAVeryLongOptionalThing() &&
   yetAnotherBooleanValueThatContributesToTheWrapping()
{
  doSomething()
}

if let value = aValueReturnedByAVeryLongOptionalThing(),
   let value2 = aDifferentValueReturnedByAVeryLongOptionalThing() {
  doSomething()
}

if let value = aValueReturnedByAVeryLongOptionalThing(),
   let value2 = aDifferentValueReturnedByAVeryLongOptionalThingThatForcesTheBraceToBeWrapped()
{
  doSomething()
}

guard let value = aValueReturnedByAVeryLongOptionalThing(),
      let value2 = aDifferentValueReturnedByAVeryLongOptionalThing() else {
  doSomething()
}

guard let value = aValueReturnedByAVeryLongOptionalThing(),
      let value2 = aDifferentValueReturnedByAVeryLongOptionalThing()
else {
  doSomething()
}

for element in collection
    where element.happensToHaveAVeryLongPropertyNameThatYouNeedToCheck {
  doSomething()
}
```

### Other Expressions
함수 호출이 아닌 다른 표현식을 줄 바꿈할 때(위에서 설명한 대로), 두 번째 줄(첫 번째 줄바꿈 바로 다음에 오는 줄)은 원래 줄에서 정확히 두칸(`+2`) 들여쓰기 됩니다.

연속 행이 여러 개 있는 경우, 필요에 따라 두 칸(`+2`) 단위로 들여쓰기를 변경할 수 있습니다. 일반적으로 두 개의 연속 행은 구문상 병렬 요소로 시작하는 경우에만 동일한 들여쓰기 수준을 사용합니다. 
하지만 만약 길게 래핑된 표현식 으로 인해 연속 행이 많은 경우, 가능하면 임시 변수를 사용하여 여러 문장으로 분할하는 것을 고려해야 합니다.
```swift
✅ Preferred
let result = anExpression + thatIsMadeUpOf * aLargeNumber +
  ofTerms / andTherefore % mustBeWrapped + (
    andWeWill - keepMakingItLonger * soThatWeHave / aContrivedExample)

⛔️ Not Preferred
let result = anExpression + thatIsMadeUpOf * aLargeNumber +
    ofTerms / andTherefore % mustBeWrapped + (
        andWeWill - keepMakingItLonger * soThatWeHave / aContrivedExample)
```

## Horizontal Whitespace
**용어 참고:** 이 섹션에서 가로 공백은 내부 공백을 의미합니다. 해당 규칙은 줄 시작 시, 추가 공백을 요구하거나 금지하는 것으로 해석되지 않습니다.

다른 언어 또는 다른 스타일 규칙에서 요구하는 위치에 상관없이, 리터럴 또는 주석을 제외하고 단일 유니코드 공백도 다음 위치에만 나타냅니다.

1. 조건부 또는 `switch`문(예: `if`, `guard`, `while` 또는 `switch`)으로 시작하는 **예약어** 뒤에 오는 표현식이 여는 괄호(`(`)로 시작하는 경우, 표현식과 분리합니다.
```swift
✅ Preferred
if (x == 0 && y == 0) || z == 0 {
  // ...
}

⛔️ Not Preferred
if(x == 0 && y == 0) || z == 0 {
  // ...
}
```

2. 같은 줄의 코드 뒤에 오는 닫는 중괄호(`}`) 앞, 여는 중괄호(`{`) 앞, 같은 줄의 코드 뒤에 오는 여는 중괄호(`{`) 뒤.
```swift
✅ Preferred
let nonNegativeCubes = numbers.map { $0 * $0 * $0 }.filter { $0 >= 0 }

⛔️ Not Preferred
let nonNegativeCubes = numbers.map { $0 * $0 * $0 } .filter { $0 >= 0 }
let nonNegativeCubes = numbers.map{$0 * $0 * $0}.filter{$0 >= 0}
```

3. *On both sides* of any binary or ternary operator, including the “operator-like” symbols described below, with exceptions noted at the end: 
아래에 설명된 "연산자와 유사한" 기호를 포함하여, 이항 또는 삼항 연산자의 양쪽에 있으며 끝에 표시된 예외는 다음과 같습니다.
    - 할당, 변수 및 속성 초기화, 그리고 함수의 기본 인수에 사용 되는 `=` 기호.
    
    ```swift
    ✅ Preferred
    var x = 5
    
    func sum(_ numbers: [Int], initialValue: Int = 0) {
      // ...
    }
    
    ⛔️ Not Preferred
    var x=5
    
    func sum(_ numbers: [Int], initialValue: Int=0) {
      // ...
    }
    ```
    
    - 프로토콜 구성 유형의 앰퍼샌드(`&`).
    
    ```swift
    ✅ Preferred
    func sayHappyBirthday(to person: NameProviding & AgeProviding) {
      // ...
    }
    
    ⛔️ Not Preferred
    func sayHappyBirthday(to person: NameProviding&AgeProviding) {
      // ...
    }
    ```
    
    - 해당 연산자를 선언/구현하는 함수의 연산자 기호.
    
    ```swift
    ✅ Preferred
    static func == (lhs: MyType, rhs: MyType) -> Bool {
      // ...
    }
    
    ⛔️ Not Preferred
    static func ==(lhs: MyType, rhs: MyType) -> Bool {
      // ...
    }
    ```
    
    - 함수의 반환 유형 앞에 있는 화살표(`->`).
    
    ```swift
    ✅ Preferred
    func sum(_ numbers: [Int]) -> Int {
      // ...
    }
    
    ⛔️ Not Preferred
    func sum(_ numbers: [Int])->Int {
      // ...
    }
    ```
    
    - **예외로 값 및 타입 멤버를 참조하는데 사용 되는 점(`.`)의 양쪽에는 공백이 없습니다.**
    
    ```swift
    ✅ Preferred
    let width = view.bounds.width
    ⛔️ Not Preferred
    let width = view . bounds . width
    ```
    
    - **예외로 범위 표현식에 사용 되는 `..<` 또는 `...` 연산자의 양쪽에는 공백이 없습니다.**
    
    ```swift
    ✅ Preferred
    for number in 1...5 {
      // ...
    }
    
    let substring = string[index..<string.endIndex]
    
    ⛔️ Not Preferred
    for number in 1 ... 5 {
      // ...
    }
    
    let substring = string[index ..< string.endIndex]
    ```
    
4. 매개변수 목록과 튜플/배열/사전 리터럴의 쉼표(`,`) 앞이 아닌 뒤.

```swift
✅ Preferred
let numbers = [1, 2, 3]

⛔️ Not Preferred
let numbers = [1,2,3]
let numbers = [1 ,2 ,3]
let numbers = [1 , 2 , 3]
```

1. 콜론(`:`) 앞이 아닌 뒤.
- 수퍼 클래스 및 프로토콜 채택 목록 및 제네릭 제약 조건.

```swift
✅ Preferred
struct HashTable: Collection {
  // ...
}

struct AnyEquatable<Wrapped: Equatable>: Equatable {
  // ...
}

⛔️ Not Preferred
struct HashTable : Collection {
  // ...
}

struct AnyEquatable<Wrapped : Equatable> : Equatable {
  // ...
}
```

- 함수 인수 레이블 및 튜플 요소 레이블.

```swift
✅ Preferred
let tuple: (x: Int, y: Int)

func sum(_ numbers: [Int]) {
  // ...
}

⛔️ Not Preferred
let tuple: (x:Int, y:Int)
let tuple: (x : Int, y : Int)

func sum(_ numbers:[Int]) {
  // ...
}

func sum(_ numbers : [Int]) {
  // ...
}
```

- 명시적 타입이 있는 변수 및 속성 선언.

```swift
✅ Preferred
let number: Int = 5

⛔️ Not Preferred
let number:Int = 5
let number : Int = 5
```

- 약식 `Dictionary` 타입 이름.

```swift
✅ Preferred
var nameAgeMap: [String: Int] = []

⛔️ Not Preferred
var nameAgeMap: [String:Int] = []
var nameAgeMap: [String : Int] = []
```

- Dictionary literals.

```swift
✅ Preferred
let nameAgeMap = ["Ed": 40, "Timmy": 9]

⛔️ Not Preferred
let nameAgeMap = ["Ed":40, "Timmy":9]
let nameAgeMap = ["Ed" : 40, "Timmy" : 9]
```

1. 줄 끝에 주석을 시작하는 이중 슬래시(`//`) 앞에 최소 두 개의 공백과 뒤에 정확히 한 개의 공백이 있어야 합니다.
```swift
✅ Preferred
let initialFactor = 2  // Warm up the modulator.
⛔️ Not Preferred
let initialFactor = 2 //    Warm up the modulator.
```

1. `array` 또는 `dictionary` 리터럴의 괄호와 튜플 리터럴의 괄호 내부가 아니라 외부.
```swift
✅ Preferred
let numbers = [1, 2, 3]
⛔️ Not Preferred
let numbers = [ 1, 2, 3 ]
```

## Horizontal Alignment
**용어 참고:** 수평 정렬은 특정 토큰이 이전 줄의 다른 특정 토큰 바로 아래에 나타나도록 하기 위해 코드에 추가 공백을 추가하는 방법입니다.

**표 형식 처럼 표현되는 수평 정렬은 금지합니다.** (만약 표 형식을 유지하면서 수평 정렬을 해제하면 가독성이 좋지 않습니다.)
또한 다른 경우로(예: `struct` 또는 `class`의 저장 속성 선언의 타입 정렬), 표 형식의 수평 정렬로 새 구성원을 추가하여 다른 구성원을 모두 재 정렬 해야 하는 유지 관리 문제를 유발할 수 있습니다.
```swift
✅ Preferred
struct DataPoint {
  var value: Int
  var primaryColor: UIColor
}

⛔️ Not Preferred
struct DataPoint {
  var value:        Int
  var primaryColor: UIColor
}
```

## Vertical Whitespace
다음 위치에서 공백 행(빈 줄)을 한번만 사용합니다.
1. **아래 예외**를 제외하고 properties, initializers, methods, enum cases 및 nested 타입의 연속적인 멤버들 사이에 공백 행(빈 줄)을 사용합니다.
    - 두 개의 연속되는 저장 속성 이나 선언이 한 줄에 완전히 맞는 두 개의 열거형 케이스 사이에 공백 행은 선택 사항입니다. 이러한 공백 행은 이러한 선언의 논리적 그룹을 만드는데 사용할 수 있습니다.
    - 위의 기준을 충족하지 않는 매우 밀접하게 관련된 두 속성 사이에 공백 행은 선택 사항입니다. 예를 들어 개인 저장 속성 및 관련 공용 계산 속성이 있습니다.
2. 코드를 논리적 하위 섹션으로 구성하기 위해 명령문 사이에 필요할 때 사용합니다.
3. 선택적으로 타입의 첫 번째 구성원 앞이나 마지막 구성원 뒤에 사용합니다. (권장되거나 권장되지 않음).
4. 이 문서의 다른 섹션에서 명시적으로 요구하는 모든 위치에 사용합니다.

여러 줄의 공백이 허용되지만, 필수는 아닙니다(권장 하지는 않음). 만약 여러 개의 연속적인 빈 줄을 사용하는 경우, 코드 기반 전체에서 일관되게 사용해야 합니다.

## Parentheses
`if`, `guard`, `while` 또는 `switch` 키워드 뒤에 오는 최상위 표현식 주위에는 괄호가 사용 되지 않습니다.
```swift
✅ Preferred
if x == 0 {
  print("x is zero")
}

if (x == 0 || y == 1) && z == 2 {
  print("...")
}

⛔️ Not Preferred
if (x == 0) {
  print("x is zero")
}

if ((x == 0 || y == 1) && z == 2) {
  print("...")
}
```

위와 같이 선택적인 그룹화를 제공하는 괄호는 작성자와 검토자가 괄호가 없으면 해당 코드가 잘못 해석될수 있는 **합리적인** 이유가 없거나, 코드의 가독성을 높일수 있다고 동의하는 경우에만 생략하는 것이 가능합니다.
모든 독자가 `Swift`의 모든 연산자 우선 순위 테이블을 기억하고 있다고 가정하는 것은 합리적 이지 않습니다.
