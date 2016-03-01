do

function run(msg, matches)
  return 'pixels Bot '.. VERSION .. [[ 
  Checkout v0.1 license.]]
end

return {
  description = "Shows bot version", 
  usage = "version: Shows bot version",
  patterns = {
    "^[!/#$&@ ]version$"
  }, 
  run = run 
}

end
