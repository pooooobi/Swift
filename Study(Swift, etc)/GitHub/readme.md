## Git과 GitHub의 차이
Git
1. 오픈 소스 버전관리 시스템 (VCS: Version Control System)
2. 로컬에서 버전관리가 가능하다.
3. 소프트웨어 개발 및 소스코드 관리에 사용한다.

GitHub
1. Git Repository(저장소)를 위한 웹 기반 호스팅 서비스
2. 클라우드 서버를 사용하여 버전 관리된 소스코드를 업로드하여 공유한다.
3. 분산 버전제어, 엑세스 제어, 소스코드 관리, 버그 추적, 기능 요청 등 작업관리에 유용하다.
    - Repository 내 Issue, Pull Request 등

결론 : Git과 GitHub는 연관이 있을 뿐, 같은것은 아니다 (!=) !

## Git에 업로드하여 GitHub에 나타내는 방법
1. 원하는 저장소(Repository)를 clone 한다.
```
git clone {GitHub Repository Link}
```
2. git add 명령어를 이용하여 업로드 할 파일을 추가한다.
```
git add . // 전체 파일 추가
git add { file link } // 파일 개별 추가
```
3. git push를 사용해 저장소에 업로드 한다.
```
git push
```

## Git Branch Convention
#### Back-End
> backend/
#### Front-End
> frontend/
#### Application
> ios/ 혹은 android/
#### 기능 개발
> develop/
#### 오류 수정
> fix/

## Git Commit Message Convention
#### Fix
> 올바르지 않은 동작을 고친 경우
#### Add
> 코드나 테스트, 예제, 문서 등의 추가가 있을 때
#### Remove
> 코드의 삭제가 있을 때
#### Refactor
> 전면 수정이 있을 때
#### Simplify
> 복잡한 코드를 단순화 할 때
#### Improve
> 향상이 있을 때(호환성, 테스트 커버리지, 성능, 접근성...)
#### Make
> 기존 동작의 변경을 명시
#### Implement
> 모듈, 클래스 등 구현체를 완성시켰을 때
#### Correct
> 문법의 오류나 타입의 변경, 이름 변경에 사용
#### Ensure
> 무엇인가 확실하게 보장받도록 할 때
#### Prevent
> 특정한 처리를 못하게 막을 때
#### Avoid
> 특정한 상황을 회피할 때
#### Move
> 코드의 이동이 있을 때
#### Rename
> 이름 변경이 있을 때
#### Allow
> 무언가를 허용할 때
#### Verify
> 검증 코드를 넣을 때
#### Set
> 변수 값을 변경하는 등 작은 수정
#### Pass
> 파라미터를 넘기는 처리를 할 때

## 어떻게 활용할까?
지금 일 하고있는 스프링 프레임워크를 기반으로 제작중인 페이지를 토대로 서술하였습니다.
```text
백앤드 : backend/
프론트앤드 : frontend/
어플리케이션 개발 : app/ (React Native 기반이여서 분리하지 않음)

백앤드의 기능 개발 : backend/develop/{Issue + Issue Name}
프론트앤드의 오류 수정 : frontend/fix/{Issue + Issue Name}
... etc

모든 push된 내용들은 별도의 브랜치에 저장 후, 버전관리를 위해 모두 모아
"master"에 Merge 하고, Release Version을 적용한다.
```

## 참고 사이트
[깃 브랜치를 사용하여 현업에서 실제 사용하는 방법](https://hyeon9mak.github.io/git-branch-strategy/)<br>
[깃 커밋 메세지에 대하여](https://blog.ull.im/engineering/2019/03/10/logs-on-git.html)