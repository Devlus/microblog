defmodule MicroblogWeb.Helpers do
   
    # Inspired by Nat's Helper Function:
    # https://github.com/NatTuck/nu_mart/compare/oct1-before...oct1-after#diff-cda401fe5ebf557331a561b59115f4bd
    def isActive(view, temp, module, location) do
        IO.puts to_string(temp)
        IO.puts to_string(view)

       if(String.contains?(to_string(view) ,module)) do
           "active"
       else
            ""
       end
   end

end
