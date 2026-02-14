# CLAUDE.md

## Project Overview

This is a quantitative research project using Python.

## Environment

- Python 3.10+
- Use `uv` for dependency management
- Create virtual environments: `uv venv`
- Add dependencies: `uv add <package>`
- Sync environment: `uv sync`
- **Never** use `uv pip` — always use `uv add`, `uv sync`, and `uv run` instead

## Code Style

- Follow PEP 8 conventions
- Use type hints for all function signatures
- Use `numpy`-style docstrings for public functions
- Prefer `pathlib.Path` over `os.path`
- Use f-strings for string formatting

## Data & Computation

- Use `polars` for dataframe operations, `numpy` for numerical arrays
- Use `scipy` and `statsmodels` for statistical analysis
- Use `matplotlib` and `seaborn` for plotting
- Store data in `data/` directory (never commit large data files)
- Store outputs and figures in `output/`

## Testing

- Run tests: `pytest tests/`
- Write tests for all data transformations and numerical functions
- Use `numpy.testing` assertions (e.g., `assert_allclose`) for floating-point comparisons

## Research Practices

- Keep notebooks in `notebooks/` for exploration only; move production code to `src/`
- All results must be reproducible — set random seeds explicitly
- Log experiment parameters and results
- Validate data at ingestion: check for NaNs, dtypes, and expected ranges
