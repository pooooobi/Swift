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
