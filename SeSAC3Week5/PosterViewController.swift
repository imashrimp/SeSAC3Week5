//
//  PosterViewController.swift
//  SeSAC3Week5
//
//  Created by 권현석 on 2023/08/16.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class PosterViewController: UIViewController {
    
    var list: [Results] = []
    var secondList: [Results] = []
    var thirdList: [Results] = []
    var fourthList: [Results] = []
    
    @IBOutlet var posterCollectioView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        for item in UIFont.familyNames {
//            print(item)
//
//            for name in UIFont.fontNames(forFamilyName: item) {
//                print("======", name)
//            }
//        }
        
//        LottoManager.shared.callLotto { bonus, number in
//            print("클로저로 꺼내온 값: \(bonus), \(number)")
//        }
        
        configureCollectionView()
        configureCollectionViewLayout()
        
        let id = [673, 674, 675, 676]
        
        let group = DispatchGroup()
        
        for item in id {
            group.enter()
            callRecommendation(id: item) { data in
                //이차원 배열을 사용하지 않는다면 이런 식
                if item == 673 {
                    self.list = data
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.posterCollectioView.reloadData()
        }
        
    }
    
    
    @IBAction func sendNotification(_ sender: UIButton) {
        
        //포그라운드에서 알림이 안 뜨는게 디폴트 => 정책
        
        //1. 컨텐츠 2. 언제 => 알림 보내
//        let contents = UNMutableNotificationContent()
//        contents.title = "다마고치에게 물을 주세요."
//        contents.body = "아직 레벨 3이에요. 물을 주세요!!!"
//        contents.badge = 100
//
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//
//        let request = UNNotificationRequest(identifier: "\(Date())", content: contents, trigger: trigger)
//
//        UNUserNotificationCenter.current().add(request) { error in
//            print(error)
//        }
    }
    
    //enter leave를 사용해 비동기 작업인 api호출응답을 동기작업처럼(?) 작동하도록 함.
    func dispatchGruopEnterLeave() {
        let group = DispatchGroup()
        
        group.enter() // +1
        self.callRecommendation(id: 567646) { movieList in
            self.list = movieList
            print("===1===")
            group.leave() // -1
        }
        
        group.enter()
        self.callRecommendation(id: 479718) { movieList in
            self.secondList = movieList
            print("===2===")
            group.leave()
        }
        
        group.enter()
        self.callRecommendation(id: 12121) { movieList in
            self.thirdList = movieList
            print("===3===")
            group.leave()
        }
        
        group.enter()
        self.callRecommendation(id: 157336) { movieList in
            self.fourthList = movieList
            print("===4===")
            group.leave()
        }
        
        group.notify(queue: .main) {
            print("===END===")
            self.posterCollectioView.reloadData()
        }
    }
    
    ///비동기 작업을 비동기 작업으로 처리할 dispatchGroup에 묶으면 묶인 비동기 작업의 완료시점을 알 수 없어서 nofity가 먼저 처리됨.
    func dispatchGroupNotify() {
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            self.callRecommendation(id: 567646) { movieList in
                self.list = movieList
                print("===1===")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            self.callRecommendation(id: 479718) { movieList in
                self.secondList = movieList
                print("===2===")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            self.callRecommendation(id: 12121) { movieList in
                self.thirdList = movieList
                print("===3===")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            self.callRecommendation(id: 157336) { movieList in
                self.fourthList = movieList
                print("===4===")
            }
        }
        
        group.notify(queue: .main) {
            print("END")
            self.posterCollectioView.reloadData()
        }
    }
    
    func callRecommendation(id: Int, completionHandler: @escaping ([Results]) -> Void) {
        
        let url = "https://api.themoviedb.org/3/movie/\(id)/recommendations"
        
        let header: HTTPHeaders = [ "Authorization":
"Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZDdhZDk0YjEzYTRkMTY2YjQ1NDNmYjkwMWI5OWI3ZiIsInN1YiI6IjY0ZDFjYjdjNmQ0Yzk3MDE0ZjQzODAyMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.xoAgufPURjRvVw8QF-MnUBnhn6Qc9o-9h2S-m7KBKcA"
        ]
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500)
            .responseDecodable(of: Recommendation.self) { resonse in
//                dump(resonse)
                switch resonse.result {
                case .success(let value):

                    completionHandler(value.results)
                    
                case .failure(let error):
                    print(error)
                }
            }
        
        
//            .response { response in
//
//                switch response.result {
//                case .success(let value):
//                    let json = JSON(value)
//                    print("JSON: \(json)")
//                case .failure(let error):
//                    print(error)
//                }
//            }
        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        showAlert(title: "테스트", message: "메세지", buttonTitle: "버튼") {
//
//            //이렇게 해야 잭님이 얘기해준 얼럿마다 버튼을 다르게 설정할 수 있으면서, 얼럿 메서드 하나로 여러가지 상황에 대응 가능함.
//            print("버튼 눌림.")
//        }
//        print("AAA")
//    }
}

extension PosterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return list.count
        } else if section == 1 {
            return secondList.count
        } else if section == 2 {
            return thirdList.count
        } else if section == 3 {
            return fourthList.count
        } else {
            return 9
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for:  indexPath) as? PosterCollectionViewCell else { return PosterCollectionViewCell() }
        
        if indexPath.section == 0 {
            
            let url = "https://www.themoviedb.org/t/p/w1280\(list[indexPath.item].posterPath ?? "")"
            
            cell.posterImageView.kf.setImage(with: URL(string: url))
        } else if indexPath.section == 1 {
            let url = "https://www.themoviedb.org/t/p/w1280\(secondList[indexPath.item].posterPath ?? "")"
            
            cell.posterImageView.kf.setImage(with: URL(string: url))
        } else if indexPath.section == 2 {
            let url = "https://www.themoviedb.org/t/p/w1280\(secondList[indexPath.item].posterPath ?? "")"
            
            cell.posterImageView.kf.setImage(with: URL(string: url))

        } else if indexPath.section == 3{
            let url = "https://www.themoviedb.org/t/p/w1280\(secondList[indexPath.item].posterPath ?? "")"
            
            cell.posterImageView.kf.setImage(with: URL(string: url))
        } else {
            cell.posterImageView.image = UIImage(systemName: "star")
        }
        
        
        cell.posterImageView.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderPosterCollectionReusableView.identifier, for: indexPath) as? HeaderPosterCollectionReusableView else { return UICollectionReusableView() }
            
            view.titleLabel.text = "테스트 섹션"
            view.titleLabel.font = UIFont(name: "GmarketSansTTFLight", size: 13)
            
            return view
            
        } else {
            return UICollectionReusableView()
        }
        
    }
    
}


extension PosterViewController: CollectionViewAttributeProtocol {
    

    func configureCollectionView() {
        //Protocol as Type
        posterCollectioView.delegate = self
        posterCollectioView.dataSource = self
        posterCollectioView.register(UINib(nibName: PosterCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        
        //XIB 등록과 거의 동일함.
        posterCollectioView.register(UINib(nibName: HeaderPosterCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderPosterCollectionReusableView.identifier)
    }
    
    func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing  = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        //MARK: - headerReferenceSize는 스크롤 방향에 따라 정해짐. 수직 방향이면 height만 적용되고 width는 컬렉션 뷰의 넓이랑 똑같아짐
        layout.headerReferenceSize = CGSize(width: 300, height: 50)
        
        posterCollectioView.collectionViewLayout = layout
    }
    
}


//protocol Test { }
//
//
//class A: Test { }
//
//class B: Test { }
//
//class C: A { }
//
//let exmple: Test = B() // => 클래스가 해당 프로토콜을 채택함.
//
//
//let value: A = C()
