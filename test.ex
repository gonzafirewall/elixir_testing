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
        #do_conditionals()
        #do_case()
        #do_tuples_stuff()
        #do_lists_stuff()
        #do_maps_stuff()
        #do_pattern_match()
        #do_anon_func
        #do_recursion()
        #do_enum_stuff()
        #do_list_comprehension()
        #do_exception_handling()
        do_proc_stuff()
    end

    def do_proc_stuff do
        spawn(fn() -> loop(50, 1) end)
        spawn(fn() -> loop(100, 50) end)

        send(self(), {:french, "Bob"})

        receive do
            {:french, name} -> IO.puts "Bonjour #{name}"
            {:german, name} -> IO.puts "Guten tag #{name}"
            {:english, name} -> IO.puts "Hello #{name}"
        after
            500 -> IO.puts "Time up"
        end
        
    end

    def do_exception_handling do
        
        err = try do
            5 / 0
        rescue
            ArithmeticError -> "Can't divide by zero"
        end

        IO.puts err
    end

    def do_list_comprehension do
        dbl_list = for n <- [1,2,3], do: n * 2
        IO.inspect dbl_list

        even_list = for n <- [1,2,3,4], rem(n, 2) == 0, do: n
        IO.inspect even_list
    end

    def do_enum_stuff do
        display_sep "Even list #{Enum.all?([1,2,3,4], 
        fn(n) -> rem(n, 2) == 0 end)}"
        display_sep "Even list #{Enum.any?([1,2,3,4], 
        fn(n) -> rem(n, 2) == 0 end)}"

        Enum.each([1,2,3], fn(n) -> display_sep(n) end)

        dbl_list = Enum.map([1,2,3,4], fn(n) -> n * 2 end)
        display_sep(&IO.inspect/1, dbl_list)

        sum_vals = Enum.reduce([4,3,2,1], fn(n, acc) -> n + acc end)
        display_sep "Sum: #{sum_vals}"

        IO.inspect Enum.uniq([1,2,1]) 
    end

    def do_recursion do
        display_sep "Factorial of 4: #{factorial(4)}"
        display_sep "Sum : #{sum([1,2,3])}"

        loop(5, 1)
    end

    def loop(0, _), do: nil
    def loop(max, min) do
        if max < min do
            loop(0, min)
        else
            IO.puts "Num : #{max}"
            loop(max - 1, min)
        end
    end

    def sum([]), do: 0
    def sum([h|t]), do: h + sum(t)

    def factorial(num) do
        if num <= 1 do
            1
        else 
            result = num * factorial(num - 1)
            result
        end    
    end

    def do_anon_func do
        get_sum = fn (x, y) -> x + y end
        display_sep "5 + 5 = #{get_sum.(5,5)}"
        get_less = &(&1 - &2)
        display_sep "7 - 5 = #{get_less.(7,6)}"
        add_sum = fn
            {x, y} -> display_sep "#{x} + #{y} = #{x + y}"
            {x, y, z} -> display_sep "#{x} + #{y} + #{z} = #{x + y + z}"
        end
        add_sum.({1,2})
        add_sum.({1,2,3})
        # default values
        display_sep "Default value test: #{do_it()}"
    end

    def do_it(x \\ 1, y \\ 2) do
        x + y
    end

    def do_pattern_match do
        [length, width] = [10, 20]
        display_sep("Widht is: #{width}")
        [_, [_, a]] = [10, [20, 30]]
        display_sep("Get num: #{a}")
    end
    def do_maps_stuff do
        capitals = %{"Alabama" => "Montgomery",
                     "Alaska" => "Juneau",
                     "Arizona" => "Phoenix"}

        display_sep("Capital of Alaska: #{capitals["Alaska"]}")
        capitals2 = %{alabama: "Montgomery",
                     alaska: "Juneau",
                     arizona: "Phoenix"}

        display_sep("Capital of Arizona: #{capitals2.arizona}")

        capitals3 = Dict.put_new(capitals, "Arkansas", "Little Rock")

    end

    def display_sep(display_func, text) do
        display_func.(text)
        IO.puts "---------"
    end

    def display_sep(text) do
        IO.puts text
        IO.puts "---------"
    end

    def do_lists_stuff do
        list1 = [1,2,3]
        list2 = [4,5,6]
        list3 = list1 ++ list2
        list4 = list3 -- list1
        display_sep 6 in list4
        [head | tail] = list3
        display_sep "Head is: #{head}"
        IO.write "Tail: "
        IO.inspect tail
        IO.puts "---------"
        # print chars
        display_sep(&IO.inspect/1,[97, 98])
        # Print as lists
        IO.inspect [97, 98], charlists: :as_lists
        IO.puts "---------"
        Enum.each tail, fn item ->
            IO.puts item
        end 
        IO.puts "---------"
        words = ["Random", "words", "in a", "list"]
        Enum.each words, fn word ->
            IO.puts word
        end
        IO.puts "---------"
        display_list(words)
        IO.puts "---------"

        IO.puts display_list(List.delete(words, "Random"))
        IO.puts "---------"
        IO.puts display_list(List.delete_at(words, 1))
        IO.puts "---------"
        IO.puts display_list(List.insert_at(words, 4, "Prueba"))
        IO.puts "---------"
        IO.puts List.first(words)
        IO.puts List.last(words)

        my_stats = [name: "Gonza", age: 31]
    end



    def display_list([word|words]) do
        IO.puts word
        display_list(words)
    end
    def display_list([]), do: nil

    def do_tuples_stuff do
        my_stats = {174, 85, :Gonza}
        IO.puts "Tuple #{is_tuple(my_stats)}"
        my_stats2 = Tuple.append(my_stats, 31)
        IO.puts "Age #{elem(my_stats2, 3)}"
        IO.puts "Tuple size #{tuple_size(my_stats2)}"
        my_stats3 = Tuple.delete_at(my_stats2, 0)
        my_stats4 = Tuple.insert_at(my_stats3, 0, 1988)
        many_zeroes = Tuple.duplicate(0, 5)
        {peso, altura, nombre} = {85, 1.73, "Gonza"}
        IO.puts "peso: #{peso}"
    end

    def do_case do
        age = 16
        case 2 do
            1 -> IO.puts "Entered one"
            2 -> IO.puts "Entered two"
            _ -> IO.puts "Default"
        end

        IO.puts "Ternary #{if age >= 16, do: "Can vote", else: "Cant Vote"}"
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

