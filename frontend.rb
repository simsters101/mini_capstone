require "HTTP"

website = HTTP.get("http://localhost:3000/api/products/2")

p website.parse