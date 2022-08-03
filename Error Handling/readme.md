# 에러처리(Error Handling)
- 에러는 두가지로 나뉜다.
    - 컴파일 타임 에러 => 스위프트 문법과 관련된 에러
    - 런타임 에러 => 프로그램이 실행되는 동안 발생하는 에러
        - 앱이 강제로 종료됨(크래시 발생)
- 에러 처리가 왜 필요할까?
    - 앱이 실행하는 중간에 꺼지는것을 방지
    - 어떤 상황이 발생할지 모르기에(네트워크 통신 중 데이터를 못받거나..) 처리해야 함
    - 예외적인 상황이 발생할 수 있는 가능성을 미리 처리하면 앱이 꺼지는 것을 방지할 수 있음
    - 에러는 일반적으로 함수의 처리과정에서 일어난다.
```swift
// 오류 정의
enum HeightError: Error {
    case maxHeight
    case minHeight
}

// 오류 발생할 수 있는 함수 정의
func checkHeight(height: Int) throws -> Bool {
    if height > 190 {
        throw HeightError.maxHeight
    } else if height < 130 {
        throw HeightError.minHeight
    } else {
        if height >= 160 {
            return true
        } else {
            return false
        }
    }
}

// 오류 처리 + 함수 실행
do {
    let isChecked = try checkHeight(height: 200)
    print("놀이기구를 탑승할 수 있는 키임 : \(isChecked)")
} catch {
    print("놀이기구를 탑승할 수 없음")
}
```
- do => 함수를 통한 정상 처리의 경우 실행하는 블럭
- catch => 함수에서 오류가 발생할 경우 처리하는 블럭