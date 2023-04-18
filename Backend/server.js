const {express, app, port} = require('./Constants/Imports');


app.use(express.json());

app.listen(port, () => {
    console.log('Server is running on port 3000');
});