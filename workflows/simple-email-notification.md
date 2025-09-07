# Simple Email Notification Workflow

This is a beginner-friendly workflow that demonstrates how to send an email notification when triggered manually.

## Workflow Overview

**Trigger**: Manual → **Action**: Send Email

## What You'll Learn

- How to set up a manual trigger
- How to configure email sending
- Basic workflow structure
- Testing workflows

## Setup Instructions

1. **Prerequisites**:
   - n8n installed and running
   - Email account with SMTP access (Gmail, Outlook, etc.)

2. **Create the workflow**:
   - Open n8n in your browser
   - Create a new workflow
   - Keep the "Manual Trigger" node that appears by default

3. **Add Email Node**:
   - Click the "+" button next to the Manual Trigger
   - Search for "Send Email" and select it
   - Configure your email settings

4. **Email Configuration**:
   ```
   SMTP Host: smtp.gmail.com (for Gmail)
   SMTP Port: 587
   Security: STARTTLS
   Username: your-email@gmail.com
   Password: your-app-password
   ```

5. **Email Content**:
   ```
   From: your-email@gmail.com
   To: recipient@example.com
   Subject: Test Email from n8n
   Text: Hello! This is a test email sent from my n8n workflow.
   ```

## Testing

1. Click "Execute Workflow" button
2. Check your email inbox
3. You should receive the test email

## Next Steps

Try modifying this workflow to:
- Send emails to multiple recipients
- Include dynamic content using expressions
- Add conditional logic before sending

## Workflow JSON

Save this as a `.json` file and import it into n8n:

```json
{
  "name": "Simple Email Notification",
  "nodes": [
    {
      "parameters": {},
      "name": "Manual Trigger",
      "type": "n8n-nodes-base.manualTrigger",
      "typeVersion": 1,
      "position": [240, 300],
      "id": "manual-trigger-1"
    },
    {
      "parameters": {
        "fromEmail": "your-email@gmail.com",
        "toEmail": "recipient@example.com",
        "subject": "Test Email from n8n",
        "text": "Hello! This is a test email sent from my n8n workflow."
      },
      "name": "Send Email",
      "type": "n8n-nodes-base.emailSend",
      "typeVersion": 1,
      "position": [460, 300],
      "id": "send-email-1"
    }
  ],
  "connections": {
    "Manual Trigger": {
      "main": [
        [
          {
            "node": "Send Email",
            "type": "main",
            "index": 0
          }
        ]
      ]
    }
  }
}
```

## Tips

- Use app passwords for Gmail instead of your regular password
- Test with your own email address first
- Check spam folder if emails don't appear in inbox
- Always save your workflow after making changes
