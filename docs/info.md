<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## What it does

Reads a rotary (incremental) encoder: https://en.wikipedia.org/wiki/Incremental_encoder

The a and b signals are first debounced.

The encoder counts from 0 to 255.

## Register map

Document the registers that are used to interact with your peripheral

| Address | Name  | Access | Description                                                         |
|---------|-------|--------|---------------------------------------------------------------------|
| 0x00    | DATA  | R      | Value of Encoder 0                                                  |
| 0x01    | DATA  | R      | Value of Encoder 1                                                  |
| 0x02    | DATA  | R      | Value of Encoder 2                                                  |
| 0x03    | DATA  | R      | Value of Encoder 3                                                  |
| 0x04    | DATA  | R/W    | Debounce frequency. Will be left shifted by 4                       |

## How to test

Connect an incremental encoder to the input ports (see pin mapping).

Use the test firmware to read the value of the encoder and print it out.

## External hardware

Rotary incremental encoders.
