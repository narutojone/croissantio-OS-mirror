class ErrorsController < ApplicationController
  def show
    @status_code = env["PATH_INFO"][1..-1] || "500"
    flash["alert"] = "Status #{@status_code}"
    render "show", status: @status_code
  end
end
