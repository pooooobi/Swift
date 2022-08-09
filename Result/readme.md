# Result Type
1. Result Type에 대한 이해
    - 에러가 발생하는 경우, 에러를 따로 외부로 던지는 것이 아니라 리턴타입 자체를 Result Type(success, failure)으로 구현하여 함수 실행의 성공과 실패의 정보를 함께 담아 리턴하는 것이 좋다.
    - 실제 Result 타입의 내부
        - enum Result<Success, Failure> where Failure: Error
    - Result Type은 열거형
        - case success
        - case failure
```swift
// Result Type 활용한 에러처리
enum HeightError: Error {
    case maxHeight
    case minHeight
}

func resultTypeCheckHeight(height: Int) -> Result<Bool, HeightError> {
    if height > 190 {
        return Result.failure(HeightError.maxHeight)
    } else if height < 130 {
        return Result.failure(HeightError.minHeight)
    } else {
        if height >= 160 {
            return Result.success(true)
        } else {
            return Result.success(false)
        }
    }
}

let result = resultTypeCheckHeight(height: 200)

switch result {
case .success(let data):
    print("결과값은 \(data) 입니다.")
case .failure(let error):
    print(error)
}

// Result의 get() 메서드는 결과값을 throwing 함수처럼 변환 가능한 메서드(Success 밸류를 리턴)
do {
    let data = try result.get()
    print("결과값은 \(data) 입니다.")
} catch {
    print(error)
}
```
- 성공, 실패의 경우를 깔끔하게 처리가 가능한 타입니다.
- 기존의 에러처리 패턴을 완전히 대체하는 목적보다는, 개발자에게 에러 처리에 대한 다양한 처리 방법을 제공하는 것이다.

2. 네트워킹 코드에서 Result Type
```swift
enum NetworkError: Error {
    case someError
}

// 적용 전 코드
func performRequest(with url: String, completion: @escaping (Data?, NetworkError?) -> Void) {
    
    guard let url = URL(string: url) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        if error != nil {
            print(error!)                 // 에러가 발생했음을 출력
            completion(nil, .someError)   // 에러가 발생했으니, nil 전달
            return
        }
        
        guard let safeData = data else {
            completion(nil, .someError)   // 안전하게 옵셔널 바인딩을 하지 못했으니, 데이터는 nil 전달
            return
        }
    
        completion(safeData, nil)
        
    }.resume()
}

performRequest(with: "주소") { data, error in
    // 데이터를 받아서 처리
    if error != nil {
        print(error!)
    }
    
    // 데이터 처리 관련 코드
}

// 적용 후
func performRequest2(with urlString: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
    guard let url = URL(string: urlString) else { return }

    URLSession.shared.dataTask(with: url) { (data, response, error) in
        if error != nil {
            print(error!)
            completion(.failure(.someError)) // Result.failure(NetworkError.someError) 로도 가능, 축약해서 넣은 것임
            return
        }

        guard let resData = data else {
            completion(.failure(.someError))
            return
        }

        completion(.success(resData))
    }.resume()
}

performRequest2(with: "주소") { result in
    switch result {
    case .failure(let error):
        print(error)
    case .success(let data):
        // 데이터 처리 관련 코드
    }
}
```