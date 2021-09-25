//
//  ViewController.swift
//  HorizontalScrollCalender
//
//  Created by HT-Admin on 14/11/19.
//  Copyright © 2019 HT-Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , UIScrollViewDelegate  {
    
    
    @IBOutlet weak var cntView: UIView!
    
    var midCell = 0
    
    var selectedRows:[IndexPath] = [IndexPath(row: 3, section: 0)]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
     var weekArray = [String]()
     var weekArray1 = [String]()
     var datesArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        collectionView.register(UINib(nibName: "DateCell", bundle: nil), forCellWithReuseIdentifier: "DateCell")
        
        let datesBetweenArray = Date.dates(from: arrayOfDates().lastObject as! Date, to: endDates().lastObject as! Date)
               print(datesBetweenArray)
               
               for date in datesBetweenArray
               {
                   let date = date
                   let dateFormatter = DateFormatter()
                   dateFormatter.dateFormat = "dd"
                   let dayInWeek = dateFormatter.string(from: date)
                   weekArray.append(dayInWeek)
                
                let date1 = date
                let dateFormatter1 = DateFormatter()
                dateFormatter1.dateFormat = "EEE"
                let dayInWeek1 = dateFormatter1.string(from: date1)
                weekArray1.append(dayInWeek1)
                
                let dateMain = date
                let dateFormatterMain = DateFormatter()
                dateFormatterMain.dateFormat = "dd-MM-yyyy"
                let dates = dateFormatterMain.string(from: dateMain)
                datesArray.append(dates)
                
               }
               
              print("week  Array :- ",weekArray)
              print("week  Array :- ",datesArray)
        
        let controller = TableViewController.init(nibName: "TableViewController", bundle: nil)
        controller.view.frame = CGRect(x: 0, y:0, width: self.cntView.bounds.size.width, height: self.cntView.bounds.size.height )
        self.cntView.addSubview(controller.view)
        self.addChild(controller)
        
    }
    


    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if let indexPath = collectionView?.indexPathForItem(at: CGPoint(x: collectionView!.center.x + scrollView.contentOffset.x, y: collectionView!.center.y)) {
        selectedRows = [indexPath]
        print(datesArray[indexPath.row])
        
        let userInfo = ["userID" :"1238" ,"date":datesArray[indexPath.row]]
        
        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: userInfo)

        self.collectionView.reloadData()
    }
    }
        
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        selectedRows.removeAll()

       var visibleRect = CGRect()
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        let visiblePoint = CGPoint(x: CGFloat(visibleRect.midX), y: CGFloat(visibleRect.midY))
        let visibleIndexPath: IndexPath? = collectionView.indexPathForItem(at: visiblePoint)
        print("Visible cell's index is : \(visibleIndexPath?.row)!")
        
        let selectedIndexPath = IndexPath(row: visibleIndexPath!.row, section: 0)
        selectedRows = [selectedIndexPath]
        print(datesArray[visibleIndexPath!.row])
       
            self.collectionView.reloadData()
        
    }
    
    
    //this method is for the size of items
         func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
             let width = collectionView.frame.width/7
           let height : CGFloat = 120.0
             return CGSize(width: width, height: height)
         }
         //these methods are to configure the spacing between items

         func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
             return UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
         }

         func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
             return 0
         }

         func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
             return 0
         }
         

      func numberOfSections(in collectionView: UICollectionView) -> Int {
                    return 1
                }

      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                
                  return weekArray.count
                
                }

             
             
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCell", for: indexPath) as! DateCell
                  
                      cell.lblDate.text = weekArray[indexPath.item]
                      cell.lblDay.text = weekArray1[indexPath.item]
        
        
        if (selectedRows.contains(indexPath))
        {
            cell.lblDate.textColor = .white
            cell.indiCatorView.backgroundColor = #colorLiteral(red: 0.9137254902, green: 0.4, blue: 0.2901960784, alpha: 1)
        }
        else
        {
            cell.lblDate.textColor = .black
            cell.indiCatorView.backgroundColor = UIColor.white
           
        }
        
               return cell;
                
           }
       
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let selectedIndexPath = IndexPath(row: indexPath.row, section: 0)
           selectedRows = [selectedIndexPath]
        print(datesArray[indexPath.row])
         self.collectionView.reloadData()
       }
    
   
    
    func endDates() -> NSArray {

      let numberOfDays: Int = 20
      let formatter: DateFormatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
      let startDate = Date()
      let calendar = Calendar.current
      var offset = DateComponents()
      var dates: [Any] = [formatter.string(from: startDate)]

      for i in 1..<numberOfDays {
          offset.day = i
          let nextDay: Date? = calendar.date(byAdding: offset, to: startDate)
         // let nextDayString = formatter.string(from: nextDay!)
        dates.append(nextDay!)
      }
        
            return dates as NSArray
        }

        
        func arrayOfDates() -> NSArray {

            let numberOfDays: Int = 20
            let formatter: DateFormatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let startDate = Date()
            let calendar = Calendar.current
            var offset = DateComponents()
            var dates: [Any] = [formatter.string(from: startDate)]

            for i in 1..<numberOfDays {
                offset.day = -i
                let nextDay: Date? = calendar.date(byAdding: offset, to: startDate)
              //  let nextDayString = formatter.string(from: nextDay!)
                dates.append(nextDay!)
            }
            
            return dates as NSArray
        }
    }


    extension Date {
        static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
            var dates: [Date] = []
            var date = fromDate

            while date <= toDate {
                dates.append(date)
                guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
                date = newDate
            }
            return dates
        }
    }
