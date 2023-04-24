// Description: This file contains all the functions related to user
// package imports
const { User } = require('../Constants/Imports');
const CryptoJS = require("crypto-js");
const jwt = require("jsonwebtoken");
const { confirmEmail } = require('../Middleware/sendEmail')

/**
 * @description: This function is used to register a new user
 */
const UserRegisteration = async (req, res, next) => {
    try {
        const newUser = new User({
            username: req.body.username,
            email: req.body.email,
            usertype: 'user',
            password: CryptoJS.AES.encrypt(
                req.body.password,
                process.env.SECRET_PASSWORD
            ).toString(),
            image: req.body.image,
            contactNumber: req.body.contact,
            floorNumber: req.body.floor
        });

        const savedUser = await newUser.save();

        const sent = await confirmEmail(savedUser);

        if (sent) {
            res.send({
                message: "Your Data Saved Successfully",
                status: 200,
                data: savedUser,
            });
        } else {
            await User.findOneAndDelete({ _id: savedUser._id });
            res.send({
                message: "Data not Saved",
                status: 404,
            });
        }
    } catch (err) {
        if (err.toString().includes("MongoServerError: E11000 duplicate key")) {
            res.send({
                message: "User Already Registered",
                status: 404,
            });
        } else {
            res.send({
                message: "Data not Saved",
                status: 404,
            });
        }
    }
};

/**
 * @description: This function is used to verify email address
 */
const VerifyEmail = async (req, res, next) => {
    try {
        const userid = jwt.verify(req.params.id, process.env.JWT_TOKEN);
        const verify = await User.findOneAndUpdate({ _id: userid.id }, {
            $set: {
                isverified: true
            }
        });
        if (verify) {
            res.send(`<!DOCTYPE html>
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
              </style>
            </head>
            
            <body style="background-color: #e9ecef;">
              <!-- start body -->
              <table border="0" cellpadding="0" cellspacing="0" width="100%">
            
                <!-- start hero -->
                <tr>
                  <td align="center" bgcolor="#e9ecef">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 600px;">
                      <tr>
                        <td align="left" bgcolor="#ffffff"
                          style="padding: 36px 24px 36px; font-family: 'Source Sans Pro', Helvetica, Arial, sans-serif; border-top: 3px solid #d4dadf;">
                          <h1 style="margin: 0; font-size: 32px; font-weight: 700; letter-spacing: -1px; line-height: 48px;">
                          Email Verified, Login into the Application</h1>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <!-- end hero -->
            </body>
            
            </html>`);
        } else {
            res.send(`<!DOCTYPE html>
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
              </style>
            </head>
            
            <body style="background-color: #e9ecef;">
              <!-- start body -->
              <table border="0" cellpadding="0" cellspacing="0" width="100%">
            
                <!-- start hero -->
                <tr>
                  <td align="center" bgcolor="#e9ecef">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 600px;">
                      <tr>
                        <td align="left" bgcolor="#ffffff"
                          style="padding: 36px 24px 36px; font-family: 'Source Sans Pro', Helvetica, Arial, sans-serif; border-top: 3px solid #d4dadf;">
                          <h1 style="margin: 0; font-size: 32px; font-weight: 700; letter-spacing: -1px; line-height: 48px;">
                          Email Not Verified</h1>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <!-- end hero -->
            </body>
            
            </html>`);
        }

    } catch (error) {
        res.send(`<!DOCTYPE html>
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
          </style>
        </head>
        
        <body style="background-color: #e9ecef;">
          <!-- start body -->
          <table border="0" cellpadding="0" cellspacing="0" width="100%">
        
            <!-- start hero -->
            <tr>
              <td align="center" bgcolor="#e9ecef">
                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 600px;">
                  <tr>
                    <td align="left" bgcolor="#ffffff"
                      style="padding: 36px 24px 36px; font-family: 'Source Sans Pro', Helvetica, Arial, sans-serif; border-top: 3px solid #d4dadf;">
                      <h1 style="margin: 0; font-size: 32px; font-weight: 700; letter-spacing: -1px; line-height: 48px;">
                      Email Not Verified, Error: ${error}</h1>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <!-- end hero -->
        </body>
        
        </html>`);
    }
};

/**
 * @description: This function is used to login a user
 */
const UserLogin = async (req, res) => {
    try {
        const user = await User.findOne({ email: req.body.email });
        const originalpassword = CryptoJS.AES.decrypt(
            user.password,
            process.env.SECRET_PASSWORD
        ).toString(CryptoJS.enc.Utf8);
        if (!user) {
            res.send({
                message: "Invalid Email",
                status: 404,
            });
        } else if (originalpassword !== req.body.password) {
            res.send({
                message: "Invalid Password",
                status: 404,
            });
        } else {
            if (user.isverified) {
                const access_token = jwt.sign(
                    {
                        id: user._id,
                    },
                    process.env.JWT_TOKEN,
                    { expiresIn: "30d" }
                );

                const { token } = user._doc;
                res.send({
                    message: "Loggedin Successfully",
                    status: 200,
                    data: { access_token, user },

                });
            } else {
                res.send({
                    message: "Verify your Email",
                    status: 200,
                    data: {},

                });
            }
        }
    } catch (error) {
        res.send({
            message: "Invalid Credentails",
            status: 500,
        });
    }
}

/**
 * @description: This function is used to insert Otp into the user collection
 */
const OtpInsertion = async (req, res) => {
    try {
        const otpInput = req.id;
        const otp = await User.findOneAndUpdate({ email: req.body.email }, {
            $set: {
                otp: otpInput
            }
        });
        if (otp) {
            res.send({
                message: "Otp Inserted Successfully",
                status: 200,
            });
        } else {
            res.send({
                message: "Otp Inserted Unsuccessfully",
                status: 200,
            });
        }

    } catch (error) {
        res.send({
            message: "Otp Inserted Unsuccessfully",
            status: 200,
        });
    }
}

/**
 * @description: This function is used to verifty the otp
 */
const OtpCheck = async (req, res) => {
    try {
        const model = await User.findOne({ email: req.body.email });
        if (model.otp == req.body.otp) {
            res.send({
                message: "OTP Matched",
                status: 200,
            });
        } else {
            res.send({
                message: "OTP Unmatched",
                status: 200,
            });
        }

    } catch (error) {
        res.send({
            message: "Data Not Found",
            status: 200,
        });
    }
}

/**
 * @description: This function is used to reset the password
 */
const resetPass = async (req, res) => {
    try {
        const model = await User.findOneAndUpdate(
            {
                email: req.body.email
            }, {
            $set: {
                password: CryptoJS.AES.encrypt(
                    req.body.password,
                    process.env.SECRET_PASSWORD
                ).toString()
            }
        });

        if (model) {
            res.send({
                message: "Password Reset Successfully",
                status: 200,
            });
        } else {
            res.send({
                message: "Password Reset Unsuccessfully",
                status: 200,
            });
        }

    } catch (error) {
        res.send({
            message: "Password Reset Unsuccessfully",
            status: 200,
        });
    }
}

/**
 * @description: This function is used to change the password
 */
const changePass = async (req, res) => {
    try {
        const model = await User.findByIdAndUpdate(req.id,
            {
                $set: {
                    password: CryptoJS.AES.encrypt(
                        req.body.password,
                        process.env.SECRET_PASSWORD
                    ).toString()
                }
            });

        if (model) {
            res.send({
                message: "Password Changed Successfully",
                status: 200,
            });
        } else {
            res.send({
                message: "Password Changed Unsuccessfully",
                status: 200,
            });
        }

    } catch (error) {
        res.send({
            message: "Password Changed Unsuccessfully",
            status: 200,
        });
    }
}

// exports
module.exports = {
    UserLogin,
    UserRegisteration,
    VerifyEmail,
    OtpInsertion,
    OtpCheck,
    resetPass,
    changePass
};

