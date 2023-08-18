//
//  GCDBasicViewController.swift
//  SeSAC3Week5
//
//  Created by jack on 2023/08/14.
//

import UIKit

class GCDBasicViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dispatchGroup()
    }
    
    func dispatchGroup() {
        
        let group = DispatchGroup()
        
        DispatchQueue.global(qos: .background).async(group: group) {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        group.notify(queue: .main) {
            print("END111")
        }
       
        
        DispatchQueue.global().async(group: group) {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        group.notify(queue: .main) {
            print("END122")
        }
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
        

        
//        DispatchQueue.global().async(group: group) {
//            for i in 301...400 {
//                print(i, terminator: " ")
//            }
//        }
        group.notify(queue: .main) {
            print("END")
        }
    }
    
    func globalAsyncTwo() {
        print("Start")
        
        for i in 1...50 {
            
            DispatchQueue.global().async {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        for i in 61...100 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        print("End")
    }
    
    func globalAsync() {
        print("Start")
        
        DispatchQueue.global().async { //네트워크
            for i in 1...100 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        print("End")
    }
    
    func globalSync() {
        print("Start")
        
        DispatchQueue.global().sync {
            for i in 1...100 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        print("End")
    }
    
    func serialAsync() {
        print("Start")
        
        DispatchQueue.main.async {
            for i in 1...100 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        print("End")
    }
    
    
    func serialSync() {
        print("Start")
        
        for i in 1...100 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        //무한 대기 상태, 교착상태(deadlock)
        DispatchQueue.main.sync {
            for i in 101...200 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        print("End")
    }
}
