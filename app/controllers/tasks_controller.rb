class TaskController < ApplicationController
  before_action :load_event, only: %i(show edit update destroy)
end
