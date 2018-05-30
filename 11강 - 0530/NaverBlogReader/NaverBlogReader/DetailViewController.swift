//
//  DetailViewController.swift
//  NaverBlogReader
//
//  Created by 스마트금융과29 on 2018. 5. 1..
//  Copyright © 2018년 hwy. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // @IBOutlet weak var detailDescriptionLabel: UILabel!

    //@IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var detailTextView: UITextView!
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            
            self.title = detail.bloggerlink
            //if let label = detailLabel {
                //label.text = detail.timestamp!.description
            
            print(detail.blogdescription!)
            //detailTextView.text = detail.description
            if let showTextView = self.detailTextView{
                showTextView.text = detail.blogdescription // detail.description as? String
                //detailTextView.text = detail.blogdescription
            }
            
    
            //}
        }
    }

    override func viewWillAppear(_ animated: Bool) {
       // detailLabel.text = "test"
        //detailTextView.text = "fffewfwefwefweffwefwefwe"
  
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Event? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

