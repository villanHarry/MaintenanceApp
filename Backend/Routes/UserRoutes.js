// packages
const router = require('express').Router();
const Auth = require('../Middleware/Authentication');
const { sendingOTP } = require('../Middleware/sendEmail')
const { UserLogin, UserRegisteration, OtpInsertion, OtpCheck, resetPass, changePass, VerifyEmail } = require('../Controllers/UserControllers');
const { getNotification } = require('../Controllers/NotificationController');

// routes
router.get('/login', UserLogin);
router.post('/signup', UserRegisteration);
router.post('/forgotpassword', sendingOTP, OtpInsertion);
router.get('/verify', OtpCheck);
router.get('/verify/:id', VerifyEmail);
router.post('/resetPass', resetPass);
router.post('/changePass', Auth, changePass);
router.get('/getNotification', Auth, getNotification);

// exports
module.exports = router;