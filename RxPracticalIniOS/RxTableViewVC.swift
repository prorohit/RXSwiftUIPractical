//
//  RxTableViewVC.swift
//  RxPracticalIniOS
//
//  Created by Rohit Singh on 2/8/18.
//  Copyright © 2018 Rohit Singh. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

struct Person {
    let name: String
    let age : Int
}

class RxTableViewVC: UIViewController {
    @IBOutlet weak var tableViewOfItems: UITableView!
    
    var arrOfPersons = [Person(name: "Name1", age: 1),
                        Person(name: "Name2", age: 2),
                        Person(name: "Name3", age: 3),
                        Person(name: "Name4", age: 4),
                        Person(name: "Name5", age: 5),
                        Person(name: "Name6", age: 6),
                        Person(name: "Name7", age: 7),
                        Person(name: "Name8", age: 8)
                    ]
    
    var arrOfVariableTypePersons = Variable<[Person]>([])
    
    var arrObservable: Observable<[Person]> {
        return arrOfVariableTypePersons.asObservable()
    }
        

    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrOfVariableTypePersons = Variable<[Person]>(arrOfPersons)
        
        // UITableView TableView Cell For row at indexpath and number of rows by default
        arrObservable.bind(to: self.tableViewOfItems.rx.items(cellIdentifier: "cell")) {
            _, person, cell  in

            if let unWrapCell = cell as? TableViewCell {
                unWrapCell.nameLabel.text = person.name
                unWrapCell.ageLabel.text = "\(person.age)"
            }
            
        }.disposed(by: bag)
        
        self.arrObservable.subscribe {[unowned self] (arr) in
            self.tableViewOfItems.reloadData()
        }.disposed(by: bag)
        

       
        tableViewOfItems.rx.modelSelected(Person.self).subscribe(onNext: { [unowned self](personModel) in
            self.arrOfPersons.append(Person(name: "Name9", age: 9))
            self.arrOfVariableTypePersons.value = self.arrOfPersons
        }, onError: { (error: Error?) in
        
        }, onCompleted: {
            
        }).disposed(by: bag)
        
      
        
    }

}
