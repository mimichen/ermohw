require! <[fs]>

files = (fs.readdir-sync \csv).map(->"csv/#it")
total = []
for file in files =>
  lines = fs.read-file-sync file .toString! .split \\n
  head = (lines.splice 0, 1).0
  total ++= lines
total = [head] ++ total
fs.write-file-sync \data.csv, total.join(\\n)
