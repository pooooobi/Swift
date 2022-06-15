# 기본 연산자(Basic Operators)
a + b 에서, `a`와 `b`는 `피연산자(Operand)`라 하며, `+`는 `연산자(Operator)`라 한다.<br>
* 스위프트에서 쓰이는 연산자 종류가 다양하다.

## 연산자(Operator)
    값을 검사하거나, 바꾸거나, 조합하기 위해 사용하는 `특수한 기호(Symbol)`나 `구절(Phrase)`을 뜻한다.
    1. 할당 연산자(Assignment Operator)
        var num1 = 5
        var num2 = 10
        num1 = num2 (num1에 num2를 대입)
    2. 산술 연산자(Arithmetic Operator)
        + : 더하기
        - : 빼기
        * : 곱하기
        / : 나누기
        % : 나눈 나머지
    3. 복합 할당 연산자(Compound Assignment Operators)
        var value = 0
        value += 10 (value = value + 10) // value => 10
        value -= 10 (value = value - 10) // value => 0
        이외에도 *=, /=, %=가 있다.
    4. 비교 연산자(Comparison Operators)
        == (Equal to operator)
        != (Not equal to operator)
        > (Greater than operator)
        >= (Greater than or equal to operator)
        < (Less than operator)
        <= (Less than or equal to operator)
    5. 논리 연산자(Logical Operators)
        !true, !false (Logical NOT opeator)
        true && true, true && false, ..., etc. (Logical AND operator)
        true || true, true || false, ..., etc. (Logical OR opreator)

