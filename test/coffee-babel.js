var fs = require('fs');
var coffee = require("coffeescript");
var babel = require("babel-core");

require.extensions['.coffee'] = function(module, filename) {
    var content = fs.readFileSync(filename, 'utf8');
    var compiled = coffee.compile(content, {bare: true});
    compiled = babel.transform(compiled, {presets:["env"]}).code;
    return module._compile(compiled, filename); // module._compile is not mentioned in the Node docs, what is it? And why is it private-ish?
};
