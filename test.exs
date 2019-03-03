
defmodule TextInfo do

  def get_lines(tex) do
    line_list = tex |> String.split("\n", trim: true)
    [length(line_list), line_list]
  end

  def get_words([], word_count, words_list) do
    [word_count, words_list]
  end

  def get_words(tex, word_count, words_list) when tex !== [] do
    [head | tail] = tex
    words = head |> String.split(" ", trim: true)
    new_words_list = words ++ words_list
    count = length(words) + word_count
    get_words(tail, count, new_words_list)
  end

  def get_chars([], char_count), do: char_count

  def get_chars(tex, char_count) do
    [head | tail] = tex
    chars_so_far = String.length(head) + char_count
    get_chars(tail, chars_so_far)
  end

end

{:ok, content} = File.read("/Users/admin/Desktop/Elixir/text_file")
[lines_count, lines_list] = TextInfo.get_lines(content)
[count, words] = TextInfo.get_words(lines_list, 0, [])
chars = TextInfo.get_chars(words, 0)

IO.puts "This file contains #{lines_count} lines, #{count} words and #{chars} characters."
