class Order < ApplicationRecord
  include Statesman::Adapters::ActiveRecordQueries
  belongs_to :shipping_type
  belongs_to :user
  has_many :line_items
  has_one :address
  has_many :transitions, class_name: "OrderTransition", autosave: false

  accepts_nested_attributes_for :address

  delegate :can_transition_to?, :transition_to!, :transition_to, :current_state,
           to: :state_machine
  # :nocov:
  def state_machine
    @state_machine ||= OrderStateMachine.new(self, transition_class: OrderTransition,
                                                   association_name: :transitions)
  end
  # :nocov:
  def full_cost
    line_items.map { |e| e.full_price }.sum + shipping_cost
  end
  # :nocov:
  def self.transition_class
    OrderTransition
  end

  def self.initial_state
    OrderStateMachine.initial_state
  end

  def self.transition_name
    :transitions
  end
  # :nocov:
end
