//
//  ViewController.swift
//  SeSAC3Week5
//
//  Created by jack on 2023/08/14.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var syncButton: UIButton!
    @IBOutlet var asyncButton: UIButton!
    @IBOutlet var groupButton: UIButton!
    
    @IBOutlet var firstImageView: UIImageView!
    @IBOutlet var secondImageView: UIImageView!
    @IBOutlet var thirdImageView: UIImageView!
    @IBOutlet var fourthImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        syncButton.addTarget(self, action: #selector(syncButtonClicked), for: .touchUpInside)
        asyncButton.addTarget(self, action: #selector(asyncButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func asyncButtonTapped() {

        print("async start")
        
        asyncDownloadImage(imageView: firstImageView, value: "First")
//        asyncDownloadImage(imageView: secondImageView, value: "Second")
//        asyncDownloadImage(imageView: thirdImageView, value: "Third")
//        asyncDownloadImage(imageView: fourthImageView, value: "Fourth")
        
        print("async end")
    }
    
    //일단 다른 알바생에게 작업을 보내고 나머지 실행.
    //작업이 언제 끝나는 지 정확한 시점 알기 어려움.
    //UI는 메인 스레드(닭벼슬)에서 해야함.
    func asyncDownloadImage(imageView: UIImageView, value: String) {
        
        print("===1===\(value)===", Thread.isMainThread)
        
        DispatchQueue.global().async {
            
            let data = try! Data(contentsOf: Nasa.photo)
            print("===2-1===\(value)===", Thread.isMainThread)
            
            //1->4->2->3 순서로 불러와 지는데, 데이터 디코딩 -> 2-1호출 main queue에 task 넣기 -> 2-4 호출 -> 2-2 -> 2-3
            DispatchQueue.main.async {
                print("===2-2===\(value)===", Thread.isMainThread)
                imageView.image = UIImage(data: data)
                print("===2-3===\(value)===", Thread.isMainThread)
            }
            print("===2-4===\(value)===", Thread.isMainThread)
        }
        print("===3===\(value)===", Thread.isMainThread)
    }
    
    
    @objc func syncButtonClicked() {
        
        print("sync start")
        downloadImage(imageView: firstImageView, value: "first")
        downloadImage(imageView: secondImageView, value: "second")
        downloadImage(imageView: thirdImageView, value: "third")
        downloadImage(imageView: fourthImageView, value: "fourth")
        print("sync end") //동기, 순서대로 실행, 끝나는 지점 알 수 있음.
        
    }
    
    func downloadImage(imageView: UIImageView, value: String) {
        
        print("===1===\(value)===")
        let data = try! Data(contentsOf: Nasa.photo)
        imageView.image = UIImage(data: data)
        print("===2===\(value)===")
        
    }
    
}
