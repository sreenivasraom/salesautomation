trigger Email_Attachments on Lead (after update) {
    
    for(Lead leadObj: Trigger.new){
        
        if(leadObj.Status =='Questionnaire received')
        {
           // EmailAttachment.sendAttachments(leadObj.id);
            }
        }
    }