//
//  ViewController.swift
//  NextVC
//
//  Created by Allen H on 2021/12/05.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // 1) 코드로 화면 이동 (다음화면이 코드로 작성되어있을때만 가능한 방법)
    @IBAction func codeNextButtonTapped(_ sender: UIButton) {
        let firstVC = FirstViewController()
        
        firstVC.someString = "FirstViewController"
        
        firstVC.modalPresentationStyle = .fullScreen
        present(firstVC, animated: true, completion: nil)
    }
    
    // 2) 코드로 스토리보드 객체를 생성해서, 화면 이동
    @IBAction func storyboardWithCodeButtonTapped(_ sender: UIButton) {
        guard let secondVC = storyboard?.instantiateViewController(withIdentifier: "secondVC") as? SecondViewController else { return }
        
        secondVC.modalPresentationStyle = .fullScreen
        secondVC.someString = "SecondViewController"
        
        present(secondVC, animated: true, completion: nil)
    }
    
    
    
    // 3) 스토리보드에서의 화면 이동(간접 세그웨이)
    @IBAction func storyboardWithSegueButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toThirdVC", sender: self)
    }
    
    // 세그웨이를 통해 데이터를 전달하기 위해서는 prepate 메서드를 재정의 해야함
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toThirdVC" {
            let thirdVC = segue.destination as! ThirdViewController
            
            thirdVC.modalPresentationStyle = .fullScreen
            
            // 데이터 전달
            thirdVC.someString = "ThirdViewController"
        }
        
        if segue.identifier == "toFourthVC" {
            let fourthVC = segue.destination as! FourthViewController
            
            fourthVC.modalPresentationStyle = .fullScreen
            fourthVC.someString = "FourthViewController"
        }
    }
    
    // 직접적으로 버튼을 눌렀을 때 작동하는 세그웨이에서만 가능함
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }
}

