// Description: This file contains all the functions related to maintenance
// package imports
const Maintenance = require('../Models/MaintenanceModel.js')
const User = require('../Models/UserModel.js')
const Notification = require('../Models/NotificationModel.js')

/** 
 * @description: This function is used to add a new maintenance request  
 */
const AddMaintenance = async (req, res) => {
    try {
        const admin = await User.findOne({ usertype: "admin" });
        const user = await User.findById(req.id);
        const newMaintenance = new Maintenance({
            msg: req.body.msg,
            status: 'Pending',
            category: req.body.category,
            user: req.id
        });

        const userSide = Notification({
            title: "Maintenance Added",
            des: `Your maintenance about ${req.body.category} has been added`,
            user: req.id
        });

        const adminSide = Notification({
            title: "Maintenance Requested",
            des: `Maintenance about ${req.body.category} requested by ${user.username}`,
            user: admin.id
        });

        const savedMaintenance = await newMaintenance.save()
        const notify1 = await userSide.save();
        const notify2 = await adminSide.save();

        if (notify1 && notify2) {
            res.send({
                message: "Your Data Saved Successfully",
                status: 200,
                data: savedMaintenance,
            });
        }
    } catch (error) {
        res.send({
            message: "Data not Saved",
            status: 404,
        });
    }
}

/** 
 * @description: This function is used to get all maintenance request for admin
 */
const getMaintenanceForAdmin = async (req, res) => {
    try {
        const user = await User.findById(req.id);
        if (user) {
            if (user.usertype === 'admin') {
                const model = await Maintenance.find({
                    status: req.body.status
                }).populate({ path: 'user', select: '_id username image contactNumber floorNumber' });

                if (model) {
                    res.send({
                        message: "Data Found",
                        status: 200,
                        data: model,
                    });
                } else {
                    res.send({
                        message: "Data not Found",
                        status: 404,
                    });
                }
            }
            else {
                res.send({
                    message: "You are not an admin",
                    status: 404,
                });
            }
        } else {
            res.send({
                message: "Data not Found",
                status: 404,
            });
        }
    } catch (error) {
        res.send({
            message: "Data not Found",
            status: 404,
        });
    }
}

/** 
 * @description: This function is used to get all maintenance request for user
 */
const getMaintenanceForUser = async (req, res) => {

    const model = await Maintenance.find({ user: req.id });
    if (model) {
        res.send({
            message: "Data Found",
            status: 200,
            data: model,
        });
    } else {
        res.send({
            message: "Data not Found",
            status: 404,
        });
    }
}

/** 
 * @description: This function is used to edit maintenance request for user
 */
const editMaintenance = async (req, res) => {
    try {
        const user = await User.findById(req.id);
        if (user) {
            if (user.usertype === 'admin') {
                const model = await Maintenance.findByIdAndUpdate(req.body.id, { status: req.body.status });
                if (model) {
                    const reqUser = await User.findbyId(model.user);

                    const userSide = Notification({
                        title: "Maintenance Updated",
                        des: `Your maintenance about ${model.category} has been updated by admin`,
                        user: reqUser.id
                    });

                    const adminSide = Notification({
                        title: "Maintenance Updated",
                        des: `Maintenance about ${model.category} has been updated`,
                        user: req.id
                    })
                    const notify1 = await userSide.save();
                    const notify2 = await adminSide.save();
                    if (notify1 && notify2) {
                        res.send({
                            message: "Data Updated",
                            status: 200,
                        });
                    }
                } else {
                    res.send({
                        message: "Data not Updated",
                        status: 404,
                    });
                }
            }
            else {
                res.send({
                    message: "You are not an admin",
                    status: 404,
                });
            }
        } else {
            res.send({
                message: "Data not Updated",
                status: 404,
            });
        }
    } catch (error) {
        res.send({
            message: "Data not Updated",
            status: 404,
        });
    }
}

// exports
module.exports = {
    AddMaintenance,
    getMaintenanceForAdmin,
    getMaintenanceForUser,
    editMaintenance
}