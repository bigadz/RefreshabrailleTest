//
//  ViewController.swift
//  RefreshabrailleTest
//
//  Created by Adam Croser on 26/11/16.
//  Copyright © 2016 Adam Croser. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	private var currentConstraints : [NSLayoutConstraint]?
	private var views: [String : Any] = [:]

	private var accessibleButton: UIButton! = nil;
	private var accessibleLabel: UILabel! = nil;
	
	// The margin between all views
	private var margin: CGFloat = 10

	
	override func viewDidLoad() {
		self.initialize()
		super.viewDidLoad()
		
		Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.update), userInfo: nil, repeats: true);
	}

	func update()
	{
		let date = Date()
		let calendar = NSCalendar.current
		let seconds = calendar.component(Calendar.Component.second, from: date)
		let txt = "\(seconds)"

		self.accessibleLabel.text = txt
		self.accessibleButton.setTitle(txt, for: .normal)
		self.accessibleLabel.accessibilityLabel = txt
		self.accessibleButton.accessibilityLabel = txt
	}
	
	private func initialize()
	{
		// Init vars here
		self.view.backgroundColor = UIColor.black
		self.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		
		self.accessibleButton = UIButton(type: UIButtonType.custom)
		if let c = self.accessibleButton
		{
			c.setTitle("Button", for: .normal)
			c.accessibilityTraits = UIAccessibilityTraitPlaysSound | UIAccessibilityTraitKeyboardKey | UIAccessibilityTraitUpdatesFrequently;
			c.backgroundColor = UIColor(red:0.9, green:1.0, blue:0.8, alpha:1.0)
			c.setTitleColor(UIColor.black, for: .normal)
			c.translatesAutoresizingMaskIntoConstraints = false
		}
		
		self.accessibleLabel = UILabel()
		if let c = self.accessibleLabel
		{
			c.text = "Label"
			c.accessibilityTraits = UIAccessibilityTraitPlaysSound | UIAccessibilityTraitKeyboardKey | UIAccessibilityTraitUpdatesFrequently;
			c.adjustsFontSizeToFitWidth = true
			c.backgroundColor = UIColor.white
			c.textAlignment = .center
			c.textColor = UIColor.black
			c.font = UIFont(name: "Arial", size: UIDevice.current.userInterfaceIdiom == .pad ? 72 : 36)!
			c.translatesAutoresizingMaskIntoConstraints = false
		}
		
		
		// Create view dictionary
		
		views["accessibleButton"] = self.accessibleButton!
		views["accessibleLabel"] = self.accessibleLabel!
		
		
		self.view.addSubview(self.accessibleButton!)
		self.view.addSubview(self.accessibleLabel!)
		
		self.view.setNeedsUpdateConstraints()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	
	override var supportedInterfaceOrientations: UIInterfaceOrientationMask
	{
		get
		{
			return UIInterfaceOrientationMask.all
		}
	}
	
	override func viewWillLayoutSubviews()
	{
		self.view.setNeedsUpdateConstraints()
		super.viewWillLayoutSubviews()
	}

	
	override func updateViewConstraints()
	{
		// Check to see if the View needs to update it's constraints
		if self.view.needsUpdateConstraints()
		{
			self.setupViewConstraints();
		}
		super.updateViewConstraints() // Important, always call this last
	}

	
	private func setupViewConstraints()
	{
		
		var constraints: [NSLayoutConstraint] = []
		
		
		let metrics: [String : Any] = ["margin": margin, "top": CGFloat(20)]
		

		// [accessibleButton] [accessibleLabel]
		
		// H:
		
		
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-margin-[accessibleButton]-margin-[accessibleLabel(==accessibleButton)]-margin-|", options: [.alignAllTop, .alignAllBottom], metrics: metrics, views: views)

		// V:
		
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[accessibleButton(==100)]", options: [.directionMask], metrics: metrics, views: views)
		
		
		constraints.append(NSLayoutConstraint(item: self.accessibleButton!, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0))
		
		if self.currentConstraints != nil
		{
			NSLayoutConstraint.deactivate (self.currentConstraints!)
		}
		self.currentConstraints = constraints
		NSLayoutConstraint.activate (self.currentConstraints!)
	}
	
}

