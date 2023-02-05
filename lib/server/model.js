//In this we define our schema
//notes-id,date,title,content

//initiaize mongoose 
const mongoose=require('mongoose');

const notesSchema=mongoose.Schema(
    {
        id: {
            type:String,
            unique:true
        },

        userid: {
            type:String,
            required:true
        },

        title: {
            type:String,
            required:true
        },

        content: {
            type:String,
        },

        dateAdded: {
            type:Date,
            default:Date.now
        }
    }
);

module.exports =mongoose.model('Note',notesSchema);