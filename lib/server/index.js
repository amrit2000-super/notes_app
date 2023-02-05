//Initialization of express and mongoose
const express=require('express');
const mongoose=require('mongoose');
const bodyParser=require('body-parser');
const Note=require('./model');
const app=express();
const router=require('./routes');
const PORT=process.env.PORT || 5000;
app.use(bodyParser.urlencoded({extended:false}));
app.use(bodyParser.json());

//connectiong to mongodb server
const database=module.exports = () => {
    const connectionParams = {
        useNewUrlParser : true,
        useUnifiedTopology : true,
    }

    try {
        mongoose.connect('mongodb+srv://amritanshu2000:imGTL444TPB7U3jO@cluster0.qvfskdd.mongodb.net/?retryWrites=true&w=majority',connectionParams)
        .then(function() {

            console.log('database connected');
            app.use("/notes",router);
        });        
    } catch (error) {
        console.log('database not connected');
        
    }
}

//calling that function
database();

//starting the server on a port
app.listen(PORT,function() {
    console.log("Server started at port "+PORT);
});