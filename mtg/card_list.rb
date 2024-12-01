require 'pry'
require "csv"
require 'nokogiri'
require 'open-uri'

results = []

1.upto(15) do|i|
  url = "https://scryfall.com/search?as=full&order=set&page=#{i}&q=set%3Alci&unique=cards"
  res = open(url)
  body = res.read
  html = Nokogiri::HTML.parse(body, nil, 'utf-8')
  html.search('div.card-profile').each do |node|
    if node.css('.card-image-back > img').empty?
      img_front_src = node.css('.card-image-front > img').attr('src').value
      card_name = node.css('.card-text-card-name').text.strip
      card_type = node.css('.card-text-type-line').text.strip
      mana_cost = node.css('.card-text-mana-cost').text.strip
      text = node.css('.card-text-oracle').text.strip
      rarity = node.css('.prints-current-set-details').text.strip.match(/Mythic Rare|Rare|Uncommon|Common/).to_a[0]
  
      if !node.css('.card-text-stats').empty?
        stats = node.css('.card-text-stats').text.strip.split('/')
        power = stats[0]
        toughness = stats[1]
      end
      card = {
        img: img_front_src,
        card_name: card_name,
        card_type: card_type,
        mana_cost: mana_cost,
        text: text,
        power: power,
        toughness: toughness,
        rarity: rarity
      }
      results << card
    else
      # 表
      img_front_src = node.css('.card-image-front > img').attr('src').value
      card_name = node.css('.card-text-card-name')[0].text.strip
      card_type = node.css('.card-text-type-line')[0].text.strip
      mana_cost = node.css('.card-text-mana-cost')[0].text.strip
      text = node.css('.card-text-oracle')[0].text.strip
      rarity = node.css('.prints-current-set-details').text.strip.match(/Mythic Rare|Rare|Uncommon|Common/).to_a[0]
      if !node.css('.card-text-stats').empty?
        stats = node.css('.card-text-stats').text.strip.split('/')
        power = stats[0]
        toughness = stats[1]
      end
      card = {
        img: img_front_src,
        card_name: card_name,
        card_type: card_type,
        mana_cost: mana_cost,
        text: text,
        power: power,
        toughness: toughness,
        rarity: rarity
      }
      results << card
  
      # 裏面
      img_back_src = node.css('.card-image-back > img').attr('src').value
      card_name = node.css('.card-text-card-name')[1].text.strip
      card_type = node.css('.card-text-type-line')[1].text.strip
      unless node.css('.card-text-oracle')[1].nil?
        text = node.css('.card-text-oracle')[1].text.strip
      end
      if !node.css('.card-text-stats').empty?
        stats = node.css('.card-text-stats').text.strip.split('/')
        power = stats[0]
        toughness = stats[1]
      end
      card = {
        img: img_back_src,
        card_name: card_name,
        card_type: card_type,
        mana_cost: nil,
        text: text,
        power: power,
        toughness: toughness,
        rarity: rarity
      }
      results << card
    end
  end
end

CSV.open('lci.csv','w') do |csv|
  csv << ["画像", "カード名", "カードタイプ", "マナコスト", "カードテキスト", "パワー", "タフネス", "レアリティ"]

  results.each do |card|
    csv << [
      card[:card_name],
      card[:card_type],
      card[:mana_cost],
      card[:text],
      card[:power],
      card[:toughness],
      card[:rarity],
      card[:img]
    ]
  end
end
