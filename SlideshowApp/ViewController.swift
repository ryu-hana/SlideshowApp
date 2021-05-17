//
//  ViewController.swift
//  SlideshowApp
//
//  Created by SugiuraArisa on 2021/05/16.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    // 画像一覧
    var imageList = ["愛知", "岐阜", "三重", "静岡"]
    // 表示中の画像
    var previewImageNo: Int = 0
    
    // タイマー
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 再生ボタンタイトル設定
        self.playBtn.setTitle(PlayBtnTitle.play.rawValue, for: .normal)
        
        // Screen Size の取得
        let screenWidth = self.view.bounds.width
        let screenHeight = self.view.bounds.height
        
        // UIImage インスタンスの生成
        let image = UIImage(named:imageList[self.previewImageNo])!
        
        // 画像の幅・高さの取得
        let width = image.size.width
        let height = image.size.height
        
        // 画像サイズをスクリーン幅に合わせる
        let scale = (screenWidth * 0.5) / width
        let rect:CGRect = CGRect(x:0, y:0, width:width*scale, height:height*scale)
        
        // 初期画像表示
        self.image.image = UIImage(named: imageList[self.previewImageNo])
        
        // ImageView frame をCGRectで作った矩形に合わせる
        self.image.frame = rect;
        
        // 画像の中心をスクリーンの中心位置に設定
        self.image.center = CGPoint(x:screenWidth/2, y:screenHeight/2)
    }
    
    // prepaare は、segue（画面遷移）前処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segueから遷移先のControllerを取得する
        let detailViewController:DetailViewController = segue.destination as! DetailViewController
        // 表示中のアイテム名を遷移先の変数に設定
        detailViewController.viewItem = self.imageList[self.previewImageNo]
    }
    
    @objc func playImage(_ timer: Timer) {
        // 表示画像の更新
        self.updateViewItem(type: MoveType.next)
    }
    
    // 戻るボタン
    @IBAction func backBtn(_ sender: Any) {
        // 表示画像の更新
        self.updateViewItem(type: MoveType.back)
    }
    
    // 再生/停止ボタン
    @IBAction func playBtn(_ sender: Any) {
        if self.timer == nil{
            self.slideshow(play: true)
        }
        else {
            self.slideshow(play: false)
        }
    }
    
    // スライドショー開始・停止
    func slideshow(play:Bool){
        if play == true{ // スライドショー開始
            if self.timer != nil {
                // タイマーが動いている場合は何もしない
                return
            }
            // タイマーを開始
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(playImage(_:)), userInfo: nil, repeats: true)
            
            // 再生ボタンタイトル設定
            self.playBtn.setTitle(PlayBtnTitle.stop.rawValue, for: .normal)
            
            // 進む・戻るボタンを非活性化
            self.backBtn.isEnabled = false
            self.nextBtn.isEnabled = false
        }
        else{ // スライドショー停止
            // タイマーが動いてない場合は何もしない
            if self.timer == nil{
                return
            }
            
            // タイマーをクリア
            self.timer.invalidate()
            self.timer = nil
            
            // 再生ボタンタイトル設定
            self.playBtn.setTitle(PlayBtnTitle.play.rawValue, for: .normal)
            
            // 進む・戻るボタンの活性化
            self.backBtn.isEnabled = true
            self.nextBtn.isEnabled = true
        }
    }
    
    // 進むボタン
    @IBAction func nextBtn(_ sender: Any) {
        // 表示画像の更新
        self.updateViewItem(type: MoveType.next)
    }
    
    // 表示画像の切り替え
    func updateViewItem(type: MoveType){
        // 表示する画像Noを更新
        switch type {
            case MoveType.back:
                if self.previewImageNo == 0{
                    self.previewImageNo = self.imageList.count - 1
                }
                else{
                    self.previewImageNo -= 1;
                }
                break
            case MoveType.next:
                if self.previewImageNo == self.imageList.count - 1{
                    self.previewImageNo = 0
                }
                else{
                    self.previewImageNo += 1;
                }
                break
        }
        // 表示画像の切り替え
        self.image.image = UIImage(named: imageList[self.previewImageNo])
    }
    
    // 戻るボタンでの遷移前処理
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
    
    // 画像クリック時の処理
    @IBAction func itemTap(_ sender: Any) {
        // スライドショー停止
        self.slideshow(play: false)
        
        // DetailViewController へ遷移するために Segue を呼び出す
        performSegue(withIdentifier: "toDetailViewController",sender: nil)
    }
    
}

enum MoveType: Int {
    case back = 1
    case next = 2
}

enum PlayBtnTitle: String{
    case play = "再生"
    case stop = "停止"
}

