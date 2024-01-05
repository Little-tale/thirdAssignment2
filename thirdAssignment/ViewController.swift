//
//
//  ViewController.swift
//  thirdAssignment
//
//  Created by Jae hyung Kim on 1/2/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageLabelList: [UILabel]!
    @IBOutlet var imageList: [UIImageView]!
    @IBOutlet var RandomButton: UIButton!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var dateLabel: UILabel!
    
    
    var slimeStateList = ["행복해","사랑해","좋아해","당황해","속상해","우울해","심심해","짜증나","넘슬퍼"]
    var labelDic : [Int:Int] = [:]
    var imgNameList : [String] = []
    let defaltName = "slime"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.isHidden = true
        dateLabel.isHidden = true
        designDatePicker()
        getDate()
        
        for i in imageList {
            i.isUserInteractionEnabled = true
        }
        
        designNavBar()
        for i in imageLabelList {
            designLabel(i)
        }
        designButton()
       
        setLabelDic()
        //setDefaultImgList(imageList)
        inputImages()
        inputLabels()
        
        
    }
    // 버튼 디자인
    func designButton(){
        RandomButton.titleLabel?.text = "랜덤"
        RandomButton.setTitle("Random", for: .normal)
        RandomButton.layer.backgroundColor = UIColor.black.cgColor
        RandomButton.tintColor = .white
    }
    
    
    // 네비바 디자인
    func designNavBar() {
        navigationItem.title = "감정 다이어리"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: nil)
        // 네비게이션 틴트컬러 변경 방법
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down.fill"), style: .plain, target: self, action: #selector(saveAlert))
    }
    
    // 이미지 리스트를 넣어드립니다.
    func inputimgList(){
        for i in 1...imageList.count {
            imgNameList.append(defaltName+String(i))
        }
        print(imgNameList)
    }
    // 이미지를 넣어드립니다.
    func inputImages() {
        inputimgList()
        imageList.reverse()
        for item in imageList {
            item.image = UIImage(named: imgNameList.popLast()!)
        }
    }
    func inputLabels() {
        labelInsertTag(imageLabelList)
        var temp = slimeStateList
        temp.reverse()
        
        var count = 0
        for item in imageLabelList {
            print(item)
            item.text = "\(temp.popLast()!) \(String( UserDefaults.standard.integer(forKey:"\(count)")))"
            print("inputLabels\(item.text!)")
            count += 1
        }
        for i in labelDic {
            labelDic[i.key] = UserDefaults.standard.integer(forKey: "\(i.key)")
//asd
        }
    }
    func setLabelDic(){
        // if UserDefaults.standard.
        for i in 0...slimeStateList.count-1 {
            labelDic[i] = 0
        }
         inputLabels()
        print("\(labelDic) 라벨 딕")
        print("되는가?\(UserDefaults.standard.integer(forKey: "0"))")
    }
    
    
    
    
    func labelInsertTag(_ uilL: [UILabel]){
        var count = 0
        for i in uilL {
            i.tag = count
            count += 1
        }
    }
    func designLabel(_ uil: UILabel) {
        uil.textAlignment = .center
        uil.font = .boldSystemFont(ofSize: 16)
        uil.backgroundColor = .clear
        uil.textColor = .black
        uil.numberOfLines = 1
        
    }
    func upCountLabel(_ uil:UILabel) {
        // inputLabels()
        labelDic[uil.tag]! += 1
        uil.text = "\(slimeStateList[uil.tag]) \(labelDic[uil.tag]!)"
        print("선택된 태그 : \(uil.tag)")
        print("\(uil.text!) Test ")
    }
    
    func designDatePicker() {
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .compact
        // 이 망할놈이 가운데로 만들어준다...!
        datePicker.contentHorizontalAlignment = .center
    }
    func getDate() {
        datePickerAct(datePicker)
    }
    @IBAction func datePickerAct(_ sender: UIDatePicker) {
        // let temp = sender.date.formatted()
        // 날짜 표현 변경
        var temp2 = DateFormatter()
        temp2.dateFormat = "yyyy년 M월 d일"
        // 출력
        print(temp2)
        // print(temp2 as? String ?? "Fail")
        // 주소값 반환 되니 즉 구조체 혹은 스택
        // 접근 하고 꺼내오기
        let result = temp2.string(from: datePicker.date)
        print(result)
        dateLabel.text = result
    }
    func testNoReturn() ->Int {
        return 3
    }
    @objc func saveAlert(){
        let alert = UIAlertController(title: "저장하시겠습니까?", message: nil, preferredStyle: .alert)
        let sucsess = UIAlertAction(title: "확인", style: .default, handler: {action in self.saveLogic()} )
        let unsucsess = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(sucsess)
        alert.addAction(unsucsess)
        present(alert, animated: true)
    }
    
    func saveLogic() {
        for item in labelDic {
            UserDefaults.standard.set(labelDic[item.key], forKey:"\(item.key)")
        }
        print(labelDic)
        print("Test \(UserDefaults.standard.integer(forKey:"0"))")
    }
    
    @IBAction func tap1(_ sender: UITapGestureRecognizer) {
        print("\(sender.view!.tag-1)")
        upCountLabel(imageLabelList[sender.view!.tag-1])
        //imageLabelList.
    }
    @IBAction func tap2(_ sender: UITapGestureRecognizer) {
        upCountLabel(imageLabelList[sender.view!.tag-1])
    }
    
    @IBAction func tap3(_ sender: UITapGestureRecognizer) {
        upCountLabel(imageLabelList[sender.view!.tag-1])
    }
    @IBAction func tap4(_ sender: UITapGestureRecognizer) {
        upCountLabel(imageLabelList[sender.view!.tag-1])
    }
    @IBAction func tap5(_ sender: UITapGestureRecognizer) {
        upCountLabel(imageLabelList[sender.view!.tag-1])
    }
    @IBAction func tap6(_ sender: UITapGestureRecognizer) {
        upCountLabel(imageLabelList[sender.view!.tag-1])
    }
    @IBAction func tap7(_ sender: UITapGestureRecognizer) {
        upCountLabel(imageLabelList[sender.view!.tag-1])
    }
    @IBAction func tap8(_ sender: UITapGestureRecognizer) {
        upCountLabel(imageLabelList[sender.view!.tag-1])
    }
    @IBAction func tap9(_ sender: UITapGestureRecognizer) {
        upCountLabel(imageLabelList[sender.view!.tag-1])
    }
    @IBAction func randomButtonAct(_ sender: UIButton) {
        var tempRandom :[Int] = []
        var tempName :[String] = slimeStateList
        for i in 0...slimeStateList.count-1 {
            print(slimeStateList.count)
            print(i)
            tempRandom.append(Int.random(in: 0...50))
        }
        for i in imageLabelList {
            i.text = "\(tempName.popLast() ?? "빔") \(tempRandom.popLast()!)"
        }
    }
    
    
}


