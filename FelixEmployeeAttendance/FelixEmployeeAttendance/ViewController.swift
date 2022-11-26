//
//  ViewController.swift
//  FelixEmployeeAttendance
//
//  Created by ashutosh deshpande on 18/11/2022.
//

import UIKit

class ViewController: UIViewController {
    var lapCount = 0
    var timer:Timer = Timer()
    @IBOutlet weak var splashImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        splashImageView.image = UIImage(named: "Splash")
        // Do any additional setup after loading the view.
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(nextScreen), userInfo: nil, repeats: true)
    }

    @objc func nextScreen(){
        lapCount = lapCount + 1
        if lapCount > 2{
            let vc = storyboard?.instantiateViewController(withIdentifier: "TabBarController")as! TabBarController
            navigationController?.pushViewController(vc, animated: true)
            timer.invalidate()
        }
            
    }
}

