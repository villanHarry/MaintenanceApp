// packages
const router = require('express').Router();
const Auth = require('../Middleware/Authentication');
const { AddMaintenance, getMaintenanceForAdmin, getMaintenanceForUser, editMaintenance } = require('../Controllers/MaintenanceControllers');

// routes
router.post('/add', Auth, AddMaintenance);
router.get('/GetAdmin', Auth, getMaintenanceForAdmin);
router.get('/GetUser', Auth, getMaintenanceForUser);
router.get('/edit', Auth, editMaintenance);

// exports
module.exports = router;