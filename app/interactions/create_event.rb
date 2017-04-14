class CreateEvent
  include Interactor

  def call
    return if valid_event? && create_event
    context.fail!(errors: context.errors)
  end

  private

  def valid_event?
    return true unless validator

    result = validator.call(context.to_h)
    result.success?.tap do |success|
      context.errors = result.errors unless success
    end
  end

  def validator
    "Validate#{event.category}".safe_constantize
  end

  def event
    context.event
  end

  def create_event
    context.errors = event.errors&.messages unless event.valid?
    event.save
  end
end
