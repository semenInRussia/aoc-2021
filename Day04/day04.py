from pprint import pprint
from collections import namedtuple

filename = "input.txt"
BOARD_SELECTED_CELL = -1

ParsedResult = namedtuple("ParsedResult", ["nums", "boards"])

with open(filename) as f:
    content = f.read()


def part1():
    parsed = parse(content)
    boards = parsed.boards
    nums = parsed.nums

    for num in nums:
        print(num)
        boards = mark_num_in_boards(boards, num)

        if board := any_board_won(boards):
            return sum_not_marked_cells_in_board(board) * num


def mark_num_in_boards(boards, num):
    return list(map(lambda board: mark_num_in_one_board(board, num), boards))


def mark_num_in_one_board(board, num):
    result = []

    for row in board:
        result_row = []

        for actual_num in row:
            if actual_num == num:
                result_row.append(BOARD_SELECTED_CELL)
            else:
                result_row.append(actual_num)

        result.append(result_row)

    return result


def print_some_boards(boards):
    for board in boards:
        print_board(board)


def print_board(board):
    for row in board:
        for num in row:
            if num == BOARD_SELECTED_CELL:
                print("[  ]", end="")
            else:
                print(" {:2} ".format(num), end="")
        print()
    print()


def any_board_won(boards):
    for board in boards:
        if is_board_won(board):
            return board

    return False


def is_board_won(board):
    won_on_horizontal = any(map(is_row_won, board))
    won_on_vertical = any(map(is_row_won, transpose(board)))

    return won_on_vertical or won_on_horizontal


def is_row_won(row):
    return row.count(BOARD_SELECTED_CELL) >= len(row)


def transpose(arr):
    return list(map(list, zip(*arr)))


def sum_not_marked_cells_in_board(board):
    result = 0

    for row in board:
        for num in row:
            if num != BOARD_SELECTED_CELL:
                result += num

    return result


def parse(string):
    nums, *boards = string.split("\n\n") # Empty lines
    parsed_nums = list(map(int, nums.split(",")))
    parsed_boards = list(map(parse_board, boards))

    return ParsedResult(
        boards=parsed_boards,
        nums=parsed_nums
    )


def parse_board(string):
    rows = map(parse_board_row, string.split("\n"))
    return list(filter(bool, rows))


def parse_board_row(string):
    return list(map(int, string.split()))


def part2():
    parsed = parse(content)
    boards = parsed.boards
    nums = parsed.nums

    for num in nums:
        boards = mark_num_in_boards(boards, num)

        for board_index, board in enumerate(boards):
            if is_board_won(board) and len(boards) == 1:
                return sum_not_marked_cells_in_board(board) * num
            elif is_board_won(board):
                boards.pop(board_index)


if __name__ == '__main__':
    print(part2())
    # print_some_boards(parse(content).boards)
