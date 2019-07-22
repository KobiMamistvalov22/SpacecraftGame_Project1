//
//  SecondeView.swift
//  SpacecraftGame_Project1
//
//  Created by Kobi Mamistvalov on 7/22/19.
//  Copyright © 2019 Kobi Mamistvalov. All rights reserved.
//

import UIKit

class SecondeView: UIViewController {
    
    weak var mainViewController: ViewController!
    var backgroundSwitch: UISwitch!
    var backSpace: UIImageView!
    let spaceImage = UIImage(named: "space")
    var spaceCraft: [Spacecraft] = []
    let imageSpacecraft = ["cool_Roket"]
    var lazer: [Lazer] = []
    let lazerImage = ["lazer_1"]
    var enemy: [Enemy] = []
    let imageEnemys = ["enemy_2", "enemy_3"]
    var roket: Spacecraft!
    var lazers: Lazer!
    var enemys: Enemy!
    var tapLocation: UITapGestureRecognizer!
    var rocketLocation: CGFloat = 150
    var rocketNeedMoved: CGFloat = 186
    var scorelbl: UILabel!
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        backSpace = UIImageView(frame: view.frame)
        backSpace.image = spaceImage
        backSpace.center = view.center
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        let alertA = UIAlertController(title: "Welcome \(mainViewController.name)!", message: "Choice your bacground:", preferredStyle: .alert)
        backgroundSwitch = UISwitch(frame: CGRect(x: 7, y: 50, width: 0, height: 0))
        backgroundSwitch.setOn(false, animated: true)
        backgroundSwitch.addTarget(self, action: #selector(backgroundChanged(sender:)), for: .valueChanged)
        alertA.view.addSubview(backgroundSwitch)
        let action = UIAlertAction(title: "OK", style: .default) { (actionn: UIAlertAction) in
            self.startGame()
        }
        
        alertA.addAction(action)
        present(alertA, animated: true, completion: nil)
        
    }
    
    @objc func backgroundChanged(sender: UISwitch){
        if backgroundSwitch.isOn == true{
            view.addSubview(backSpace)
            //scorelbl.textColor = .white
        }else{
            view.backgroundColor = .white
            backSpace.removeFromSuperview()
            //scorelbl.textColor = .green
        }
    }
    
    func startGame(){
        tapLocation = UITapGestureRecognizer(target: self, action: #selector(taped(sender:)))
        view.addGestureRecognizer(tapLocation)
        roket = Spacecraft(frame: CGRect(x: rocketLocation, y: view.frame.height - 85 - 5, width: 80, height: 80), bounds: CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.width, height: view.frame.height))
        roket.image = UIImage(named: imageSpacecraft[spaceCraft.count])
        scorelbl = UILabel(frame: CGRect(x: 10, y: 70, width: 200, height: 40))
        scorelbl.text = "Score: \(score)"
        scorelbl.font = UIFont.boldSystemFont(ofSize: 20)
        if backgroundSwitch.isOn == true{
            scorelbl.textColor = .white
        }else{
            scorelbl.textColor = .black
        }
        view.addSubview(scorelbl)
        
        view.addSubview(roket)
        spaceCraft.append(roket)
        render1()
        shoot()
        renderEneny()
        render2()
        
    }
    func render1(){
        for roket in spaceCraft{
            rocketLocation += (rocketNeedMoved - rocketLocation) * 0.1
            roket.center.x = rocketLocation
            roket.moveSpacecraft()
        }
        let popTime = DispatchTime(uptimeNanoseconds: DispatchTime.now().rawValue + NSEC_PER_MSEC * 20)
        DispatchQueue.main.asyncAfter(deadline: popTime){
            self.render1()
        }
    }
    
    @objc func taped(sender: UITapGestureRecognizer){
        let location = sender.location(in: view)
        rocketNeedMoved = location.x
    }
    
    public func shoot(){
        self.lazers = Lazer(frame: CGRect(x: self.rocketLocation, y: self.view.frame.height - 115, width: 20, height: 50))
        self.lazers.image = UIImage(named: self.lazerImage[self.lazer.count % self.lazerImage.count])
        self.lazers.center.x = self.roket.center.x
        self.view.addSubview(self.lazers)
        self.lazer.append(self.lazers)
        let popTime = DispatchTime(uptimeNanoseconds: DispatchTime.now().rawValue + NSEC_PER_MSEC * 1100)
        DispatchQueue.main.asyncAfter(deadline: popTime){
            self.shoot()
        }
    }
    
    public func renderEneny(){
        enemys = Enemy(frame: CGRect(x: Int(Float.random(in: 0..<700)), y: 50, width: 64, height: 64), bounds: CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.width, height: view.frame.height))
        enemys.image = UIImage(named: imageEnemys[enemy.count % imageEnemys.count])
        view.addSubview(enemys)
        enemy.append(enemys)
        let some = DispatchTime(uptimeNanoseconds: DispatchTime.now().rawValue + NSEC_PER_MSEC * 2450)
        DispatchQueue.main.asyncAfter(deadline: some) {
            self.renderEneny()
        }
    }
    
    func render2(){
        lazers.lazerMoved()
        enemys.moveEnemy()
        
        if lazers.frame.minY <= (enemys.frame.maxY) && lazers.frame.minX > enemys.frame.minX && lazers.frame.maxX < enemys.frame.maxX{
            enemys.frame = CGRect(x: 1000, y: -1000, width: 64, height: 64)
            lazers.frame = CGRect(x: 1000, y: -1000, width: 20, height: 50)
            score += 10
            scorelbl.text = "Score: \(score)"
            //enemy.isHidden = true
            //lazer1.isHidden = true
        }else if enemys.frame.maxY > view.frame.height{
            enemys.isHidden = true
        }else if lazers.frame.minY < view.frame.minY + 40{
            lazers.frame = CGRect(x: 1000, y: -1000, width: 20, height: 50)
        }else if enemys.frame.maxY > roket.frame.minY && enemys.frame.maxX > (roket.frame.minX + 5) && enemys.frame.minX < (roket.frame.maxX + 5){
            enemys.frame = CGRect(x: 1000, y: -1000, width: 64, height: 64)
            enemys.isHidden = true
            score -= 10
            scorelbl.text = "Score: \(score)"
        }
        let some = DispatchTime(uptimeNanoseconds: DispatchTime.now().uptimeNanoseconds + NSEC_PER_MSEC * 20)
        DispatchQueue.main.asyncAfter(deadline: some){
            self.render2()
        }
    }
}
