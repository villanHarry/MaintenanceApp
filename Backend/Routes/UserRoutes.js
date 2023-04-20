// packages
const router = require('express').Router();
const Auth = require('../Constants/Authentication');
const { UserLogin, UserRegisteration, OtpInsertion, OtpCheck, resetPass, changePass } = require('../Controllers/UserControllers');

// routes
router.get('/login', UserLogin);
router.post('/signup', UserRegisteration);
router.post('/forgotpassword', OtpInsertion);
router.get('/verify', OtpCheck);
router.post('/resetPass', resetPass);
router.post('/changePass', Auth, changePass);

// exports
module.exports = router;