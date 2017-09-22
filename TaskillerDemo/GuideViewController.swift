//
//  GuideViewController.swift
//  Taskiller
//
//  Created by kingcyk on 21/09/2017.
//  Copyright © 2017 kingcyk. All rights reserved.
//

import UIKit
import TaskillerKit

class GuideViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    var doneButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        guideViewLayout()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func guideViewLayout() {
        let frame = self.view.bounds
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        scrollView.isPagingEnabled=true
        scrollView.showsHorizontalScrollIndicator=false
        scrollView.showsVerticalScrollIndicator=false
        scrollView.contentSize = CGSize(width: 4 * frame.size.width, height: frame.size.height)
        
        for i in 1...4 {
            let image = UIImage(named: "guide_\(Int(i))")
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: CGFloat((i - 1)) * frame.size.width, y: 0, width: frame.size.width, height: frame.size.height)
            imageView.contentMode = UIViewContentMode.scaleToFill
            scrollView.addSubview(imageView)
        }
        
        pageControl = UIPageControl(frame: CGRect(x: frame.size.width / 2 - 100, y: frame.size.height - 80, width: 200, height: 100))
        doneButton = UIButton(frame: CGRect(x: frame.size.width / 2 + 100, y: frame.size.height - 50, width: 60, height: 35))
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(UIColor(red: 0.94, green: 0.25, blue: 0.294, alpha: 1), for: .normal)
        doneButton.addTarget(self, action: #selector(guideOver), for: .touchUpInside)
        doneButton.alpha = 0
        
        scrollView.bounces=false
        scrollView.delegate=self
        
        self.view.addSubview(scrollView)
        self.view.addSubview(pageControl)
        self.view.addSubview(doneButton)
    }
    
    func guideOver() {
        dismiss(animated: true, completion: nil)
    }

}

extension GuideViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let frame = self.view.bounds
        let offset = scrollView.contentOffset
        
        pageControl.currentPage = Int(offset.x / frame.size.width)
        if pageControl.currentPage == 3 {
            UIView.animate(withDuration: 0.5) {
                self.doneButton.alpha = 1.0
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.doneButton.alpha = 0.0
            }
        }
    }
}
