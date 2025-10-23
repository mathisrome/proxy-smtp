const net = require('net');

exports.hook_queue = async function (next, connection) {
    const txn = connection.transaction;

    const mailpitHost = 'mailpit';
    const mailpitPort = 1025;

    const mailcatcherHost = 'mailcatcher';
    const mailcatcherPort = 1025;

    // On teste si Mailpit est joignable
    const checkSMTP = (host, port) => {
        return new Promise((resolve) => {
            const socket = net.connect(port, host, () => {
                socket.end();
                resolve(true);
            });
            socket.on('error', () => {
                resolve(false);
            });
        });
    };

    const mailpitAvailable = await checkSMTP(mailpitHost, mailpitPort);

    if (mailpitAvailable) {
        txn.notes.smtp_forward = {
            host: mailpitHost,
            port: mailpitPort,
        };
    } else {
        txn.notes.smtp_forward = {
            host: mailcatcherHost,
            port: mailcatcherPort,
        };
    }

    // Laisse le plugin smtp_forward s'occuper de la suite
    return next();
};
