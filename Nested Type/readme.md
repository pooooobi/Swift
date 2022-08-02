# 중첩 타입(Nested Type)
1. 특정 타입 내에서 사용하기 위해 중첩 타입을 사용한다.
2. 타입 간 연관성을 명확히 구분하고, 내부 구조를 디테일하게 설계할 수 있다.
```swift
enum Suit: Character {
    case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
}

enum Rank: Int {
    case two = 2, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king, ace

    struct Values {
        let first: Int, second: Int?
    }

    var values: Values {
        switch self {
        case Rank.ace:
            // 에이스는 1 또는 11
            return Values(first: 1, second: 11)
        case .jack, .queen, .king:
            // 10
            return Values(first: 10, second: nil)
        default:
            // 2~10은 원시값 사용
            return Values(first: self.rawValue, second: nil)
        }
    }
}

let rank: Rank, suit: Suit

var description: String {
    get {
        var output = "\(suit.rawValue) 세트,"
        output += " 숫자 \(rank.values.first)"

        if let second = rank.values.second {
            output += " 또는 \(second)"
        }

        return output
    }
}

// A - 스페이드
let card1 = BlackjackCard(rank: .ace, suit: .spades)
print("1번 카드: \(card1.description)")

// 5 - 다이아몬드
let card2 = BlackjackCard(rank: .five, suit: .diamonds)
print("2번 카드: \(card2.description)")
```

## 중첩 타입을 왜 배울까 ?
1. 중첩타입으로 선언된 API들을 볼 줄 알아야 한다.
    - ex) `DataFormatter.Style.full` => 중간 타입에 대문자가 나오면 중첩 타입임을 인지할 것
2. 실제 앱을 만들때 중첩 선언을 잘 활용해야 한다.
    - 타입 간 관계 명확성을 위해
3. 하나의 타입 내부구조(계층, 관계 등)를 디테일하게 설계할 수 있다.

## 중첩 타입의 사용 예시
실제 앱에서는 swift 파일을 따로 만들어 실수하기 쉬운 문자열 모음을 보관한다.
```swift
struct K {
    static let appName = "MySuperApp"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
```