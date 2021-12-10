const fs = require("fs");
const filename = "input.txt";


function part1() {
    let position = 0;
    let depth = 0;

    parseWordAndNumOfEachLine((word, n) => {
        if (word === "forward") {
            position += n;
        }

        else if (word === "down") {
            depth += n;
        }

        else if (word === "up") {
            depth -= n;
        }
    });

    console.log(`Part 1: ${position * depth}`);

    return position * depth;
}

function part2() {
    let aim = 0;
    let position = 0;
    let depth = 0;

    parseWordAndNumOfEachLine((word, n) =>{
        if (word === "down") {
            aim +=n;
        }

        else if (word === "up") {
            aim -= n;
        }

        else if (word === "forward") {
            position += n;
            depth += aim * n;
        }
    });

    console.log(`Part 2: ${position * depth}`);

    return position * depth;
}


function parseWordAndNumOfEachLine(func) {
    const lines = parseLinesOfFile();

    lines.forEach(line => {
        let [word, n] = line.split(" ");

        n = Number(n);

        func(word, n);
    });
}


function parseLinesOfFile() {
    const content = fs.readFileSync(filename, "utf-8");
    const lines = content.split("\n");

    return lines;
}


part1();
part2();
