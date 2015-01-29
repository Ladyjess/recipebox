require("spec_helper")

describe(Recipe) do

 it { should have_many(:ingredients) }

 it { should have_many(:instructions) }

end
