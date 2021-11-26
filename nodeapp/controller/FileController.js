const fs = require('fs');

class FileController {

    constructor(express){
        this.router = express.Router();
    }

    init(){

        this.router.post('/',(req,res) => {            
            if (req.body){
                fs.appendFile('/app/msg.txt',req.body.message,(err) => {
                    if (err)
                    {
                        console.log(err);
                        res.status(500);
                        res.send('Internal server error');
                        return;
                    }
                    res.status(200);
                    res.send('Mesage written');                        
                });
            } else {
                res.status(400);
                res.send('Bad request');
            }
        });

        return this.router;
    }
}