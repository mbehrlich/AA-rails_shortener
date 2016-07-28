custom_rakes :URLShortener do
  desc "Prune old URLs from non-premium users"
  task prune_urls: :environment do
    puts "Pruning old urls..."
    ShortenedUrl.prune(20)
  end
end
