# MD(markdown) 파일이란 ?
[markdown 공식 사이트](https://whatismarkdown.com/)<br>
마크다운(markdown)은 텍스트 기반 마크업 언어입니다. 쉽게 쓰고 읽을 수 있으며 HTML로의 변환이 가능합니다.<br>
특수 기호와 문자들을 이용한 간단한 구조의 문법을 사용해 보다 빠른 컨텐츠를 작성할 수 있습니다.<br>
GitHub 에서는 Repository를 처음 들어갔을 때 밑에 나오는 내용인데, readme.md 파일이 표현되는 것 입니다.

## 장점과 단점
장점
1. 간결하다.
2. 별도의 도구 없이 작성 가능하다.
    - vi editor로도 가능하며 주로 Visual Studio Code를 사용한다.
3. 다양한 형태로 변환 가능하다.
4. 텍스트로 저장되기 때문에 용량이 적어 보관이 용이하다.
5. 텍스트 파일이기 때문에 버전관리 시스템을 활용하여 변경 이력이 남는다.
6. 지원하는 프로그램 및 플랫폼이 다양하다.

단점
1. 표준이 없다.
2. 사이트 및 도구에 따라 표현되는 내용이 매우 다르다.
3. 모든 HTML 마크업에 대응하지는 못한다.

## 사용 방법
헤더 : `#`를 사용한다.
# H1
## H2
### H3
#### H4
##### H5
###### H6
```
#, ##, ###, ..., ###### 까지 사용 가능하다.
각 크기가 다르며, 글머리라고 생각하면 된다.
```
BlockQuote : 이메일에서 사용하는 블럭인용문자 `>`를 사용한다.<br>
내부에 마크다운 요소 포함 가능하다.
> BlockQuote Test
>   > BlockQuote Test
>   >   > BlockQuote Test
```
> BlockQuote Test
>   > BlockQuote Test
>   >   > BlockQuote Test
```
목록 (순서가 있을 경우)
1. 첫번째
2. 두번째
3. 세번째
```
1. 첫번째
2. 두번째
3. 세번째
```
목록 (순서가 없을 경우) : 아래 내용 혼합사용 가능
* 1
    * 2
        * 3
+ 1
    + 2
        + 3
- 1
    - 2
        - 3
```
* 1
    * 2
        * 3
+ 1
    + 2
        + 3
- 1
    - 2
        - 3
```
코드 블럭
```swift
import UIKit
// ... 이하 생략
```

```java
public interface UserRepository extends JpaRepository<User, Long> {
    // 이하 생략
}
```

```c
#include <stdio.h>

int main(int argc, char* argv[], char* envp[]) {
    // ....
    return 0;
}
```

```
위처럼 코드를 위한 블럭을 만들 수 있고, ` 3개로 열어 언어를 작성하고, ` 3개로 다시 닫는다.
보이게 끔 만들어 보려 했는데, 안 만들어 진다...
```