import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var mainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func buttonPressed(_ sender: UIButton) {
        mainLabel.text = "안녕하세요"
    }
    

}

 
