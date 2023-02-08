const express=require('express');
const router=express.Router();
const Note=require('./model');
router.use(express.json());
router.use(express.urlencoded({extended:false}));

//app routes
//fetch data from database
router.get('/list',async function(req,res) {
   var notes=await Note.find();
   res.json(notes);
});

//update/store data in database
router.post('/add',async function(req,res) {
await Note.deleteOne({id:req.body.id});
   const newNote=new Note({
       id:req.body.id,
       userid:req.body.userid,
       title:req.body.title,
       content:req.body.content
   });
   await newNote.save();
   const response={message:"Note added for user id "+req.body.id};
   res.json(response);
});

//deleting data from database
router.post('/delete',async function(req,res) {
   await Note.deleteOne({id:req.body.id});
   const response={message:"Note deleted for id "+req.body.id};
   res.json(response);
});

module.exports=router;