// import mongoose and validator
const mongoose = require("mongoose");

//Schema
const NotificationSchema = new mongoose.Schema(
    {
        title: {
            type: String,
            required: true,
        },
        des: {
            type: String,
            required: true
        },
        user: {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'User',
            required: true
        }

    },
    { timestamps: true }
);

//exports
module.exports = mongoose.model("Notification", NotificationSchema);
