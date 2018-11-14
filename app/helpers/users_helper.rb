module UsersHelper

  def on_mypage_except_column?(profile_column)
    except_list =[
      "id",
      "user_id",
      "introduce",
      "first_name",
      "last_name",
      "created_at",
      "updated_at"
    ].freeze
    return except_list.include?(profile_column)
  end

  def sns_url(column, element)
    if column.include?("facebook")
      element = "https://www.facebook.com/" + element
    elsif column.include?("linkedin")
      element = "https://www.linkedin.com/" + element + "in/"
    elsif column.include?("google")
      element = "https://plus.google.com/" + element + "/post"
    end
    element
  end

  def sns_fa(column)
    column.split("_")[0]
  end

  def user_index
    @user_index = ('A'..'Z').to_a + (0..9).to_a << "_"
  end
end
