//
//  NewsViewController.swift
//  Cabby
//
//  Created by Issarapong Poesua on 4/23/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    var news: [News] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let news1 = News(heading1: "โปรฯ​ พาไปส่งร้านข้าวต้มโต้รุ่งก่อน",
                         heading2: "ส่งถึงบ้าน ใช้โค้ด cabby01 ลดทันที 30%",
                         dateAndTime: "18 Apr 2017 , 11 : 30 AM.")
        let news2 = News(heading1: "โปรฯ สงกรานต์นี้ เมาไม่ขับ",
                         heading2: "ใช้โค้ด cabbySK ลดทันที 15%",
                         dateAndTime: "12 Apr 2017 , 11 : 30 AM.")
        

        news.append(news1)
        news.append(news2)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

 
    
}

extension NewsViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? NewsCollectionViewCell
        
        let eachNews = news[indexPath.item]
        
        cell?.dateAndTime = eachNews.dateAndTime
        cell?.heading1 = eachNews.heading1
        cell?.heading2 = eachNews.heading2
        
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }
}
