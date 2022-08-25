import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var computerImageView: UIImageView!
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var computerChoiceLabel: UILabel!
    @IBOutlet weak var myChoiceLabel: UILabel!
    
    var myChoice: Rps = Rps.rock
    var computerChoice: Rps = Rps(rawValue: Int.random(in: 0...2))!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 초기 앱 실행 이미지 설정 및 레이블 변경
        computerImageView.image = #imageLiteral(resourceName: "ready")
        myImageView.image = UIImage(named: "ready.png")
        
        computerChoiceLabel.text = "준비"
        myChoiceLabel.text = "준비"
    }

    
    @IBAction func rpsButtonTapped(_ sender: UIButton) {
        // 가위, 바위, 보 선택한 것 저장
        guard let title = sender.currentTitle else { return }
        // let title = sender.currentTitle!
        
        
        switch title {
        case "가위":
            myChoice = Rps.scissors
        case "바위":
            myChoice = Rps.rock
        case "보":
            myChoice = Rps.paper
        default:
            break
        }
    }
    
    @IBAction func selectButtonTapped(_ sender: UIButton) {
        // rpsButtonTapped를 토대로 컴퓨터가 선택한 것을 비교하여 결과 내보냄
        switch computerChoice {
        case Rps.rock:
            computerImageView.image = #imageLiteral(resourceName: "rock")
            computerChoiceLabel.text = "바위"
        case Rps.paper:
            computerImageView.image = #imageLiteral(resourceName: "paper")
            computerChoiceLabel.text = "보"
        case Rps.scissors:
            computerImageView.image = #imageLiteral(resourceName: "scissors")
            computerChoiceLabel.text = "가위"
        }
        
        switch myChoice {
        case Rps.rock:
            myImageView.image = #imageLiteral(resourceName: "rock")
            myChoiceLabel.text = "바위"
        case Rps.paper:
            myImageView.image = #imageLiteral(resourceName: "paper")
            myChoiceLabel.text = "보"
        case Rps.scissors:
            myImageView.image = #imageLiteral(resourceName: "scissors")
            myChoiceLabel.text = "가위"
        }
        
        if computerChoice == myChoice {
            mainLabel.text = "비겼습니다"
        } else if computerChoice == .rock && myChoice == .paper {
            mainLabel.text = "이겼습니다"
        } else if computerChoice == .paper && myChoice == .scissors {
            mainLabel.text = "이겼습니다"
        } else if computerChoice == .scissors && myChoice == .rock {
            mainLabel.text = "이겼습니다"
        } else {
            mainLabel.text = "졌습니다"
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        // 초기 준비상태로 돌림, 메인 레이블 포함 !
        
        computerImageView.image = #imageLiteral(resourceName: "ready")
        computerChoiceLabel.text = "준비"
        
        myImageView.image = #imageLiteral(resourceName: "ready")
        myChoiceLabel.text = "준비"
        
        mainLabel.text = "선택하세요"
        
        computerChoice = Rps(rawValue: Int.random(in: 0...2))!
    }
    

}

