import UIKit

class ViewController: UIViewController {

    let emailTextFieldView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        emailTextFieldView.backgroundColor = UIColor.darkGray
        
        // 뷰의 모서리를 둥굴게 만드는 코드
        emailTextFieldView.layer.cornerRadius = 8
        emailTextFieldView.layer.masksToBounds = true
        
        // 기본 view 위에 생성한 view를 올림
        view.addSubview(emailTextFieldView)
        
        // 자동설정 끄기
        emailTextFieldView.translatesAutoresizingMaskIntoConstraints = false // 중요 !
        
        // equalTo => 어디에 맞출 것인가?, constant => 얼마 만큼 띄울것인지?
        // .isActive = true => 기본적으로 설정해줘야 하는 것
        
        // AutoLayout, Left
        emailTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        
        // AutoLayout, Right
        emailTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        
        // AutoLayout, Top/Height
        emailTextFieldView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        emailTextFieldView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }

}
