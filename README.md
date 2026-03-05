# R Test Solutions

This Readme.md contains solutions to R programming tasks categorized into three levels of difficulty.

Each solution is implemented in R and includes an interactive visualization hosted on GitHub Pages.

---

## Solutions

### 1. Easy Test Solution
- **Energy types Visualization**: [Github Pages Link](https://nandaniaggarwal.github.io/energy-types-india-animation/)
- **Source Code**: [easy_test_solution/main.R](https://github.com/NandaniAggarwal/energy/blob/main/figure-energy.R)
- an error that I saw when animint2 is loaded/attached at the same time as standard ggplot2 : function masking occured, leading to conflicts.
  `Attaching package: ‘animint2’
The following objects are masked from ‘package:ggplot2’:
` and many functions like `geom_blank, geom_point, geom_rect, geom_segment, geom_text` were masked

---

### 2. Medium Test Solutions
- **Bootstrapping the iid data**: [Animation](https://nandaniaggarwal.github.io/boot.iid_animation_R/)
- **Source Code**: [medium_test_newtons_method_code/newtons_root.R](https://github.com/NandaniAggarwal/animint_R/blob/main/bootid.R)

---

- **Bootstrapping with LOWESS**: [Animation](https://nandaniaggarwal.github.io/boot.lowess_animations_R/)
- **Code Link**: [medium_test_solution/main.R](https://github.com/NandaniAggarwal/animint_R/blob/main/bootlowess.R)

---

- **Demonstration of Simple sampling**: [Animation](https://nandaniaggarwal.github.io/sample.simple_R/)
- **Code Link**: [medium_test_solution.R](https://github.com/NandaniAggarwal/animint_R/blob/main/samplesimple.R)

---
- **Demonstration of stratified sampling**: [Animation](https://nandaniaggarwal.github.io/sample.strat_R)
- **Code Link**: [medium_test_solution.R](https://github.com/NandaniAggarwal/animint_R/blob/main/samplestrat.R)

---

### 3. Medium-Hard Test Solution
- **Gallery Link**: [nandani-animint-gallery](https://nandaniaggarwal.github.io/Nandani-Animint-Gallery/)
- **Code Link**: [nandani-animint-gallery/index.Rmd](https://github.com/NandaniAggarwal/Nandani-Animint-Gallery/blob/gh-pages/index.Rmd)

---
### 4. Hard Test Solution
- **Video Link**: [bootstrap-sampling-test-render](https://www.youtube.com/watch?v=yonNciNhkFc)
- **PR link**: [bootstrap-sampling-test-render](https://github.com/animint/animint2/pull/308)
