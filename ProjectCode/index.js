const express = require('express');
const app = express();
const pgp = require('pg-promise')();
const bodyParser = require('body-parser');
const session = require('express-session');
const bcrypt = require('bcrypt');


// database configuration
const dbConfig = {
    host: 'db',
    port: 5432,
    database: process.env.POSTGRES_DB,
    user: process.env.POSTGRES_USER,
    password: process.env.POSTGRES_PASSWORD,
};

const db = pgp(dbConfig);

// test your database
db.connect()
    .then(obj => {
        console.log('Database connection successful'); // you can view this message in the docker compose logs
        obj.done(); // success, release the connection;
    })
    .catch(error => {
        console.log('ERROR:', error.message || error);
    });

app.set('view engine', 'ejs');
app.use(bodyParser.json());

app.use(session({
    secret: process.env.SESSION_SECRET, saveUninitialized: false, resave: false,
}));

app.use(bodyParser.urlencoded({
    extended: true,
}));

app.listen(3000);
console.log('Server is listening on port 3000');

app.get('/', (req, res) => {
    res.redirect('/login');
});

app.get('/register', (req, res) => {
    res.render('pages/register.ejs');
});

app.get('/login', (req, res) => {
    res.render("pages/login.ejs");
});


app.post('/register', async (req, res) => {
    const hash = await bcrypt.hash(req.body.password, 10);
    const username = req.body.username;
    db.any("INSERT INTO users(username, password) VALUES($1, $2)", [username, hash])
        .then(() => {
            res.redirect("/login");
        })
        .catch(() => {
            res.redirect('/register')
        });
});

app.post('/login', async (req, res) => {
    db.any("SELECT * FROM users WHERE users.username = $1", [req.body.username])
        .then(async (user) => {
            const match = await bcrypt.compare(req.body.password, user[0].password);
            if (!match) {
                res.locals.message = "Incorrect password";
                res.locals.error = "danger";
                res.render("pages/login.ejs");
            } else {
                req.session.user = {
                    username: req.body.username,
                };
                req.session.save();
                res.redirect('/programs')
            }
        })
        .catch(() => {
            res.locals.message = "Username Not Found";
            res.locals.error = "danger";
            res.render("pages/login.ejs");
        });
});

// Authentication Middleware.
const auth = (req, res, next) => {
    if (!req.session.user) {
        // Default to register page.
        return res.redirect('/register');
    }
    next();
};

// Authentication Required
app.use(auth);

app.get('/logout', (req, res) => {
    req.session.destroy();
    res.locals.message = "Logged out Successfully";
    res.render('pages/login.ejs');
});

app.get('/programs', (req, res) => {
    const username_ = req.session.user.username;
    db.any("SELECT * FROM programs JOIN usersToPrograms ON programs.program_id = usersToPrograms.program_id WHERE usersToPrograms.username = $1", [username_] )
        .then((data) => {
            console.log("programs",data)
            res.render("pages/programs.ejs", {data:data})
        })
        .catch((err) => {
            console.log(err)
        });
});

app.get('/joinprograms', (req, res) => {
    const username_ = req.session.user.username;
    db.any("SELECT programs.program_id, program_name, password, owner_name FROM programs EXCEPT SELECT programs.program_id, program_name, password, owner_name FROM programs JOIN usersToPrograms ON programs.program_id = usersToPrograms.program_id WHERE usersToPrograms.username = $1", [username_])
        .then((data) => {
            console.log("Join programs",data)
            res.render("pages/joinprograms.ejs", {data:data})
        })
        .catch((err) => {
            console.log(err)
        });
});

app.get('/calendar', (req, res) => {
    const username_ = req.session.user.username;
    db.any("SELECT * FROM events JOIN (SELECT programs.program_id FROM programs JOIN usersToPrograms ON programs.program_id = usersToPrograms.program_id WHERE usersToPrograms.username = $1) AS x  ON x.program_id = events.program_id", [username_])
        .then((data) => {
            console.log(data)
            res.render("pages/calendar.ejs", {data:data})
        })
        .catch((err) => {
            console.log(err)
        });
});

app.post('/joinprogram', (req, res) => {
    const program_id = req.body.program_id;
    const username_ = req.session.user.username;
    db.any("INSERT INTO usersToPrograms (username, program_id) VALUES ($1, $2)", [username_,program_id])
        .then((data) => {
            console.log("Join programs join",data)
            res.redirect("/joinprograms")
        })
        .catch((err) => {
            console.log(err)
        });
});


