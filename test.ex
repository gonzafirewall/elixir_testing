defmodule M do
    def main do
        name = IO.gets "What is your name?: " |> String.trim
        IO.puts "Hello #{name}"
        data_stuff()
    end

    def main2 do
        data_stuff()
    end

    def data_stuff do
        my_int = 123
        IO.puts "Integer: #{is_integer(my_int)}"
        my_float = 3.14159
        IO.puts "Float: #{is_float(my_float)}"
        IO.puts "Atom: #{is_atom(:name)}"
        one_to_ten = 1..10
    end 

    def main3 do
        #do_str_stuff()
        #do_math_stuff()
        #do_compare()
        do_conditionals()
    end

    def do_conditionals do
        age = 16
        IO.puts "Vote & Drive: #{(age >= 16) and (age >= 18)}"
        IO.puts "Vote or Drive: #{(age >= 16) or (age >= 18)}"
        IO.puts not true

        if age >= 18 do
            IO.puts "Can vote"
        else
            IO.puts "Can't vote"
        end

        unless age === 18 do
            IO.puts "You're not 18"
        else
            IO.puts "You are 18"
        end

        cond do
            age >= 18 -> IO.puts "You can vote"
            age >= 16 -> IO.puts "You can drive"
            age >= 14 -> IO.puts "You can wait"
            true -> IO.puts "Default"
        end
    end

    def do_compare do
        IO.puts "4 == 4.0 : #{4 == 4.0}"
        IO.puts "4 === 4.0 : #{4 === 4.0}"
        IO.puts "4 != 4.0 : #{4 != 4.0}"
        IO.puts "4 !== 4.0 : #{4 !== 4.0}"
        IO.puts "5 > 4 : #{5 > 4}"
        IO.puts "5 >= 4 : #{5 >= 4}"
        IO.puts "5 < 4 : #{5 < 4}"
        IO.puts "5 <= 4 : #{5 <= 4}"
    end

    def do_math_stuff do
        IO.puts "5 + 4 #{5+4}"
        IO.puts "5 - 4 #{5-4}"
        IO.puts "5 * 4 #{5*4}"
        IO.puts "5 / 4 #{5/4}"
        IO.puts "5 div 4 #{div(5,4)}"
        IO.puts "5 rem 4 #{rem(5,4)}"
    end 

    def do_str_stuff do
        my_str = "Mi prueba loca"
        IO.puts "Length: #{String.length(my_str)}"
        longer_str = my_str <> " " <>"concatenando"
        IO.puts "Concatenado: #{longer_str}"
        IO.puts "Equal: #{"Egg" === "egg"}"
        IO.puts "Contains: #{String.contains?(my_str, "prue")}"
        IO.puts "First: #{String.first(my_str)}"
        IO.puts "Index 4: #{String.at(my_str, 4)}"
        IO.puts "Substring: #{String.slice(my_str, 3, 5)}"
        IO.inspect String.split longer_str
        IO.puts String.reverse longer_str
        IO.puts String.upcase longer_str
        IO.puts String.downcase longer_str
        IO.puts String.capitalize longer_str

        # piping
        4 * 10 |> IO.puts
    end
end

