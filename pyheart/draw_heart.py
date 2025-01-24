import math
import tkinter as tk

# Draw a smooth heart shape
def draw_heart(canvas, color, x, y, size):
    points = []
    for t in range(0, 360, 1):
        t_rad = t / 180 * math.pi
        x_pos = int(size * 16 * (math.sin(t_rad) ** 3))
        y_pos = int(
            size
            * (
                13 * math.cos(t_rad)
                - 5 * math.cos(2 * t_rad)
                - 2 * math.cos(3 * t_rad)
                - math.cos(4 * t_rad)
            )
        )
        points.append((x + x_pos, y - y_pos))
    canvas.create_polygon(points, outline=color, fill=color)

if __name__ == "__main__":
    root = tk.Tk()
    root.title("Heart Shape")
    canvas = tk.Canvas(root, width=800, height=600, bg="white")
    canvas.pack()
    draw_heart(canvas, "red", 400, 300, 10)
    root.mainloop()
