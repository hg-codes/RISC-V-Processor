import fs from 'fs';
import { Instruction } from './core/Instruction.js';

const inputFile = process.argv[2] || 'input.txt';
const outputFile = process.argv[3] || 'output.txt';

const lines = fs.readFileSync(inputFile, 'utf-8').split('\n');

let labels = {};
let cleanLines = [];

// First pass: collect labels and count real instructions
let instIndex = 0;
lines.forEach((line, i) => {
  const raw = line.split('#')[0].trim();
  if (!raw) return;

  if (raw.endsWith(':')) {
    const label = raw.slice(0, -1);
    labels[label] = instIndex;
  } else {
    cleanLines.push({ line: raw, originalLine: i });
    instIndex++;
  }
});

// Second pass: replace labels and encode
const output = [];

cleanLines.forEach(({ line: original, originalLine }, instLine) => {
  let line = original;

  const match = line.match(/^\s*(beq|bne|blt|bge|bltu|bgeu)\s+([^,]+),\s*([^,]+),\s*(\w+)$/);
  if (match) {
    const [_, opcode, rs1, rs2, label] = match;
    if (!(label in labels)) {
      console.error(`Unknown label "${label}" on line ${originalLine + 1}`);
      return;
    }
    const offset = (labels[label] - instLine) * 4;
    line = `${opcode} ${rs1}, ${rs2}, ${offset}`;
  }

  try {
    const inst = new Instruction(line);
    const binStr = inst.bin; // 32-bit binary string
    const hexStr = parseInt(binStr, 2).toString(16).padStart(8, '0');

    // Choose one of the below:
    output.push(binStr);      // binary format
    // output.push(hexStr);   // hex format

  } catch (err) {
    console.error(`Error at line ${originalLine + 1}: ${line} → ${err.message}`);
  }
});

fs.writeFileSync(outputFile, output.join('\n') + '\n');
console.log(`Wrote ${output.length} instructions to ${outputFile}`);

