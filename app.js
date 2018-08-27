'use strict';

const fs = require('fs');
const path = require('path');
const crypto = require('crypto');

const text = fs.readFileSync(path.join(__dirname, 'sample.txt')).toString();

function start() {
    const spawn = require('threads').spawn;

    const thread = spawn(function (input, done) {
        // Everything we do here will be run in parallel in another execution context.
        // Remember that this function will be executed in the thread's context,
        // so you cannot reference any value of the surrounding code.
        done({ string: input.string, integer: parseInt(input.string) });
    });

    for (let i = 0; i <= 2000; i++) {
        thread
            .send({ string: '123' })
            // The handlers come here: (none of them is mandatory)
            .on('message', function (response) {
                // console.log('123 * 2 = ', response.integer * 2);
                // thread.kill();

                setInterval(() => {

                    for (let y = 0; y <= 999999; y++) {
                        let result = Math.random() * 2 / 2.2 / 2.2 / 2.2 * 1000;
                        let result1 = Math.random() * 2 / 2.2 / 2.2 / 2.2 * result;
                        let result2 = Math.random() * 2 / 2.2 / 2.2 / 2.2 * result1;
                        let result3 = Math.random() * 2 / 2.2 / 2.2 / 2.2 * result2;
                        let result4 = Math.random() * 2 / 2.2 / 2.2 / 2.2 * result3;
                        let result5 = Math.random() * 2 / 2.2 / 2.2 / 2.2 * result4;
                        let result6 = Math.random() * 2 / 2.2 / 2.2 / 2.2 * result5;
                        let result7 = Math.random() * 2 / 2.2 / 2.2 / 2.2 * result6;
                        let result8 = Math.random() * 2 / 2.2 / 2.2 / 2.2 * result7;
                        let result9 = Math.random() * 2 / 2.2 / 2.2 / 2.2 * result8;
                        let result10 = Math.random() * 2 / 2.2 / 2.2 / 2.2 * result9;

                        console.log(result10);

                        let x = text.match(/this is a match to find/i);
                        console.log(x + ' ' + Math.random());

                    }

                }, 500);

            })
            .on('error', function (error) {
                console.error('Worker errored:', error);
            })
            .on('exit', function () {
                console.log('Worker has been terminated.');
            });
    }
}

start();