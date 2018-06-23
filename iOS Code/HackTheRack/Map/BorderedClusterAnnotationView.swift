//
//  BorderedClusterAnnotationView.swift
//  HackTheRack
//
//  Created by KL on 22/6/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import Cluster
import MapKit

class BorderedClusterAnnotationView: ClusterAnnotationView {

    init(annotation: MKAnnotation?, reuseIdentifier: String?, style: ClusterAnnotationStyle, borderColor: UIColor) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier, style: style)
        self.borderColor = borderColor
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure(with style: ClusterAnnotationStyle) {
        super.configure(with: style)
        
        switch style {
        case .image:
            layer.borderWidth = 0
        case .color:
            layer.borderColor = borderColor?.cgColor
            layer.borderWidth = 2
        }
        
        // Custome the color of cluster
        guard let annotation = annotation as? ClusterAnnotation else { return }
        if annotation.annotations.count > 50{
            backgroundColor = UIColor.blue
        }else if annotation.annotations.count > 20{
            backgroundColor = UIColor.green
        }
    }
}
