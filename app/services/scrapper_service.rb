require 'watir'

class ScrapperService
  def initialize(url)
    @url = url
  end

  def scrape_and_save
    browser = nil
    begin
      browser = Watir::Browser.new(:chrome)

      browser.goto(@url)

      browser.wait_until(timeout: 30) do
        browser.div(class: /sBVJqn/).exist? &&
        browser.h1(class: /_6EBuvT/).exist?
      end

      title = browser.h1(class: '_6EBuvT').span(class: 'mEh187').text rescue ""
      description = browser.h1(class: '_6EBuvT').span(class: 'VU-ZEz').text rescue ""
      discounted_price = browser.div(class: 'Nx9bqj CxhGGd').text rescue ""
      normal_price = browser.div(class: 'yRaY8j A6+E6v').text rescue ""
      discount = browser.div(class: 'UkUFwK WW8yVX dB67CR').text rescue ""
      raitings_average = browser.div(class: 'XQDdHH _1Quie7').text.to_f rescue 0.0
      raitings_reviews = browser.div(class: "_5OesEi HDvrBb VWRXZO").span(class: "Wphh3N").text rescue ""
      size_tag = browser.a(class: "CDDksN zmLe5G dpZEpc").text rescue ""
      image_links = browser.ul(class: 'ZqtVYK').lis.map do |li|
        li.img(class: '_0DkuPH').src rescue nil
      end.compact

      browser.close

      product_data ={
        title: title,
        description: description,
        size: size_tag,
        price: normal_price,
        discounted_price: discounted_price,
        discount: discount,
        raitings_reviews: raitings_reviews,
        raitings_average: raitings_average,
        image_links: image_links
      }
      puts product_data
      product_data
    rescue => e
      puts "Error al procesar: #{e.message}"
    end
  end
end