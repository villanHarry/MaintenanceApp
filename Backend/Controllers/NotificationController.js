// Description: This file contains all the functions related to notifications
// package imports
const Notification = require('../Models/NotificationModel.js')

const getNotification = async (req, res) => {
    try {
        const model = await Notification.find({ user: req.id }).sort({ 'createdAt': -1 });
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
    } catch (error) {
        res.send({
            message: "Data not Found",
            status: 404,
        });
    }
}

module.exports = { getNotification };