const nodemailer = require("nodemailer");
const { google } = require('googleapis');
const jwt = require("jsonwebtoken");

// Load credentials from .env file
const { CLIENT_ID, CLIENT_SECRET, REDIRECT_URI, REFRESH_TOKEN, TO_EMAIL } = process.env;

// Create OAuth2 client
const oAuth2Client = new google.auth.OAuth2(CLIENT_ID, CLIENT_SECRET, REDIRECT_URI);
oAuth2Client.setCredentials({ refresh_token: REFRESH_TOKEN });

// Create a transporter object using Gmail SMTP
const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        type: 'OAuth2',
        user: TO_EMAIL,
        clientId: CLIENT_ID,
        clientSecret: CLIENT_SECRET,
        refreshToken: REFRESH_TOKEN,
        accessToken: oAuth2Client.getAccessToken(),
    },
});

const sendingOTP = async (req, res, next) => {
    try {
        // Get email data from request body
        const to = req.body.email;

        // Generating OTP
        const digits = '0123456789';
        let otp = '';
        for (let i = 0; i < 6; i++) {
            otp += digits[Math.floor(Math.random() * 10)];
        }

        // Validate email data
        if (!to) {
            return res.status(400).send("Invalid email data");
        }

        // Define email options
        const mailOptions = {
            from: TO_EMAIL,
            to,
            subject: "Password Recovery for Your Account",
            text: `Dear ${to.split('@')[0]},
            
We have received a request to reset the password for your account. Please use the following OTP code to reset your password:
            
${otp}
            
If you did not make this request, please ignore this email.
            
Thank you,
Great Professional Services`,
        };

        // Send the email
        const info = await transporter.sendMail(mailOptions);

        console.log(`Email sent to ${to}, Message ID: ${info.messageId}`);

        // Return a success response
        // res.status(200).send({
        //     message: "Email sent successfully",
        //     status: 200
        // });
        req.id = otp;
        next();
    } catch (error) {
        console.error(error);

        // handle SMTP errors
        if (error.code === "ECONNREFUSED") {
            res.status(500).send({
                message: "SMTP server is not responding",
                status: 500
            });
        } else if (error.code === "EAUTH") {
            res.status(401).send({
                message: "Invalid SMTP credentials",
                status: 401
            });
        } else {
            res.status(500).send({
                message: "Failed to send email",
                status: 500
            });
        }
    }
    return next;
}

const confirmEmail = async (user) => {
    try {
        // Get email data from request body
        const to = user.email;
        const url = jwt.sign(
            {
                id: user._id,
            },
            process.env.JWT_TOKEN,
            { expiresIn: "2d" }
        );

        // Validate email data
        if (!to) {
            return res.status(400).send("Invalid email data");
        }

        // Define email options
        const mailOptions = {
            from: TO_EMAIL,
            to,
            subject: "Confirm Your Account",
            html: `<!DOCTYPE html>
            <html>
            
            <head>
            
                <meta charset="utf-8">
                <meta http-equiv="x-ua-compatible" content="ie=edge">
                <title>Email Confirmation</title>
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <style type="text/css">
                    /**
               * Google webfonts. Recommended to include the .woff version for cross-client compatibility.
               */
                    @media screen {
                        @font-face {
                            font-family: 'Source Sans Pro';
                            font-style: normal;
                            font-weight: 400;
                            src: local('Source Sans Pro Regular'), local('SourceSansPro-Regular'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/ODelI1aHBYDBqgeIAH2zlBM0YzuT7MdOe03otPbuUS0.woff) format('woff');
                        }
            
                        @font-face {
                            font-family: 'Source Sans Pro';
                            font-style: normal;
                            font-weight: 700;
                            src: local('Source Sans Pro Bold'), local('SourceSansPro-Bold'), url(https://fonts.gstatic.com/s/sourcesanspro/v10/toadOcfmlt9b38dHJxOBGFkQc6VGVFSmCnC_l7QZG60.woff) format('woff');
                        }
                    }
            
                    /**
               * Avoid browser level font resizing.
               * 1. Windows Mobile
               * 2. iOS / OSX
               */
                    body,
                    table,
                    td,
                    a {
                        -ms-text-size-adjust: 100%;
                        /* 1 */
                        -webkit-text-size-adjust: 100%;
                        /* 2 */
                    }
            
                    /**
               * Remove extra space added to tables and cells in Outlook.
               */
                    table,
                    td {
                        mso-table-rspace: 0pt;
                        mso-table-lspace: 0pt;
                    }
            
                    /**
               * Better fluid images in Internet Explorer.
               */
                    img {
                        -ms-interpolation-mode: bicubic;
                    }
            
                    /**
               * Remove blue links for iOS devices.
               */
                    a[x-apple-data-detectors] {
                        font-family: inherit !important;
                        font-size: inherit !important;
                        font-weight: inherit !important;
                        line-height: inherit !important;
                        color: inherit !important;
                        text-decoration: none !important;
                    }
            
                    /**
               * Fix centering issues in Android 4.4.
               */
                    div[style*="margin: 16px 0;"] {
                        margin: 0 !important;
                    }
            
                    body {
                        width: 100% !important;
                        height: 100% !important;
                        padding: 0 !important;
                        margin: 0 !important;
                    }
            
                    /**
               * Collapse table borders to avoid space between cells.
               */
                    table {
                        border-collapse: collapse !important;
                    }
            
                    a {
                        color: #1a82e2;
                    }
            
                    img {
                        height: auto;
                        line-height: 100%;
                        text-decoration: none;
                        border: 0;
                        outline: none;
                    }
                </style>
            
            </head>
            
            <body style="background-color: #e9ecef;">
            
                <!-- start preheader -->
                <div class="preheader"
                    style="display: none; max-width: 0; max-height: 0; overflow: hidden; font-size: 1px; line-height: 1px; color: #fff; opacity: 0;">
                    A preheader is the short summary text that follows the subject line when an email is viewed in the inbox.
                </div>
                <!-- end preheader -->
            
                <!-- start body -->
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
            
                    <!-- start hero -->
                    <tr>
                        <td align="center" bgcolor="#e9ecef">
                            <!--[if (gte mso 9)|(IE)]>
                    <table align="center" border="0" cellpadding="0" cellspacing="0" width="600">
                    <tr>
                    <td align="center" valign="top" width="600">
                    <![endif]-->
                            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 600px;">
                                <tr>
                                    <td align="left" bgcolor="#ffffff"
                                        style="padding: 36px 24px 0; font-family: 'Source Sans Pro', Helvetica, Arial, sans-serif; border-top: 3px solid #d4dadf;">
                                        <h1
                                            style="margin: 0; font-size: 32px; font-weight: 700; letter-spacing: -1px; line-height: 48px;">
                                            Confirm
                                            Your Email Address</h1>
                                    </td>
                                </tr>
                            </table>
                            <!--[if (gte mso 9)|(IE)]>
                    </td>
                    </tr>
                    </table>
                    <![endif]-->
                        </td>
                    </tr>
                    <!-- end hero -->
            
                    <!-- start copy block -->
                    <tr>
                        <td align="center" bgcolor="#e9ecef">
                            <!--[if (gte mso 9)|(IE)]>
                    <table align="center" border="0" cellpadding="0" cellspacing="0" width="600">
                    <tr>
                    <td align="center" valign="top" width="600">
                    <![endif]-->
                            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 600px;">
            
                                <!-- start copy -->
                                <tr>
                                    <td align="left" bgcolor="#ffffff"
                                        style="padding: 24px; font-family: 'Source Sans Pro', Helvetica, Arial, sans-serif; font-size: 16px; line-height: 24px;">
                                        <h3>Welcome!</h3>
                                        <p style="margin: 0;">Thank you for registering with Great Professional Services! Please confirm your
                                            email
                                            address by clicking on the button below:</p>
                                    </td>
                                </tr>
                                <!-- end copy -->
            
                                <!-- start button -->
                                <tr>
                                    <td align="left" bgcolor="#ffffff">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td align="center" bgcolor="#ffffff" style="padding: 12px;">
                                                    <table border="0" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td align="center" bgcolor="#1a82e2" style="border-radius: 6px;">
                                                                <a href="https://maintenance-app.herokuapp.com/user/api/verify/${url}" target="_blank"
                                                                    style="display: inline-block; padding: 16px 36px; font-family: 'Source Sans Pro', Helvetica, Arial, sans-serif; font-size: 16px; color: #ffffff; text-decoration: none; border-radius: 6px;">
                                                                    Verify your Account</a>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <!-- end button -->
            
                                <!-- start copy -->
                                <tr>
                                    <td align="left" bgcolor="#ffffff"
                                        style="padding: 24px; font-family: 'Source Sans Pro', Helvetica, Arial, sans-serif; font-size: 16px; line-height: 24px;">
                                        <p style="margin: 0;">If that doesn't work, copy and paste the following link in your
                                            browser:</p>
                                        <p style="margin: 0;"><a href="https://maintenance-app.herokuapp.com/user/api/verify/${url}"
                                                target="_blank">https://maintenance-app.herokuapp.com/user/api/verify/${url}</a></p>
                                    </td>
                                </tr>
                                <!-- end copy -->
            
                            </table>
                            <!--[if (gte mso 9)|(IE)]>
                    </td>
                    </tr>
                    </table>
                    <![endif]-->
                        </td>
                    </tr>
                    <!-- end copy block -->
            
                    <!-- start footer -->
                    <tr>
                        <td align="center" bgcolor="#e9ecef" style="padding: 24px;">
                            <!--[if (gte mso 9)|(IE)]>
                    <table align="center" border="0" cellpadding="0" cellspacing="0" width="600">
                    <tr>
                    <td align="center" valign="top" width="600">
                    <![endif]-->
                            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 600px;">
            
                                <!-- start permission -->
                                <tr>
                                    <td align="center" bgcolor="#e9ecef"
                                        style="padding: 12px 24px; font-family: 'Source Sans Pro', Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; color: #666;">
                                        <p style="margin: 0;">You received this email because we received a request for
                                            [type_of_action] for your
                                            account. If you didn't request [type_of_action] you can safely delete this email.</p>
                                    </td>
                                </tr>
                                <!-- end permission -->
            
            
            
                            </table>
                            <!--[if (gte mso 9)|(IE)]>
                    </td>
                    </tr>
                    </table>
                    <![endif]-->
                        </td>
                    </tr>
                    <!-- end footer -->
            
                </table>
                <!-- end body -->
            
            </body>
            
            </html>`
        };

        // Send the email
        const info = await transporter.sendMail(mailOptions);

        console.log(`Email sent to ${to}, Message ID: ${info.messageId}`);
        return true;
    } catch (error) {
        console.error(error);
        return false;
    }
    return false;
}

module.exports = { sendingOTP, confirmEmail };