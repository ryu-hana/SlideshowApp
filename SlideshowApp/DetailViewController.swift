//
//  DetailViewController.swift
//  SlideshowApp
//
//  Created by SugiuraArisa on 2021/05/16.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var detailView: UIImageView!
    
    var viewItem: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 初期画像表示
        self.detailView.image = UIImage(named: self.viewItem)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
