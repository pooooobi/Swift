# 스위프트에서 날짜와 시간 다루기
- 프레임 워크의 사용과 관련된 내용이다.
- 외우진 않아도 되고, 앱을 만들때 찾아서 사용하자.
1. UTC
    - UTC(Corrdinated Universal Time): 협정 세계시
        - 국제적인 표준 시간의 기준이다. 기존 평균태양시인 그리니치 표준시(GMT)를 대체하여 사용한다.
            - 일반적으로 UTC, GMT 혼용하여 사용함
        - 우리나라의 경우 UTC+9로, 영국보다 9시간이 빠르다는 뜻이다.
2. 스위프트에서 날짜와 시간을 다루는 방법
```swift
// Date 구조체 => 현재 시점에서 Date 인스턴스 생성
// 기준 시간(Reference Date) 2000. 01. 01. 00:00:00.00 + 몇초가 떨어져 있는지? => .timeIntervalSinceReferenceDate

let now = Date() // 생성시점의 날짜와 시간을 생성
print(now) // UTC 기준의 시간 출력

now.timeIntervalSinceReferenceDate // => 2000. 01. 01. 00:00:00으로 부터 흐른 시간 초가 나옴

// 어제를 구하는 방법
let yesterday = now - 86400 // 24시간을 초로 => 86400

now.timeIntervalSince(yesterday) // 어제

// 내일을 구하는 방법
let tomorrow = Date(timeIntervalSinceNow: 86400)

// 시간을 제대로 다루려면 지역, 타임존의 영향이 있음
```
3. Calendar 구조체의 이해
    - 날짜를 제대로 다루려면?
        - 달력을 다루는 Calendar 구조체의 도움(양력, 음력 구분)
        - 문자열로 변형해주는 DateFomatter도 필요
    - 절대 외우는게 아니라, 생각나지 않으면 찾아서 사용하자.
```swift
// 그레고리력(Gregorian Calendar) => 양력
var calendar = Calendar.current

// 지역 설정 => 나라, 지역마다 날짜와 시간을 표시하는 형식과 언어가 다르다.
// locate => 달력의 지역, timeZone => UTC 시간과 관련됨, 우리나라는 Asia/Seoul
calendar.locale
calendar.timeZone

// 지역 설정
calendar.locale = Locale(identifier: "ko_KR")

// 1) 날짜 - 년 / 월 / 일
let year: Int = calendar.component(.year, from: now)
let month: Int = calendar.component(.month, from: now)
let day: Int = calendar.component(.day, from: now)

// 2) 시간 - 시 / 분 / 초
let timeHour: Int = calendar.component(.hour, from: now)
let timeMinute: Int = calendar.component(.minute, from: now)
let timeSecond: Int = calendar.component(.second, from: now)

// 3) 요일
let weekday: Int = calendar.component(.weekday, from: now)
// 일요일이 1로 시작하여 토요일이 7로 끝남
```
4. 실제 사용 방법
```swift
class Dog {
    var name: String
    var yearOfBirth: Int
    
    init(name: String, year: Int) {
        self.name = name
        self.yearOfBirth = year
    }
    
    // 나이를 계산하는 계산 속성
    var age: Int {
        get {
            let now = Date()
            let year = Calendar.current.component(.year, from: now)
            return year - yearOfBirth
        }
    }
}

let choco = Dog(name: "초코", year: 2015)
choco.age
```
5. DateFormatter의 이해
    - 날짜와 시간을 원하는 형식의 문자열(String)로 변환하는 방법을 제공하는 클래스
    - RFC 3339 표준으로 작성됨
```swift
let formatter = DateFormatter()

// 1) 지역 설정
// 나라, 지역마다 날짜와 시간을 표시하는 형식과 언어가 다름.
formatter.locale = Locale(identifier: "en_US")

// 2) 시간대 설정
formatter.timeZone = TimeZone.current

// 3) 표시하려는 날짜와 시간 설정

/*
formatter.dateStyle = .full => "Tuesday, April 13, 2021"
formatter.dateStyle = .long => "April 13, 2021"
formatter.dateStyle = .medium => "Apr 13, 2021"
formatter.dateStyle = .none => 날짜 없어짐
formatter.dateStyle = .short => "4/13/21"
*/

// 4) 시간 형식 설정

/*
formatter.timeStyle = .full => "2:53:13 PM Korean Standard Time"
formatter.timeStyle = .long => "2:53:12 PM GMT+9"
formatter.timeStyle = .medium => "2:53:12 PM"
formatter.timeStyle = .none => 시간 없어짐
formatter.timeStyle = .short => "2:53 PM"
*/

// 5) 사용 방식
let someString1 = formatter.string(from: Date())
print(someString1)

// 참고) 커스텀 형식

// formatter.locale = Locale(identifier: "ko_KR")
// formatter.dateFormat = "yyyy/MM/dd"
formatter.dateFormat = "yyyy년 MMMM d일 (E)"

let someString2 = formatter.string(from: Date())
print(someString2) // 2022년 August 10일 (Wed)
```
- 날짜, 시간 형식 : http://www.unicode.org/reports/tr35/tr35-25.html#Date_Format_Patterns 
- 활용 예시
```swift
struct InstagramPost {
    let title: String = "제목"
    let description: String = "내용설명"
    
    private let date: Date = Date()  // 게시물 생성을 현재날짜로
    
    // 날짜를 문자열 형태로 바꿔서 리턴하는 계산 속성
    var dateString: String {
        get {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ko_KR")
            //formatter.locale = Locale(identifier: Locale.autoupdatingCurrent.identifier)
            
            // 애플이 만들어 놓은
            formatter.dateStyle = .medium
            formatter.timeStyle = .full
            
            // 개발자가 직접 설정한
            //formatter.dateFormat = "yyyy/MM/dd"
            
            return formatter.string(from: date)
        }
    }
}

let post1 = InstagramPost()
print(post1.dateString)
```