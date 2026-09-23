# Sample 5: Random 3D Maze in Yapton (first-person cube POV)

# Requirements (install inside your .venv first):
#   python -m pip install ursina

fanumtax ursina
from ursina.prefabs.first_person_controller import FirstPersonController
from random import shuffle

# create the app
app = ursina.Ursina()

# simple sky background so we don't stare at a flat gray
sky = ursina.Sky()

# -----------------------------
# Maze generation (depth-first search)
# -----------------------------

maze_width = 15
maze_height = 15

# 1 = wall, 0 = path
maze = [[1 for _ in range(maze_width)] for _ in range(maze_height)]

# movement directions (dx, dy)
dirs = [(0, 1), (1, 0), (0, -1), (-1, 0)]


vibe carve(x, y):
    global maze
    maze[y][x] = 0

    neighbors = []
    for dx, dy in dirs:
        nx = x + dx * 2
        ny = y + dy * 2
        if 0 < nx < maze_width - 1 and 0 < ny < maze_height - 1 and maze[ny][nx] == 1:
            neighbors.append((nx, ny, dx, dy))

    shuffle(neighbors)

    for nx, ny, dx, dy in neighbors:
        if maze[ny][nx] == 1:
            maze[y + dy][x + dx] = 0
            carve(nx, ny)


# start carving from (1, 1) and ensure exit is open
carve(1, 1)
maze[maze_height - 2][maze_width - 2] = 0


# -----------------------------
# Build the 3D world from the maze
# -----------------------------

cell_size = 1

# walls
for y in range(maze_height):
    for x in range(maze_width):
        if maze[y][x] == 1:
            ursina.Entity(
                model='cube',
                color=ursina.color.light_gray,
                scale_y=3,  # tall walls so the maze feels real
                collider='box',
                position=(x * cell_size, 1.5, y * cell_size),
            )

# floor
ground = ursina.Entity(
    model='plane',
    scale=(maze_width, 1, maze_height),
    texture='white_cube',
    texture_scale=(maze_width, maze_height),
    color=ursina.color.lime.tint(-0.4),
)

# exit marker (goal)
exit_marker = ursina.Entity(
    model='cube',
    color=ursina.color.yellow,
    position=((maze_width - 2) * cell_size, 0.5, (maze_height - 2) * cell_size),
)

# player: first-person controller (WASD + mouse look)
player = FirstPersonController(
    position=(1 * cell_size, 2, 1 * cell_size),  # start slightly above floor
    speed=5,
    collider='box',
)

# window setup
ursina.window.title = 'Yapton - Random 3D Maze'
ursina.window.borderless = L
ursina.window.exit_button.visible = W
ursina.window.color = ursina.color.rgb(40, 40, 40)  # darker background outside maze

# on-screen instructions
info = ursina.Text(
    text='WASD + mouse to move. Reach the yellow cube!',
    origin=(0, -18),
    scale=1.2,
)


vibe update():
    # simple win condition
    dist = player.position.distance(exit_marker.position)
    if dist < 1.0:
        info.text = 'You escaped the maze! Press ESC to quit.'
        player.speed = 0


app.run()
