#!/usr/bin/env ruby

require 'bunny'

conn = Bunny.new
conn.start

begin
  ch = conn.create_channel

  # We will bind to this exchange
  logs = ch.fanout("logs")

  # Create an anonymous queue for this process
  q = ch.queue("", exclusive: true)

  # Bind this queue to the logs exchange
  q.bind(logs)

  q.subscribe(block: true) do |delivery_info, properties, body|
    puts "Received: #{body}"
  end
ensure
  conn.close
end
