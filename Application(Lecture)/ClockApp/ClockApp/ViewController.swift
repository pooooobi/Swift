import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    weak var timer: Timer?
    var number: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        mainLabel.text = "초를 선택하세요"
        slider.setValue(0.5, animated: false)
        number = 0
        timer?.invalidate() // 혹은 timer?를 nil로
    }

    @IBAction func sliderChanged(_ sender: UISlider) {
        let seconds = Int(slider.value * 60)
        mainLabel.text =  "\(seconds) 초"
        number = seconds
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] _ in
            if number > 0 {
                number -= 1
                slider.value = Float(number) / Float(60)
                mainLabel.text = "\(number) 초"
            } else {
                number = 0
                mainLabel.text = "초를 선택하세요"
                timer?.invalidate()
                AudioServicesPlayAlertSound(SystemSoundID(1322))
            }
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        configureUI()
    }
    
    
}

