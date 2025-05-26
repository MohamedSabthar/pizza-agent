import ballerinax/googleapis.gmail;

# Sends an email using Gmail.
#
# + toEmail - Recipient email address
# + subject - Email subject
# + body - Email body content
# + return - Error if sending fails
isolated function sendEmail(string toEmail, string subject, string body) returns error|gmail:Message {
    gmail:MessageRequest messageRequest = {
        to: [toEmail],
        subject: subject,
        bodyInText: body
    };

    // Send the email message and get the response
    return gmailClient->/users/["me"]/messages/send.post(messageRequest);
}