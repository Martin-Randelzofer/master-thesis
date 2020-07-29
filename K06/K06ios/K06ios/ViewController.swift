//
//  ViewController.swift
//  K06ios
//
//  Created by Martin Randelzofer on 26.06.20.
//  Copyright © 2020 Martin Randelzofer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultText: UILabel!
    
    var doRepeated:Bool = false
    var repeatedCounter = 0

    @IBAction func startDownloadFile1(_ sender: Any) {
        let startTime = DispatchTime.now()
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        session.reset {}
        let url = URL(string: "http://192.168.178.61:8080/file1.data")
        //let url = NSURL(string: urlString as String)
        var request : URLRequest = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let dataTask = session.dataTask(with: url!) { data,response,error in
           guard let httpResponse = response as? HTTPURLResponse
           else {
              print("error: not a valid http response")
              return
           }
           switch (httpResponse.statusCode) {
              case 200:
                let passedTime = (DispatchTime.now().uptimeNanoseconds-startTime.uptimeNanoseconds)/1000000
                DispatchQueue.main.async {
                   self.resultText.text = "Finished Downloading File 1, took \(passedTime) ms"
                }
                 break
              case 400:
                 break
              default:
                 break
           }
        }
        dataTask.resume()
        
    }
    
    @IBAction func startPing(_ sender: Any) {
        
        let startTime = DispatchTime.now()
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        session.reset {}
        let url = URL(string: "http://192.168.178.61:8080/ping.data")
        //let url = NSURL(string: urlString as String)
        var request : URLRequest = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let dataTask = session.dataTask(with: url!) { data,response,error in
           guard let httpResponse = response as? HTTPURLResponse
           else {
              print("error: not a valid http response")
              return
           }
           switch (httpResponse.statusCode) {
              case 200:
                let passedTime = (DispatchTime.now().uptimeNanoseconds-startTime.uptimeNanoseconds)/1000
                DispatchQueue.main.async {
                   self.resultText.text = "Finished Ping, took \(passedTime) Microseconds"
                }
                 break
              case 400:
                 break
              default:
                 break
           }
        }
        dataTask.resume()
        
    }
    @IBAction func startMultipleDownload(_ sender: Any) {
        
        
        let startTime = DispatchTime.now()
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        session.reset {}
        
        for i in 10...110{
            let url = URL(string: "http://192.168.178.61:8080/file\(i).data")
            //let url = NSURL(string: urlString as String)
            var request : URLRequest = URLRequest(url: url!)
            request.httpMethod = "GET"
            
            let dataTask = session.dataTask(with: url!) { data,response,error in
               guard let httpResponse = response as? HTTPURLResponse
               else {
                  print("error: not a valid http response")
                  return
               }
               switch (httpResponse.statusCode) {
                  case 200:
                    if(i == 110){
                        let passedTime = (DispatchTime.now().uptimeNanoseconds-startTime.uptimeNanoseconds)/1000000
                        DispatchQueue.main.async {
                            self.resultText.text = "Finished Downloading File \(i), took \(passedTime) ms"
                        }
                    }
                     break
                  case 400:
                     break
                  default:
                     break
               }
            }
            dataTask.resume()
        }

        
    }
    @IBAction func startRepeatedDownload(_ sender: Any) {
        doRepeated = true
        startRepeatedDownload()
        
    }
    @IBAction func stopRepeatedDownload(_ sender: Any) {
        repeatedCounter = 0
        doRepeated = false
    }
    
    func startRepeatedDownload(){
        if(!doRepeated){
            return
        }
        repeatedCounter+=1
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let url = URL(string: "http://192.168.178.61:8080/file1.data")
        //let url = NSURL(string: urlString as String)
        var request : URLRequest = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let dataTask = session.dataTask(with: url!) { data,response,error in
           guard let httpResponse = response as? HTTPURLResponse
           else {
              print("error: not a valid http response")
              return
           }
           switch (httpResponse.statusCode) {
              case 200:
                self.startRepeatedDownload()
                DispatchQueue.main.async {
                    
                    self.resultText.text = "Finished Downloading File \(self.repeatedCounter) time"
                }
                 break
              case 400:
                 break
              default:
                 break
           }
        }
        dataTask.resume()
    }
}

