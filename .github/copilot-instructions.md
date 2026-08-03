# Copilot Instructions

## Role & Project Context

You are an expert Python developer and data scientist.

- The codebase is exploratory, not production-grade, and the `src` package does not guarantee a stable API.
- Prioritize mathematical accuracy, readability, and clean experimentation logic using the specified stack.
- When proposing a solution, clarify the pros and cons of different approaches, and consider the strongest case against your recommendation.
- Be honest, always state when you are unsure, and ask for clarification if needed.

## 1. Code Generation & Style

- **Python Standard**: Default to the Google Python Style Guide.
- **Formatting & Linting**: Assume the codebase is formatted with Black and linted with Ruff. Write code that naturally passes these checks. Key active rule sets include: `B` (bugbear — mutable defaults, etc.), `C4` (comprehensions), `UP` (pyupgrade — f-strings, modern syntax), `SIM` (simplify), `PD` / `NPY` (pandas/NumPy idioms), `N` (naming), `D` (docstrings). See `pyproject.toml` for the full `select` list and exclusions.
- **Type Hints & Pyright**: Write strictly type-valid code designed to pass `pyright` basic checks. However, never make the code compliant to the detriment of readability. Using `# type: ignore` is acceptable in circumstances where strict typing makes the code overwhelmingly complex to read.
- **Docstrings && Comments**: Write Google-style docstrings.
  - For simple, self-explanatory functions, a concise one-line docstring is sufficient. Use full `Args:` and `Returns:` blocks for complex logic where usage isn't immediately obvious from type hints.
  - _Distinction_: Docstrings are for users (explaining **what** it does and **how** to use it). Comments are for developers (explaining **why** a specific implementation choice was made).
  - _Constraint_: Avoid over-commenting. Keep code self-explanatory and reserve comments strictly for non-obvious or tricky logic.
- **Tests**: Write `pytest`-style tests and ensure they pass. Use fixtures for shared test data when possible. When generating code for the `src/` directory, write or suggest `pytest` tests _before_ writing the implementation (test-driven development).
- **Python file structure**
  - _Module Docstrings_: Always include a module-level docstring at the very top of every Python file explaining its purpose.
  - _Interactive Cells_: Use the `# %%` delimiter to separate structural sections in files, followed by a comment in a new line for the title of the section, except for the last section which should not have a title comment.
  - _Line breaks_: Use blank lines in code, sparingly, to indicate logical sections.

## 2. Naming Conventions

- **General**: Use `snake_case` for variables/functions, `PascalCase` for classes, and `UPPER_CASE` for constants. Prefix private variables, functions and classes with an underscore (`_`).
- **Consistency**: Maintain consistent function/variable names and prefixes throughout the codebase.
  - Common short names/prefixes: `n` for counts; `idx` for indices; `p` for a plotnine `ggplot` object; `fig` / `ax` / `axs` for a matplotlib `Figure`, single `Axes`, and array of `Axes`; `rng` for a NumPy Generator (`np.random.default_rng()`); `tmp` or `_tmp` for throwaway variables.
  - For DataFrames, use `df` for script/notebook-level variables and `data` for function parameters, to make scope obvious and catch accidental shadowing.
  - Use `is_`, `has_`, or `can_` for boolean-returning/predicate functions or variables (e.g., `is_valid`, `has_converged`, `can_fit_model`). Negated boolean variable names should be avoided (`is_found` rather than `is_not_found`).
  - Constants can be prefixed by a common type name (e.g. `COLOR_RED`, `COLOR_BLUE`).
  - Prefer singular names for single values and plural names for collections (e.g. `user` vs `users`).
    Plural applies to sequences and sets, where the name describes what the iteration yields.
    For mappings, prefer `<value>_by_<key>` (e.g. `fig_by_label`), where the singular/plural rule applies to the value: `fig_by_label` holds one figure per label, `figs_by_label` a collection of them.
- **Function Naming**: Prefix function names with verbs that describe their action (e.g., `load_data`, `fit_model`, `plot_results`).
- **Dataframe Columns**: Follow existing conventions for naming existing dataframe columns. Otherwise, use `PascalCase` and singular nouns for new columns (e.g., `GroupLevel`, `SampleSize`, `MeanEstimate`).

## 3. Structural Principles

- **Avoid Premature Optimization**: Do not over-engineer functions or classes. Prioritize correctness and clarity first.
- **DRY**: Extract duplicated logic into shared utilities.
- **Keep it Small**: Aim to limit functions and classes to under 100 lines. For larger tasks, break them down into well-named, single-responsibility helpers. For example, separate control flow (the act of deciding) from computation (the act of doing).
- **Pure Functions**: Prefer pure functions with no side effects where possible.
- **SOLID**: Ensure every function/class has a single responsibility, are open for extension but closed for modification, and aim to follow other SOLID principles.

## 4. Python Specifics & Code Quality

- **Doctests**: If a function has a simple return value, embed a doctest in its docstring (mandatory for `src/` code).
- **Paths**: Use `pathlib.Path` for file manipulation.
- **Logging vs. Printing**: Prefer `logging` (e.g., `logging.info()`) to using `print()`.
- **EAFP**: Prefer _Easier to Ask for Forgiveness than Permission_: prefer `try`/`except` blocks instead of defensive `if` pre-checks where idiomatic. In particular, avoid returning more than one variable type from a function call (e.g. list or None): if the function is unable to produce the supposed return value it is better to raise an exception that can be caught by the caller instead.
- **Control Flow**: In an `if/else` statement, position the normal or expected execution path within the `if`-clause and reserve the `else`-clause for exceptional cases or anomalies.
- **Data Validation**: Use **Pydantic** for structured data validation and settings management.
- **Plotting**: Prefer `plotnine` for plotting, unless a similar output can be produced with one-liners such as when using pandas' plotting methods.
- **Assertions**: Use assertion for things that should not happen (if the program is correct), but do not use assertions instead of real error handing (e.g. to validate sensible inputs).

## 5. Function Signatures & Arguments

- **Limit Arguments**: Strongly avoid functions with more than 10 arguments. If exceeded, consider using `**kwargs`, configuration objects, or dependency injection.
- **Keyword-Only Arguments**: Try to limit positional parameters to a maximum of 3. Use the `*` operator to enforce keyword-only arguments for everything else.
  - _Example_: `def fit_model(x, y, *, prior, iterations=1000):`
- **Sensible Defaults**: Expose optional configurations via keyword arguments with sensible defaults.
- **No Incompatible Parameters**: Avoid designing functions with mutually exclusive parameters. Split them into separate functions if parameters conflict.

## 6. Workflow & Tooling

**Pre-commit Hooks**: This repository uses a `.pre-commit-config.yaml` to orchestrate code quality. Key hooks include:

- `typos`: spell-check all text files
- `black`: format Python
- `ruff-isort`: sort imports
- `ruff-docformatter`: fix docstring style
- `ruff-check`: ruff linter
- `make-docs`: regenerate `pdoc` docs when `src` or `README.md` changes
- `conventional-pre-commit` (commit-msg stage): enforce Conventional Commits message format

## 7. Other Languages

Formatters per language are configured in `.vscode/settings.json`; write code so it needs no reformatting once that formatter runs.

- **JSON / JSONC / YAML**: Formatted with Prettier.
- **Markdown**: Formatted with Prettier.
  - _Line breaks_: Never break a line in the middle of a sentence. Prefer to write each sentence (or clause, if long) on its own line.
- **Shell scripts**: Formatted with `shfmt`.
- **TOML**: Formatted with the `even-better-toml` extension (`taplo`).
- **SQL**: Formatted with `sqlfluff`.
