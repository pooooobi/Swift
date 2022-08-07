# 비동기 프로그래밍
- 해당 문서에서는 동시성(Concurrency), 동기(sync), 비동기(async) 처리를 다룬다.

1. 비동기 처리가 왜 필요할까?
    - 실제 어플리케이션 내에서 비동기처리 하지 않을 경우 뚝뚝 끊기는 현상도 발생하고 있다.
    - 아이폰의 화면 주사율은 (현재) 60Hz다. 1초에 60번 화면이 다시 생성된다고 보면 된다.
    - 따라서 비동기 처리를 하지 않으면 이런 메커니즘이 제대로 동작하지 않아 화면이 버벅거리게 된다.
    - 결론적으로, 비동기 처리가 필요하고, iOS에서는 대기열을 통한 쓰레드 자동배치로 편리하게 이용할 수 있다.
        - DispatchQueue(GCD: Grand Central DispatchQueue), OpreationQueue 존재
            - 직접적으로 쓰레드를 관리하는 개념이 아닌, 대기열(Queue)의 개념을 이용하여 작업을 분산처리하고 OS에서 쓰레드를 관리
            - 쓰레드 객체를 직접 생성시키거나 하지 않는 위치에서, 쓰레드보다 더 높은 레벨/차원에서 작업을 처리함
            - 메인 쓰레드(1)가 아닌 다른 쓰레드에서 오래 걸리는 작업들과 같은 작업들이 쉽게 비동기적으로 동작함
2. Synchronous(동기), Asynchronous(비동기) 뭐가 다를까 ?
    - 비동기 처리(async)는 작업을 다른 쓰레드로 보내자마자 즉시 리턴된다.
        - 따라서, 다른 일을 바로 처리할 수 있다.
        - 일을 시작시키고 작업이 끝날 때 까지 기다리지 않는 개념
    - 동기처리(sync)는 작업을 다른 쓰레드로 보내고, 그 작업이 끝나 리턴될때 까지 대기상태가 된다.
        - 따라서, 다른 일을 처리할 수 없고 작업이 끝날때까지 "기다린다".
    - 다른 언어에서 사용하는 Blocking, Non-Blocking 개념도 살펴보면 좋다.
        - Non-Blocking(제어권 바로 반환)에서는 동기의 개념이 지속적 완료여부를 회신한다.
3. Serial(직렬), Concurrent(동시)는 뭐가 다를까 ?
    - Serial Queue는 작업이 배치가 되면 하나의 쓰레드로만 배치한다.
        - 다른 한개의 쓰레드에서만 처리하는 큐
    - Concurrent Queue는 작업이 배치가 되면 여러 쓰레드로 배치한다.
        - 다른 여러개의 쓰레드에서 처리하는 큐
    - 분산처리를 하려면 Concurrent Queue가 좋아보이는데 Serial Queue는 언제 사용하나요 ?
        - Serial Queue는 순서가 중요한 작업에서 사용하고, Concurrent Queue는 독립적이지만 유사한 여러개의 작업을 처리할 때 사용한다.
4. `DispatchQueue` 사용 예시

- Concurrent Queue(동시)
```swift
// 정의
let concurrentQueue = DispatchQueue.global()


DispatchQueue.global().async {
    // default global queue 생성
    // 다른 쓰레드로 보낼 작업을 배치한다
}

concurrentQueue.async {

}

// 비동기적인 함수를 만들수도 있다.
func exampleDispatchQueue {
    DispatchQueue.global().async {
        // 세부 코드
    }
}
```
 - Serial Queue(직렬)
    - 해당 코드는 비동기적으로 보내더라도 순서대로 출력된다.
```swift
let serialQueue = DispatchQueue(label: "serial") // 라벨은 어플리케이션 네임(com.example...)

serialQueue.async {
    // 세부 코드
}
```