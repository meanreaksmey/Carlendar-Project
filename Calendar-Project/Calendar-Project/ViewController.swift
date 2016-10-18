//
//  ViewController.swift
//  Calendar-Project
//
//  Created by reaksmey on 10/17/16.
//  Copyright © 2016 reaksmey. All rights reserved.
//

import UIKit
import FSCalendar
import FontAwesomeKit

var valueToPass:String!

class ViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate{
    
    
    @IBOutlet weak var viewInfo: UIView!
    @IBOutlet weak var btnAdd: UIBarButtonItem!
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    
    @IBAction func btnAdd(_ sender: AnyObject) {
        print("==============")
    }
    var data = [String]()
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    private let gregorian: NSCalendar! = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)
    
    let datesWithCat = ["2015/05/05","2015/06/05","2015/07/05","2015/08/05","2015/09/05","2015/10/05","2015/11/05","2015/12/05","2016/01/06",
                        "2016/02/06","2016/03/06","2016/04/06","2016/05/06","2016/06/06","2016/07/06"]
    
    var someInts:[Int] = [10, 20, 30]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.calendar.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesUpperCase]
        self.calendar.select(self.formatter.date(from: "2015/10/10")!)
        self.calendar.scopeGesture.isEnabled = true
        self.viewInfo.alpha = 0
    }
    func fontAwesomeToImage(_ icon: FAKIcon, size:CGFloat = 15, color:UIColor = UIColor.white)->UIImage{
        let cogIcon = icon
        cogIcon.addAttribute(NSForegroundColorAttributeName, value: color)
        let iconImg = cogIcon.image(with: CGSize(width: size, height: size))
        return iconImg!
    }
    func addSubButton(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: fontAwesomeToImage(FAKFontAwesome.plusIcon(withSize: 20),size: 20), style: .plain, target: self, action: #selector(self.startAction))
    }
    func startAction() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let nvc = UINavigationController(rootViewController: vc)
        nvc.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present (nvc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return self.formatter.date(from: "2015/01/01")!
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return self.formatter.date(from: "2016/10/31")!
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let day: Int! = self.gregorian.component(.day, from: date)
        return day % 5 == 0 ? day/5 : 0;
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        NSLog("change page to \(self.formatter.string(from: calendar.currentPage))")
        
        
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date) {
        //        NSLog("calendar did select date \(self.formatter.string(from: date))")
        
        self.calendar.setScope(.week, animated: true)
        self.viewInfo.alpha = 1
        addSubButton()
        valueToPass = self.formatter.string(from: date)
        table1.tableView.reloadData()
        
        
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        let day: Int! = self.gregorian.component(.day, from: date)
        return someInts.contains(day) ? UIImage(named: "icon_cat") : nil
    }
    
    // delay
    func delay(_ seconds: Int, closure: @escaping ()->()) {
        let time = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: time) {
            closure()
        }
    }
    
}
