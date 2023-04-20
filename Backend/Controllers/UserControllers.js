// Description: This file contains all the functions related to user
// package imports
const { User } = require('../Constants/Imports');
const CryptoJS = require("crypto-js");
const jwt = require("jsonwebtoken");

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
        });

        const savedUser = await newUser.save();

        res.send({
            message: "Your Data Saved Successfully",
            status: 200,
            data: savedUser,
        });
    } catch (err) {
        res.send({
            message: "Data not Saved",
            status: 404,
        });
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
            const access_token = jwt.sign(
                {
                    id: user._id,
                },
                process.env.JWT_TOKEN,
                { expiresIn: "2d" }
            );

            const { token } = user._doc;
            res.send({
                message: "Loggedin Successfully",
                status: 200,
                data: { access_token, user },

            });
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

        const otp = await User.findOneAndUpdate({ email: req.body.email }, {
            $set: {
                otp: req.body.otp
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
    OtpInsertion,
    OtpCheck,
    resetPass,
    changePass
};