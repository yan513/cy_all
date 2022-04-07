//
//  CYHomeViewController.swift
//  cy_swift
//
//  Created by yunan on 2022/4/6.
//

import UIKit

class CYHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let idiom = YLIdiom(name: "一心一意", pinyin: "yi xin yi yi", jbsy: [""], xxsy: nil, chuchu: nil, lijiu: nil, jyc: ["一心一意"], fyc: ["三心二意"])
        YLIdiom.insert(idiom: idiom)
        
        var array: [YLIdiom] = YLIdiom.queryAll()
        debugPrint(array)
        
        guard var idio2 = YLIdiom.query(name: "一心一意") else {
            debugPrint("不存在")
            return
        }
        idio2.jbsy = ["666", "777"]
        YLIdiom.update(idiom: idio2)
        
        array = YLIdiom.queryAll()
        debugPrint(array)
        
        let idiom3 = YLIdiom(name: "三心二意", pinyin: "san xin er yi", jbsy: ["55353"], xxsy: nil, chuchu: nil, lijiu: nil, jyc: ["三心二意"], fyc: ["一心一意", "一心一意"])
        YLIdiom.insert(idiom: idiom3)
        
        array = YLIdiom.queryAll()
        debugPrint(array)
        
        YLIdiom.delete(idiom: idiom)
        array = YLIdiom.queryAll()
        debugPrint(array)
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
