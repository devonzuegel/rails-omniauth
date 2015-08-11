# /spec/support/wait_for_ajax.rb
module WaitForAjax
  def wait_for_ajax
    # until find('#jquery-loaded').text == 'jQuery loaded!'
    #     sleep 1
    # end
    # Timeout.timeout(Capybara.default_wait_time) do
    # end
    # sleep 1 until page.evaluate_script('$.active') == 0
    # until page.evaluate_script('$("#jquery-loaded");')
    #   puts '---------------------------------------------------'.black
    #   ap page.evaluate_script('$("#jquery-loaded");')
    #   puts '---------------------------------------------------'.black
    #   sleep 1
    # end
  end

  def finished_all_ajax_requests?
    # puts page.body
    # puts "\n\n#{page.evaluate_script('jQuery.active')}\n\n".red
    # expect(page).to have_selector('#jquery-loaded')
    # find('div', text: 'jQuery loaded!')
    # puts execute_script("return 'true';").red
    # TODO: fix me!!
    # .to_i.zero?
    # return $.active;
    # page.execute_script('jQuery.active').zero?
  end
end
