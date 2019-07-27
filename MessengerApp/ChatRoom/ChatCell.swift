//
//  ChatCell.swift
//  MessengerApp
//
//  Created by dikasetiadi on 23/07/19.
//  Copyright © 2019 Leanbs. All rights reserved.
//

import AsyncDisplayKit

public class ChatCell: ASCellNode {
    private var textMessage = ""
    private let messageTextNode = ASTextNode()
    private let messageBubble = ASDisplayNode()
    private let profilePictureNode = ASNetworkImageNode()
    private var childernRowChat: [ASLayoutElement] = []
    private var isSenderTextChat: Bool = false
    
    init(messageInfo: ChatMessage, userData: Contact) {
        super.init()
        
        automaticallyManagesSubnodes = true
        
        /* pass checker isSender */
        isSenderTextChat = messageInfo.isSender
        
        /* set text chat */
        textMessage = messageInfo.text
        setupTextNode()
        
        /* set image Profic */
        if !isSenderTextChat {
            profilePictureNode.image = userData.profilePicture
            profilePictureNode.contentMode = .scaleAspectFit
            profilePictureNode.style.preferredSize = CGSize(width: 30, height: 30)
            profilePictureNode.cornerRadius = 15

            childernRowChat.insert(profilePictureNode, at: 0)
        }
    }
    
    private func setupTextNode() {
        let attributedText = NSAttributedString.init(string: textMessage, attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor: isSenderTextChat ? UIColor.white : UIColor.black])
        
        messageTextNode.attributedText = attributedText
        messageTextNode.style.maxWidth = ASDimensionMake(200)
        messageTextNode.truncationMode = .byWordWrapping
        
        /* set bubble chat */
        messageBubble.automaticallyManagesSubnodes = true
        messageBubble.backgroundColor = isSenderTextChat ? #colorLiteral(red: 0.2078431373, green: 0.4705882353, blue: 0.8980392157, alpha: 1) : UIColor.init(white: 0.95, alpha: 1)
        messageBubble.layoutSpecBlock = { [weak self] _,_ in
            guard let self = self else {
                return ASLayoutSpec()
            }
            
            let stack = ASStackLayoutSpec.vertical()
            stack.flexWrap = .wrap
            stack.justifyContent = .start
            stack.alignItems = .start
            stack.children = [ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), child: self.messageTextNode)]
            
            return stack
        }
        
        childernRowChat.append(messageBubble)
    }
    
    override public func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let rowChatBubbleStack = ASStackLayoutSpec.horizontal()
        rowChatBubbleStack.spacing = 8
        rowChatBubbleStack.alignItems = .end
        rowChatBubbleStack.children = childernRowChat
        
        let stack = ASStackLayoutSpec.vertical()
        
        // set .start if not sender and .end if this chat is from sender
        stack.alignItems = isSenderTextChat ? .end : .start

        stack.children = [rowChatBubbleStack]
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8), child: stack)
    }
    
    public override func layout() {
        super.layout()
        
        let messageText = textMessage
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)

        let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
        
        messageBubble.frame.size = CGSize(width: estimatedFrame.width + 16, height: estimatedFrame.height + 16)
        messageBubble.cornerRadius = 16

    }
}

