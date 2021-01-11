//
//  PageCiewController.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/07.
//

import UIKit

class PageViewController1: UIPageViewController {

    let viewController1 = ViewController1()
    let viewController2 = ViewController2()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidLoad from PageVC")
        
        self.setViewControllers([viewController1], direction: .forward, animated: true, completion: nil)
        self.dataSource = self
        self.delegate = self
        view.backgroundColor = .white
        
    }
   }

extension PageViewController1: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController == viewController1 {
            return nil
        } else if viewController == viewController2 {
            return viewController1
        }
        return nil
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController == viewController1 {
            return viewController2
        } else if viewController == viewController2 {
            return nil
        }
        return nil
    }
}
