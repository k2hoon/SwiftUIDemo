# Source File Structure

## File Comments
소스 파일의 내용을 설명하는 주석은 선택 사항으로 단일 추상화(예: 클래스 선언)만 포함하는 파일에는 권장하지 않습니다. 
만약 추가 유용한 정보를 제공하는 경우에만 표시됩니다.

## Import Statements
소스 파일은 필요한 최상위 모듈을 정확히 가져와야 합니다.
만약 소스 파일이 `UIKit`과 `Foundation` 정의를 모두 사용하는 경우, 둘 다 명시적으로 가져오면 됩니다.

개별 선언이나 하위 모듈을 가져오는 것보다 전체 모듈을 `import` 하는 것이 좋습니다.
개별 구성원을 `import` 하지 않는 데에는 여러 가지 이유가 있습니다.
- `import`를 해결/구성하는 자동화된 도구가 없습니다.
- 기존의 자동화된 도구(예: `Xcode`의 마이그레이션 도구)는 개별 멤버를 `import` 하는 코드에서 잘 작동하지 않을 것입니다.
- (공식 예제 및 커뮤니티 코드를 기반으로 한) `Swift`의 일반적인 스타일은 전체 모듈을 `import` 하는 것입니다.

개별 선언의 `import`는 전체 모듈을 가져오면, 최상위 정의(예: C 인터페이스)로 전역 네임스페이스를 오염시킬때 허용됩니다. 
이러한 상황에서는 최선의 판단을 내리면 됩니다.

하위 모듈이 최상위 모듈을 가져올 때, 사용할 수 없는 기능을 내보내는 경우 하위 모듈 가져오기가 허용됩니다. 
예를 들어, `UIKit.UIGestureRecognizerSubclass`는 클라이언트 코드가 `UIGestureRecognizer`를 서브클래스로 만들 수 있도록 하는 메서드를 명시적으로 가져와야 합니다. 이러한 메서드는 `UIKit`만 가져와서 볼 수 없습니다.

`Import` 문은 소스 파일에서 주석 보다 먼저 나오는 토큰입니다. 
다음과 같은 방식으로 그룹화 되며, 각 그룹의 `import`는 사전순으로 정렬되고, 각 그룹 사이에는 정확히 한 줄의 빈 줄이 있습니다.
1. 테스트 중이 아닌 모듈/하위 모듈 `import`
2. 개별 선언 `import`(`class`, `enum`, `func`, `struct`, `var`)
3. `@testable`와 함께 `import`된 모듈(테스트 소스에만 있음)

```swift
✅ Preferred
import CoreLocation
import MyThirdPartyModule
import SpriteKit
import UIKit

import func Darwin.C.isatty

@testable import MyModuleUnderTest
```

## Type, Variable, and Function Declarations
일반적으로 대부분의 소스 파일에는 타입 선언이 큰 경우, 하나의 최상위 타입만 포함됩니다. 
단일 파일에 여러 관련 타입을 포함하는 것이 타당한 경우 예외가 허용됩니다. 예를 들어,
- 클래스와 해당 델리게이트 프로토콜은 동일한 파일에 정의될 수 있습니다.
- 타입과 작은 관련 헬퍼 타입은 동일한 파일에 정의될 수 있습니다. `fileprivate`를 사용하여 타입 및 해당 헬퍼의 특정 기능을 해당 파일에만 제한하고 나머지 모듈에서 사용할 수 없도록 제한할 때 유용할 수 있습니다.

소스 파일에서 타입, 변수 그리고 함수의 순서와 이러한 타입의 멤버 순서는 가독성에 큰 영향을 줄 수 있습니다. 
하지만 이와 같이 수행하는 방법에 대한 올바른 단일 레시피는 없습니다. 다른 파일과 다른 타입은 내용을 다른 방식으로 정렬할 수 있습니다.

중요한 것은 각 파일과 타입이 일부 논리적 순서를 사용한다는 것입니다. 
예를 들어, 새로운 메서드는 타입의 끝에 습관적으로 추가되지 않습니다. 논리적인 순서가 아닌 "추가된 날짜순" 순서를 생성하기 때문입니다.

구성원의 논리적 순서를 결정할 때, 독자와 미래의 작가(자신 포함)가 `// MARK:` 주석을 사용하여 해당 그룹에 대한 설명을 제공하는 것이 도움이 될 수 있습니다. 
이러한 주석은 `Xcode`에서도 해석 되며, 소스 윈도우의 네비게이션 바에서 책갈피를 제공합니다. 
(마찬가지로 `// MARK: -` 설명 앞에 하이픈을 추가하면 `Xcode`가 메뉴 항목 앞에 구분선을 삽입합니다.) 예를 들어,
```swift
✅ Preferred
class MovieRatingViewController: UITableViewController {

  // MARK: - View controller lifecycle methods

  override func viewDidLoad() {
    // ...
  }

  override func viewWillAppear(_ animated: Bool) {
    // ...
  }

  // MARK: - Movie rating manipulation methods

  @objc private func ratingStarWasTapped(_ sender: UIButton?) {
    // ...
  }

  @objc private func criticReviewWasTapped(_ sender: UIButton?) {
    // ...
  }
}
```

## Overloaded Declarations
타입에 여러 이니셜라이저 또는 서브 스크립트가 있거나 파일/타입에 동일한 기본 이름을 가진 여러 함수가 있고(아마도 인수 레이블이 다를 수 있음) 
이러한 오버로드가 동일한 타입 또는 확장 범위에 나타날 때, 중간에 다른 코드 없이 순차적으로 나타납니다.

## Extensions
`Extension`을 사용하여 여러 "`단위`"에 걸쳐 타입의 기능을 구성할 수 있습니다. 
회원 순서 처럼, 선택하는 조직 구조/그룹화는 가독성에 큰 영향을 미칠 수 있습니다. 요청이 있을 경우, 검토자에게 설명할 수 있는 논리적 조직 구조를 사용해야 합니다.
