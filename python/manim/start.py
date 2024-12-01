from manim import *
import numpy as np
from fractions import Fraction

class LinearTransformationExample(LinearTransformationScene):
    def __init__(self, **kwargs):
        LinearTransformationScene.__init__(
            self,
            show_coordinates=True,
            leave_ghost_vectors=False,
            foreground_plane_kwargs = {
                "x_range": np.array([-20, 20, 1.0]),
                "y_range": np.array([-20, 20, 1.0]),
                "faded_line_ratio": 1
            },
            background_plane_kwargs = {
                "x_range": (-20, 20, 1),
                "y_range": (-20, 20, 1)
            },
            **kwargs
        )

    def construct(self):
        self.camera.frame_width = 35
        self.camera.frame_height = 15
        matrix = [
            [3,1],
            [2,2]
        ]
        inverse_matrix = [
            [0.5, -0.25],
            [-0.5, 0.75]
        ]
        daiago_matrix = [
            [1,1],
            [-2,1]
        ]
        eigen_matrix = [
            [1,0],
            [0,4]
        ]
        inverse_daiago_matrix = [
            [Fraction(1, 3), Fraction(-1, 3)],
            [Fraction(2, 3), Fraction(1, 3)]
        ]
        # self.wait()
        # self.apply_matrix(base_matrix)
        # self.wait()
        # self.add_vector((1,1))
        # self.add_vector((1,-2))
        # self.apply_matrix(matrix)
        # self.apply_matrix(inverse_daiago_matrix)
        # self.wait()
        # self.apply_matrix(eigen_matrix)
        # self.wait()
        self.apply_matrix(daiago_matrix)
        self.wait()
        self.apply_matrix(matrix)
        self.wait()
        self.apply_matrix(inverse_daiago_matrix)
        # self.wait()
