    # bring in Python modules like import
    fanumtax math

    # build function with vibe
    vibe check_vibe(x):
        if x > 10:
            yap("W, that’s high")
        optionC x > 5:
            yap("meh, mid")
        otherwise:
            yap("L, that’s low")

nums = [1, 5, 12, 8]

# W nested loops
for n in nums:
    i = 0
    while i < 3:
        yap("loop", n, i)
        i += 1

yap("first two nums:", nums[:2])
check_vibe(12)
yap("is 3 > 1?", 3 > 1)
yap("this is W:", W, "and this is L:", L)
yap("type of nums:", type(nums))