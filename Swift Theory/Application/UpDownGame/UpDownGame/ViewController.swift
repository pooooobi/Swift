import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    var comNumber = Int.random(in: 1...10)
    var myNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainLabel.text = "선택하세요"
        numberLabel.text = ""
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        // let num = sender.currentTitle!
        guard let numStr = sender.currentTitle else { return }
        numberLabel.text = numStr
        
        // guard let num = Int(numStr) else { return }
        // myNumber = num
    }
 
    
    @IBAction func selectButtonTapped(_ sender: Any) {
        guard let myNumString = numberLabel.text else { return }
        guard let myNumber = Int(myNumString) else { return }
        
        if comNumber > myNumber {
            mainLabel.text = "UP"
        } else if comNumber < myNumber {
            mainLabel.text = "DOWN"
        } else {
            mainLabel.text = "BINGO 😃"
        }
    }
    
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        mainLabel.text = "선택하세요"
        numberLabel.text = ""
        comNumber = Int.random(in: 1...10)
        
    }
    
}

