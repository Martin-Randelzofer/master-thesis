//
//  ViewController.swift
//  K08ios
//
//  Created by Martin Randelzofer on 21.06.20.
//  Copyright © 2020 Martin Randelzofer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }

    @IBAction func clearResults(_ sender: Any) {
        resultText.text = "";
    }
    
    @IBAction func startk08a(_ sender: Any) {
        for _ in 1...5{
            let start = DispatchTime.now()
            let result = fibonacci(a: 40)
            let end = DispatchTime.now()
            resultText.text?.append("K08a finished \(result), took \((end.uptimeNanoseconds-start.uptimeNanoseconds)/1000000) ms\n")
        }
    }
    
    func fibonacci(a:Int) -> Int{
        if(a == 1 || a == 2){
            return 1;
        }else {
            return fibonacci(a: a - 1) + fibonacci(a: a - 2)
        }
    }
    
    
    @IBAction func startk08b(_ sender: Any) {
        let amountElements = 2000000
        var input: [Int] = []
        for i in stride(from: 0, to: amountElements, by: 2){
            input.append(i)
        }
        for i in stride(from: 1, to: amountElements, by: 2){
            input.append(i)
        }
        for _ in 1...5{
            let start = DispatchTime.now()
            var pq :PriorityQueue<Int> = PriorityQueue<Int>(startingValues: input)
            let end = DispatchTime.now()
            var sorted : [Int] = []
            while !pq.isEmpty{
                sorted.append(pq.pop()!)
            }
            resultText.text?.append("K08b finished, took \((end.uptimeNanoseconds-start.uptimeNanoseconds)/1000000) ms\n")
        }
    }
    
    @IBAction func startk08c1(_ sender: Any) {
        resultText.text?.append("K08c1 started at  \(DispatchTime.now().uptimeNanoseconds/1000000)\n")
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                self.resultText.text?.append("K08c1 finished at "+String(DispatchTime.now().uptimeNanoseconds/1000000)+"\n")
            }
        }

    }
    
    @IBAction func startk08c2(_ sender: Any) {
        resultText.text?.append("K08c2 started at  \(DispatchTime.now().uptimeNanoseconds/1000000)\n")
        for _ in 1...5{
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    self.resultText.text?.append("K08c2 finished at "+String(DispatchTime.now().uptimeNanoseconds/1000000)+"\n")
                }
            }
        }
    }
    @IBAction func startk08c3(_ sender: Any) {
        resultText.text?.append("K08c3 started at  \(DispatchTime.now().uptimeNanoseconds/1000000)\n")
        for _ in 1...15{
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    self.resultText.text?.append("K08c3 finished at "+String(DispatchTime.now().uptimeNanoseconds/1000000)+"\n")
                }
            }
        }
    }
}

