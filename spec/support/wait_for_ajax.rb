# /spec/support/wait_for_ajax.rb
module WaitForAjax
  def wait_for_ajax
    Timeout.timeout(Capybara.default_wait_time) do
      sleep 1 until finished_all_ajax_requests?
    end
  end

  def finished_all_ajax_requests?
    puts execute_script("return 'true';").red
    # TODO: fix me!!
    true # .to_i.zero?
    # return $.active;
    # page.execute_script('jQuery.active').zero?
  end
end
