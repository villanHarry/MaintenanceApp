// import mongoose and validator
const mongoose = require("mongoose");
const validator = require("validator/lib/isEmail");

//Schema
const MaintenanceSchema = new mongoose.Schema(
    {
        msg: {
            type: String,
            required: true,
        },
        category: {
            type: String,
            required: true
        },
        image: {
            type: String,
            required: false
        },
        preferredDate: {
            type: Date,
            required: true
        },
        preferredSlot: {
            type: String,
            required: true
        },
        status: {
            type: String,
            enum: ['Pending', 'Processing', 'Completed'],
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
module.exports = mongoose.model("Maintenance", MaintenanceSchema);
