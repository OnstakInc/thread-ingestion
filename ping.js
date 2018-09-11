const exec = require('child_process').exec;
const testscript = exec('sh test.sh');

testscript.stdout.on('data', function(data){
    console.log(data);
    // sendBackInfo();
});

testscript.stderr.on('data', function(data){
    console.log(data);
    // triggerErrorStuff();
});
