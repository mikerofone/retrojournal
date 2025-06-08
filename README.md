# retrojournal

Guestbook software targeting 8088 class machines and up, written in
Microsoft QuickBasic 3.0.

Shows a slideshow of images, which users can interrupt to leave
messages that are then persisted to disk.

## Requirements

*	[Microsoft QuickBasic
	3.0](https://winworldpc.com/product/quickbasic/3x) to run or compile
	to `.EXE`
*	MS DOS bootdisk to boot the target hardware from. Tested using
	IBM and MS DOS 3.3.
*	CGA video

## Usage

_TODO: Include runnable example._

This will not run as-is. B&W RLE-encoded .PBM images (created e.g. with
[GIMP](https://www.gimp.org)) need to be preprocessed with IMG2BIN.BAS
and linked by filename in the code.

## Caveats

This is the result of a hasty overnighter so it'd be ready for a party
in early 2017. I learned QuickBasic 3.0 as I went, so expect
poor-quality code. ;) While this has been successfully used at a
multiple events since then and the most egregious message-eating bugs
have been ironed out, there are likely more. Use at your own risk.

This code was not written with the intention of being published or
reused by others, so (as of writing) a lot of stuff is hardcoded.
