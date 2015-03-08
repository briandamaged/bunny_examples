#!/usr/bin/env ruby

require 'bunny'

# Establish connection
conn = Bunny.new
conn.start
begin
  ch     = conn.create_channel

  # We want to broadcast our log msgs to all consumers
  logger = ch.fanout("logs")
  loop do 
    print "Message: "
    msg = gets()  # Get a message from console input

    logger.publish(msg)
  end
ensure
  # Ensure that the connection is always closed
  conn.close
end
