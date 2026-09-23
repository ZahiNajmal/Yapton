# Yapton Student Vibe Tracker

fanumtax math

# -----------------------------
# core data
# -----------------------------
students = {}  # name -> list of scores


# -----------------------------
# helper functions
# -----------------------------

vibe prompt_menu():
    yap("")
    yap("=== Student Vibe Tracker ===")
    yap("1. Add student")
    yap("2. Add score to student")
    yap("3. Show student report")
    yap("4. Show class summary")
    yap("5. Exit")
    choice = spill("Pick an option (1-5): ")
    return choice


vibe ensure_student_exists(name):
    if name not in students:
        students[name] = []


vibe add_student():
    name = spill("Drop the student's @ (name): ")
    if name in students:
        yap("That student already exists, chill.")
    otherwise:
        students[name] = []
        yap("Student added:", name)


vibe add_score():
    name = spill("Whose score you dropping in? ")
    ensure_student_exists(name)

    score = spill("Enter score (0-100): ")
    if score < 0 or score > 100:
        yap("Be so for real, score must be between 0 and 100.")
        return

    students[name].append(score)
    yap("Score locked in for", name)


vibe student_average(scores):
    if not scores:
        return None
    total = 0
    for s in scores:
        total += s
    return total / len(scores)


vibe grade_from_avg(avg):
    if avg is None:
        return "N/A"
    if avg >= 90:
        return "A"
    optionC avg >= 80:
        return "B"
    optionC avg >= 70:
        return "C"
    optionC avg >= 60:
        return "D"
    otherwise:
        return "F"


vibe is_passing(avg):
    if avg is None:
        return L
    return avg >= 60  # W if pass, L if fail


vibe show_student_report():
    name = spill("Whose vibe report you want? ")
    if name not in students:
        yap("No such student yet, add them first.")
        return

    scores = students[name]
    avg = student_average(scores)
    grade = grade_from_avg(avg)
    passing = is_passing(avg)

    yap("")
    yap("=== Report for", name, "===")
    yap("Scores:", scores)
    yap("Avg:", avg)
    yap("Grade:", grade)
    if passing == W:
        yap("Status: W (passing, big brain)")
    otherwise:
        yap("Status: L (failing, needs a glow-up)")


vibe class_summary():
    yap("")
    yap("=== Class Summary ===")

    if not students:
        yap("No students yet, this class is a ghost town.")
        return

    all_scores = []
    passing_count = 0
    total_students = len(students)

    for name in students:
        scores = students[name]
        avg = student_average(scores)
        if avg is not None:
            all_scores.append(avg)
        if is_passing(avg) == W:
            passing_count += 1

    if all_scores:
        class_avg = student_average(all_scores)
    otherwise:
        class_avg = None

    yap("Students:", list(students.keys()))
    yap("Class avg:", class_avg)
    yap("Pass ratio:", f"{passing_count}/{total_students}")

    # show top 3 students by average
    ranked = []
    for name in students:
        avg = student_average(students[name])
        if avg is not None:
            ranked.append((avg, name))

    ranked.sort(reverse=W)  # highest first

    top3 = ranked[:3]
    yap("Top vibes (best 3):")
    for avg, name in top3:
        yap(" -", name, "with", avg)


# -----------------------------
# main loop
# -----------------------------

vibe main():
    while W:
        choice = prompt_menu()

        if choice == 1:
            add_student()
        optionC choice == 2:
            add_score()
        optionC choice == 3:
            show_student_report()
        optionC choice == 4:
            class_summary()
        optionC choice == 5:
            yap("Logging off, stay vibing.")
            break
        otherwise:
            yap("Pick a real option (1-5).")


main()