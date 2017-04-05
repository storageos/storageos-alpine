module Randomize

  def cachefile
    "name_rand.txt"
  end

  # Generate 5 random digits or read from cache file.
  def digits
    unless File.exist?(cachefile)
      cache = File.open(cachefile, "w")
      cache.puts(gen)
      cache.close
    end

    cache = File.open(cachefile, "r")
    digits = cache.readline.strip
    cache.close
    digits
  end

  def gen
    rand(1..99999).to_s.rjust(5,"0")
  end

end
