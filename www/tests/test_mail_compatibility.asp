<%@ Language=JScript %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>G3MAIL Compatibility Test</title>
    <link rel="stylesheet" href="../css/axonasp.css">
    <style>
        .test-card {
            background-color: var(--bg-elevated);
            border: 1px solid var(--border);
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            border-radius: var(--radius-md);
        }
        .status-pass {
            color: var(--success);
            font-weight: bold;
        }
        .status-fail {
            color: var(--danger);
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div id="main-container" class="manual-page">
        <header id="header">
            <h1>G3MAIL Compatibility Test</h1>
            <p class="text-muted">Verifying G3MAIL behaves identically to Persits.MailSender (ASPEmail) and SMTPsvg.Mailer (ASPMail).</p>
        </header>

        <div id="content">
            <%
            var passCount = 0;
            var testCount = 0;

            function runTest(name, fn) {
                testCount++;
                try {
                    var res = fn();
                    if (res === true) {
                        passCount++;
                        Response.Write("<div class='test-card'><h3>Test: " + name + "</h3><p>Result: <span class='status-pass'>PASS</span></p></div>");
                    } else {
                        Response.Write("<div class='test-card'><h3>Test: " + name + "</h3><p>Result: <span class='status-fail'>FAIL</span> - " + res + "</p></div>");
                    }
                } catch(e) {
                    Response.Write("<div class='test-card'><h3>Test: " + name + "</h3><p>Result: <span class='status-fail'>FAIL (Exception)</span> - " + e.message + "</p></div>");
                }
            }

            // 1. Test Persits.MailSender Compatibility
            runTest("Persits.MailSender (ASPEmail) Properties & Methods", function() {
                var mail = Server.CreateObject("Persits.MailSender");
                if (!mail) {
                    return "Failed to instantiate Persits.MailSender";
                }

                // Properties
                mail.Host = "smtp.aspemail.com";
                mail.Port = 25;
                mail.CharSet = "utf-8";
                mail.From = "sender@aspemail.com";
                mail.FromName = "ASPEmail Tester";
                mail.Subject = "ASPEmail Subject";
                mail.Body = "ASPEmail Body";
                
                // Methods
                mail.AddAddress("john@example.com", "John Doe");
                mail.AddCC("cc@example.com", "CC Tester");
                mail.AddBcc("bcc@example.com", "Bcc Tester");
                mail.AddReplyTo("reply@example.com");

                // Clear methods
                mail.ClearCC();
                mail.ClearBcc();

                return true;
            });

            // 2. Test SMTPsvg.Mailer Compatibility
            runTest("SMTPsvg.Mailer (ASPMail) Properties & Methods", function() {
                var mail = Server.CreateObject("SMTPsvg.Mailer");
                if (!mail) {
                    return "Failed to instantiate SMTPsvg.Mailer";
                }

                // Aliases
                mail.RemoteHost = "smtp.aspmail.com";
                mail.FromAddress = "sender@aspmail.com";
                mail.BodyText = "ASPMail Body";
                mail.ContentType = "text/html";

                // AddRecipient/AddCC with reversed parameter order (name, email)
                mail.AddRecipient("Alice Smith", "alice@example.com");
                mail.AddCC("Bob", "bob@example.com");
                mail.AddBCC("Charlie", "charlie@example.com");

                // Clear methods
                mail.ClearRecipients();
                mail.ClearCCs();
                mail.ClearBCCs();

                return true;
            });

            Response.Write("<div class='test-card'><h2>Summary: " + passCount + "/" + testCount + " tests passed.</h2></div>");
            %>
        </div>
    </div>
</body>
</html>
