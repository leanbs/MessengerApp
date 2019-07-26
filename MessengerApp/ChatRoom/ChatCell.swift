//
//  ChatCell.swift
//  MessengerApp
//
//  Created by Nakama on 23/07/19.
//  Copyright © 2019 Leanbs. All rights reserved.
//

import AsyncDisplayKit

public class ChatCell: ASCellNode {
    let messageText = ASTextNode()
    
    init(messageInfo: ChatMessage) {
        super.init()
        
        messageText.attributedText = NSAttributedString.init(string: messageInfo.text, attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        
        automaticallyManagesSubnodes = true
        backgroundColor = .white
    }
    
    override public func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec.vertical()
        stack.children = [messageText]
        
        return stack
    }
}
