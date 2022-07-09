//
//  ViewController.swift
//  diceGame
//
//  Created by 최영현 on 2022/07/09.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    
    var diceArray: [UIImage] = [#imageLiteral(resourceName: "black1"), #imageLiteral(resourceName: "black2"), #imageLiteral(resourceName: "black3"), #imageLiteral(resourceName: "black4"), #imageLiteral(resourceName: "black5"), #imageLiteral(resourceName: "black6")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    
    @IBAction func rollButtonTapped(_ sender: UIButton) {
        
        // 왼쪽 이미지 뷰 랜덤으로 변경
        leftImageView.image = diceArray.randomElement()
        
        // 오른쪽 이미지 뷰 랜덤으로 변경
        rightImageView.image = diceArray.randomElement()
    }
    
}

