require! <[fs]>

convert = (file) ->
  fields = <[
    hospital_sn update_time full_reported pending_doctor 
    pending_bed pending_ward pending_icu
  ]>
  lines = fs.read-file-sync file .toString! .split \\n .filter(->it.trim!)
  csv = []
  for line in lines =>
    json = JSON.parse(line)
    csv.push fields.map(-> if json[it]!=\null => "#{json[it]}" else "").join(\,)
  csv = [fields.join(\,)] ++ csv
  return csv.join(\\n)

#output = convert \sample.json
#fs.write-file-sync \output.csv, output

files = fs.readdir-sync(\backup).map(->"backup/#it")
for file in files =>
  try
    output = convert file
  catch e
    console.log "parse file #file failed. " 
    continue
  fs.write-file-sync "#{file.replace(/backup/, 'csv')}.csv", output
