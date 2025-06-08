import sys

filename = None
for arg in sys.argv:
  if ".pbm" in arg:
    filename = arg

if not filename:
  print('Specify pgm file')
  sys.exit(1)

print('Loading file %s' % filename)

with open(filename, 'r') as f:
  magic = f.readline()
  comment = f.readline()
  x_len, y_len = [int(val) for val in f.readline().split(' ')]
  data = f.read().replace('\n','')
image = []


for y in range(0, y_len):
  image.append(data[y * x_len : (y + 1) * x_len])

# A list of lines, where each line contains (pixel, count) entries that sum
# up to exactly one screen width of pixels.
rle_image = []
for line in image:
  cur = line[0]
  length = 1
  rle_line = []
  rle_image.append(rle_line)
  for pix in line[1:x_len]:
    if pix == cur:
      length += 1
    else:
      rle_line.append((length, cur))
      length = 1
      cur = pix
  rle_line.append((length, cur))

outname = filename.replace('.pbm', '.rle')

with open(outname, 'bw') as f:
  f.write(b'%d,%d\r\n' % (x_len, y_len))
  for line in rle_image:
    f.writelines(bytes('%s,%s\r\n' % entry, "UTF-8") for entry in line)

print('Wrote %s' % outname)
