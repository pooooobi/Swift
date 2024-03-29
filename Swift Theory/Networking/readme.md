# 네트워킹(Networking)
- 네트워킹을 통해 iOS에서 적용하는 방법에 대해 서술한다.
    - 추후 HTTP에 대한 내용 정리 예정임
1. iOS에서 네트워킹 하는 방법은 아래와 같다.
    - URL 생성
    - URLSession 생성
    - Session에 작업 부여
    - dataTask를 통한 작업 시작
    - JSON 받아옴
    - JSON 가공 후 필요 데이터만 빼서 사용
```swift
// URL 상수 생성(주소가 변하지 않아 let)
let movieURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?&key=[KEY_VALUE]&targetDt=20220804"

// URL 구조체 생성
let url = URL(string: movieURL)! // URL 구조체의 string은 문자열로 URL 주소를 받겠다는 의미

// URLSession 생성(네트워킹 역할)
let session = URLSession.shared // 혹은 URLSession(configuration: .default)로 주로 생성함

// 세션에 작업 부여(일시정지 상태로)
let task = session.dataTask(with: url) { (data, response, error) in 
    if error != nil {
        print(error!)
        return
    }

    if let resData = data {
        // print(String(decoding: resData, as: UTF8.self))
        dump(parseJSON(resData)!) // JSON 변환 추가
    }
}
// 바로 URLSession.shared.dataTask로 사용하고 끝에 .resume()을 붙여 사용하는 경우도 있다.

// 작업 시작(비동기적으로 동작하기 때문에 시작해야 함)
task.resume()

// app.quicktype.io를 통한 변환(JSON 타입)
struct MovieData: Codable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Codable {
    let rank: String
    let movieNm: String
    let audiCnt: String
    let audiAcc: String
    let openDt: String
}

// 데이터 변환
func parseJSON(_ movieData: Data) -> [DailyBoxOfficeList]? {
    do {
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(MovieData.self, from: movieData)
        return decodedData.boxOfficeResult.dailyBoxOfficeList
    } catch {
        return nil
    }
}
```
- 유용한 사이트(JSON) : https://app.quicktype.io/

- 보기 좋은 코드로 변환
```swift
// 서버에서 주는 데이터
struct MovieData: Codable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Codable {
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

struct DailyBoxOfficeList: Codable {
    let rank: String
    let moveNm: String
    let audiCnt: String
    let audiAcc: String
    let openDt: String
}

// 사용하려는 데이터
struct Movie {
    static var movieId: Int = 0
    let movieName: String
    let rank: Int
    let openDate: String
    let todayAudience: Int
    let totalAudience: Int

    init(movieNm: String, rank: String, openDate: String, audiCnt: String, accAudi: String) {
        self.movieName = movieNm
        self.rank = Int(rank)!
        self.openDate = openDate
        self.todayAudience = Int(audiCnt)!
        self.totalAudience = Int(accAudi)!
        Movie.movieId += 1
    }
}

// 서버 통신
struct MovieDataManager {
    let movieURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key="

    let keyValue = ""

    func fetchMovie(date: String, completion: @escaping ([Movie]?) -> Void) {
        let urlString = "\(movieURL)&key=\(keyValue)&targetDt=\(date)"
        performRequest(with: urlString) { movies in
            completion(movies)
        }
    }

    func performRequest(with urlString: String, completion: @escaping ([Movie]?) -> Void) {
        // URL 생성
        guard let url = URL(string: urlString) else { return }

        // URL Session 생성
        let session = URLSession(configuration: .default) // 혹은 .shared

        // 세션에 작업 무여
        let task = session.dataTask(with: url) { (data, response, error) in 
            if error != nil {
                print(error!)
                completion(nil)
                return
            }

            guard let resData = data else {
                completion(nil)
                return
            }

            if let movies = self.parseJSON(resData) {
                completion(movies)
            } else {
                completion(nil)
            }
        }
        // 작업 실행
        task.resume()
    }

    func parseJSON(_ movieData: Data) -> [Movie]? {
        let decoder = JSONDecoder()

        do {
            let decodedData = try decoder.decode(MovieData.self, from: movieData)
            let dailyLists = decodedData.boxOfficeResult.dailyBoxOfficeList

            let myMovieLists = dailyLists.map {
                Movie(movieNm: $0.movieNm, rank: $0.rank, openData: $0.openDt, audiCnt: $0.audiCnt, accAudi: $0.audiAcc)
            }

            return myMovieLists
        } catch {
            print("파싱 오류")
            return nil
        }
    }
}

// 실제 사용
var downloadedMovies = [Movie]()

let movieManager = MovieDataManager()

movieManager.fatchMovie(date: "20220806") { (movies) in
    if let movies = movies {
        downloadedMovies = movies
        dump(downloadedMovies)
    } else {
        print("데이터가 존재하지 않거나 다운로드에 실패했습니다.")
    }
}
```