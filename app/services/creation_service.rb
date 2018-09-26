class CreationService
  def initialize(resource)
    @resource = resource
  end

  def perform(params)
    resource.assign_attributes(params)
    resource.save
  end

  private

  attr_reader :resource
end
