class TestFormsController < ApplicationController
  def new
    @test_form = TestForm.new
  end

  def create
    @test_form = TestForm.new(test_form_params)

    if @test_form.save
      respond_to(&:turbo_stream)
    else
      render :new
    end
  end

  private

  def test_form_params
    params.require(:test_form).permit(:name)
  end
end
