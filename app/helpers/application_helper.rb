module ApplicationHelper

  # Display errors matching the string error_type, or display all if nothing given
  def show_flash(error_type = "all", class_arr=[])
    unless flash.empty?
      output = "<div class=\"row\" id=\"flash-row\">"
      flash.each do |message_type, message|
        output += "<span class=\"#{class_arr.join(' ')} #{message_type}\"> #{message} </span>" if error_type == message_type or error_type == "all"
      end
      output += "</div>"
    end
    raw output
  end

  def show_error(error_type)
    show_flash(error_type, class_arr=["error"])
  end
end
