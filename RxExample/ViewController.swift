//
//  ViewController.swift
//  RxExample
//
//  Created by Diego Vela on 2/10/18.
//  Copyright © 2018 Diego Vela. All rights reserved.
//
import RxSwift
import RxCocoa
import RxBlocking
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myButton: UIButton!

    private var disposable: Disposable? = nil

    private static let colors: [UIColor] = [.yellow, .orange, .blue]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func viewWillAppear(_ animated: Bool) {
        disposable = myTextField.rx.text
            .map { $0 ?? "" }
            .map { $0.count }
            .map { $0 % ViewController.colors.count }
            .map { ViewController.colors[$0] }
            .observeOn(MainScheduler.instance)
            .subscribe({ color in self.myButton.backgroundColor = color.element! } )
    }

    override func viewDidDisappear(_ animated: Bool) {
        disposable?.dispose()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

