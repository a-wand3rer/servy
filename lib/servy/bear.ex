defmodule Servy.Bear do
  defstruct id: nil, name: "", type: "", hibernating: false

  def list do
    [
      %__MODULE__{id: 1, name: "Scarface", type: "Brown", hibernating: true},
      %__MODULE__{id: 2, name: "White lord", type: "Polar", hibernating: false},
      %__MODULE__{id: 3, name: "Red bump", type: "Brown", hibernating: true},
      %__MODULE__{id: 4, name: "Yellow lion", type: "Black", hibernating: false},
      %__MODULE__{id: 5, name: "Smiling killer", type: "Polar", hibernating: false},
      %__MODULE__{id: 6, name: "Panda boo", type: "Panda", hibernating: true}
    ]
  end

  def is_hibernating(bear) do
    bear.hibernating == true
  end

  def sort_by_id_asc(bear1, bear2) do
    bear1.id <= bear2.id
  end

  def sort_by_name_asc(bear1, bear2) do
    bear1.name <= bear2.name
  end
end
