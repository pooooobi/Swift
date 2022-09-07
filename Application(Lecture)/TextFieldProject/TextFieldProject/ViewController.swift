import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        setup()
    }
    
    func setup() {
        view.backgroundColor = UIColor.gray
        
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.placeholder = "이메일 입력"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.returnKeyType = .next
        
        textField.becomeFirstResponder() // 처음 화면에 들어갔을 때 바로 접근하게끔 설정 => becomeFirstResponder()
    }
    
    // 화면에 터치가 들어오면 동작하는 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // 텍스트 필드의 입력을 시작할 때 호출함
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }

    // 텍스트 필드의 입력이 시작된 시점에 호출됨
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("사용자가 텍스트필드에 입력을 시작했다.")
    }
    
    // 입력 후 텍스트필드의 우측에 X 표시(전체삭제)의 허락 여부를 리턴
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    // 텍스트 필드의 글자 내용이 입력되거나 지워질 때 호출이 됨(허락 여부도 리턴함)
    // 특수문자를 사용하지 않게 한다거나.. 특정 조건을 추가하여 사용하면 됨
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        print(#function)
//        print(string)
//        return true
        if Int(string) != nil {
            return false
        } else {
            // 텍스트 필드에서 10 글자 이상 사용되는걸 막는 코드
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 10
        }
    }
    
    // 텍스트 필드의 엔터키가 눌리면 다음 동작을 허락할것인지
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        
        if textField.text == "" {
            textField.placeholder = "Type Something here!"
            return false
        } else {
            return true
        }
    }
    
    // 텍스트 필드의 입력이 끝날 때 호출, 끝날지 말지를 허락할것인지
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    
    // 텍스트 필드의 입력이 끝났을 때 호출
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(#function)
        print("유저가 텍스트필드에 입력을 종료했다.")
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        textField.resignFirstResponder()
    }
    
}

