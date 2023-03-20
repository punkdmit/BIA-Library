//
//  BookDetailViewController.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 17.03.2023.
//

import UIKit

class BookDetailViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var detailCardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()

        // Do any additional setup after loading the view.
    }
    
    

    private func setView() {
        customBackButton()
        detailCardView.aplyShadow(cornerRadius: 12)
    }
    private func customBackButton() {
        let backBTN = UIBarButtonItem(image: UIImage(named: "backButton"),
                                      style: .plain,
                                      target: navigationController,
                                      action: #selector(UINavigationController.popViewController(animated:)))
        backBTN.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = backBTN
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
