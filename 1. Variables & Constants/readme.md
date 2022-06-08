# 변수와 상수 (Variables & Constants)
`var`, `let`으로 변수와 상수를 구분한다.
선언시 메모리(데이터 + 힙 + 스택 영역)에 생성된다.
➞ 일반적으로 변수라 칭함.

## 변수(Variables) ➞ `var`
변수는 생성하면 재선언 할 수 없으나 재할당은 가능하다.
- 변하는 데이터(자료)를 담을 수 있는 공간

## 상수(Constants) ➞ `let`
상수를 선언할 때 값을 비워둘 수 있으나, 한번 선언하면 다른 값으로 초기화 할 수 없다.
- 변하지 않는 데이터(자료)를 담을 수 있는 공간

## 문자열 보간법(String Interpolation)
Swift에서는 `\(변수명)`으로 출력할 수 있다.
- 각 언어별로 선언 방법이 다르나, 스위프트에서는 위와 같이 해야한다.
- ex) print("제 이름은 \\(name) 입니다.")

## 카멜 케이스와 스네이크 케이스
Swift에서는 주로 카멜 케이스(camelCase)를 사용한다.

## 데이터 타입
⭐️ Int : 정수(Integer)
Float : 실수(Floating-point number) / 부동소숫점(6자리, 4Byte)
⭐️ Double : 실수 / 부동소숫점(15자리, 8Byte)
Character : 문자(글자 한개)
⭐️ String : 문자열
⭐️ Bool : 참과 거짓(Boolean)
기타 : UInt, UInt64, 32, 16, 8 / 0 혹은 양의 정수
- 모든 스위프트 데이터 타입에는 대문자로 시작한다.
- 타입을 확인하고 싶다면 type(of: `변수명`) 으로 사용한다.

## 데이터 타입 문법
⭐️ 타입 주석(Type Annotation)
- 변수를 선언하면서 타입도 명확하게 지정하는 방식
- ex) var name: String = "길동"
⭐️ 타입 추론(Type Inference)
- 타입을 지정하지 않아도 컴파일러가 유추해서 저장하는 방식
- ex) var name = "길동"
- `Option`을 누르고 변수 이름을 클릭하면 컴파일러가 유추한 데이터 타입을 볼 수 있다.
⭐️ 타입 안정성(Type Safety)
- 스위프트는 데이터 타입을 명확하게 구분하여 사용하는 언어다.
- 다른 타입끼리 계산할 수 없다.

## 타입(형) 변환(Type Conversion)
데이터 타입을 변환하여 사용하는 방법이다.
- 기존 메모리에 저장된 값을 다른 형식으로 변경하여 다른 메모리 공간에 새로 저장함.
- ex) var str1 = "123" ➞ var number1 = Int(str1)
타입 변환에 실패했을 경우 `nil`메세지가 나온다.
데이터가 변환되지 않거나, 유실될 수 있으니 주의해야 한다.

## 타입 애일리어스(Type Ailas)
`typealias type name = type expression` 의 형식으로 사용한다.
- ex) typealias Name = String ➞ var name: Name = "길동"
- 위 내용에서 Name 타입이 의미하는 것은 String 이다.
- 타입 애일리어스는 길게 쓸 때 유용하다.
- ex) typealias Something = (Int) -> String
- ex2) func someFunction(completionHandler: (Int) -> String) { } ➞ func someFunction(completionHandler: Something) { }
따라서, 기존에 선언되어 있는 타입과 내가 만든 타입 등에서 새로운 별명, 별칭을 붙여 가독성을 향상시킬 수 있다.

## 경고와 오류
⚠️(노란색) 표시는 코드가 잘못된 것이 아닌, 더 나은 방법을 제안하기 위해 나타난다.
- ex) var로 선언한 것이 바뀌지 않아 let으로 제안하기 위해 등...
⚠️(빨간색) 표시는 코드가 잘못되어 반드시 수정해야 하는 내용을 제시하기 위해 나타난다.
- 컴파일러가 추정하여 왜 오류가 나타나는지 표시된다.

## 용어 정리(스위프트 이외에도 사용되는 프로그래밍 기본 용어)
키워드(Keyword) : 약속어, 프로그래밍 언어에서 의미있는 단어여서 사용하기로 약속한 단어(다른 용도로 사용 불가능)
- ex) var, let, if, true, ..., etc
⭐️ 리터럴(Literals) : 코드에서 고정된 값으로 표현되는 문자(데이터) 그 자체
- ex) var a = 4 // Int(정수) 리터럴
- ex2) var name = "길동" // String(문자열) 리터럴
- ex3) var b = 3.14 // Double(실수) 리터럴
식별자(Identifer) : 변수, 상수, 함수, 사용자 정의 타입의 이름
토큰(Token) : 코드에서 더이상 쪼갤 수 없는 최소의 단위(식별자, 키워드, 구두점, 연산자, 리터럴)
- ex) let, ',', ==, ..., etc
⭐️ 표현식(Expression) : 값, 변수, 연산자의 조합으로 하나의 결과값으로 평가되는 코드 단위
- 즉, 하나의 값이 나오는 코드를 뜻한다.
- ex) var num1 = 5 // 문장, num1이 5라고 인식(할당)
- ex2) n < 5 // false ➞ 표현식
⭐️ 문장(Statement) : 특정 작업을 실행하는 코드 단위
- ex) var num1 = 5 // 문장
- ex2) print(num1) // num1을 출력하라는 문장