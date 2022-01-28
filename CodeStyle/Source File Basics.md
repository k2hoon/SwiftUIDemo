# Source File Basics

## File Names
모든 Swift 소스 파일은 .swift 확장자로 끝납니다.

소스 파일의 이름은 소스 파일이 가지고 있는 엔티티를 나타내야 합니다.
- 단일 타입을 포함하는 파일은 해당 타입의 이름으로 파일 이름을 정합니다.  
- 프로토콜과 함께 확장하는 파일은 더하기(+) 기호로 타입 이름과 프로토콜 이름의 조합으로 이름을 정합니다.
- 만약 예외 사항이 있다면 적절한 파일 이름을 정합니다.

예를 들어,
- 단일 타입 SomeType을 포함하는 파일의 이름은 SomeType.swift가 됩니다.
- SomeProtocol 프로토콜을 준수하면서 SomeType을 extension하는 파일의 이름은 SomeType+SomeProtocol.swift가 됩니다.
- 중첩 타입 또는 기타 기능을 추가하는 여러 확장성을 포함하는 파일은 예를 들어, SomeType+Additions.swift 처럼, SomeType+가 접두사로 붙으면서 적절한 이름으로 지정할 수 있습니다.
- 만약 공통적인 타입이나 namespace로 범위를 지정하기 어렵다면 파일이 가지고 있는 특징 그대로 이름을 지정할 수 있습니다.

## File Encoding
소스 파일은 UTF-8로 인코딩됩니다.
