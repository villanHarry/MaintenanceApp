// Description: This file contains all the functions related to maintenance
// package imports
const Maintenance = require('../Models/MaintenanceModel.js')
const User = require('../Models/UserModel.js')

/** 
 * @description: This function is used to add a new maintenance request  
 */
const AddMaintenance = async (req, res) => {
    try {
        const newMaintenance = new Maintenance({
            msg: req.body.msg,
            status: 'Pending',
            user: req.id
        })

        const savedMaintenance = await newMaintenance.save()

        res.send({
            message: "Your Data Saved Successfully",
            status: 200,
            data: savedMaintenance,
        });
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
                const model = await Maintenance.find().populate({ path: 'user', select: '_id username image' });

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
                    res.send({
                        message: "Data Updated",
                        status: 200,
                    });
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