// constants
const { express, app, port, server, cors, database } = require('./Constants/Imports');

// constants
app.use(express.json());
app.use(cors());

// routes
app.use('/user/api/', require('./Routes/UserRoutes'));
app.use('/mntnc/api/', require('./Routes/MaintenanceRoutes'));

// database connection
database();

// server listen
server.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});