## Error for 1_Default_Xgboost

cannot import name 'SequenceNotStr' from 'pandas._typing' (/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/pandas/_typing.py)
Traceback (most recent call last):
  File "/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/supervised/base_automl.py", line 1178, in _fit
    trained = self.train_model(params)
              ^^^^^^^^^^^^^^^^^^^^^^^^
  File "/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/supervised/base_automl.py", line 384, in train_model
    mf.train(results_path, model_subpath)
  File "/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/supervised/model_framework.py", line 249, in train
    learner.fit(
  File "/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/supervised/algorithms/xgboost.py", line 235, in fit
    result.to_csv(log_to_file, index=False, header=False)
  File "/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/pandas/util/_decorators.py", line 211, in wrapper
    raise TypeError(msg)
  File "/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/pandas/core/generic.py", line 3720, in to_csv
    from pandas.io.formats.style import Styler
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/pandas/util/_decorators.py", line 211, in wrapper
    raise TypeError(msg)
  File "/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/pandas/io/formats/format.py", line 1162, in to_csv
  File "/Users/yjtseng/Library/R/x86_64/4.1/library/reticulate/python/rpytools/loader.py", line 119, in _find_and_load_hook
    return _run_hook(name, _hook)
           ^^^^^^^^^^^^^^^^^^^^^^
  File "/Users/yjtseng/Library/R/x86_64/4.1/library/reticulate/python/rpytools/loader.py", line 93, in _run_hook
    module = hook()
             ^^^^^^
  File "/Users/yjtseng/Library/R/x86_64/4.1/library/reticulate/python/rpytools/loader.py", line 117, in _hook
    return _find_and_load(name, import_)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/pandas/io/formats/csvs.py", line 24, in <module>
    from pandas._typing import SequenceNotStr
ImportError: cannot import name 'SequenceNotStr' from 'pandas._typing' (/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/pandas/_typing.py)


Please set a GitHub issue with above error message at: https://github.com/mljar/mljar-supervised/issues/new

## Error for 2_Default_NeuralNetwork

cannot import name 'SequenceNotStr' from 'pandas._typing' (/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/pandas/_typing.py)
Traceback (most recent call last):
  File "/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/supervised/base_automl.py", line 1178, in _fit
    trained = self.train_model(params)
              ^^^^^^^^^^^^^^^^^^^^^^^^
  File "/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/supervised/base_automl.py", line 384, in train_model
    mf.train(results_path, model_subpath)
  File "/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/supervised/model_framework.py", line 249, in train
    learner.fit(
  File "/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/supervised/algorithms/nn.py", line 60, in fit
    result.to_csv(log_to_file, index=False, header=False)
  File "/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/pandas/util/_decorators.py", line 211, in wrapper
    raise TypeError(msg)
  File "/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/pandas/core/generic.py", line 3720, in to_csv
    from pandas.io.formats.style import Styler
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/pandas/util/_decorators.py", line 211, in wrapper
    raise TypeError(msg)
  File "/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/pandas/io/formats/format.py", line 1162, in to_csv
  File "/Users/yjtseng/Library/R/x86_64/4.1/library/reticulate/python/rpytools/loader.py", line 119, in _find_and_load_hook
    return _run_hook(name, _hook)
           ^^^^^^^^^^^^^^^^^^^^^^
  File "/Users/yjtseng/Library/R/x86_64/4.1/library/reticulate/python/rpytools/loader.py", line 93, in _run_hook
    module = hook()
             ^^^^^^
  File "/Users/yjtseng/Library/R/x86_64/4.1/library/reticulate/python/rpytools/loader.py", line 117, in _hook
    return _find_and_load(name, import_)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/pandas/io/formats/csvs.py", line 24, in <module>
    from pandas._typing import SequenceNotStr
ImportError: cannot import name 'SequenceNotStr' from 'pandas._typing' (/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/pandas/_typing.py)


Please set a GitHub issue with above error message at: https://github.com/mljar/mljar-supervised/issues/new

## Error for 3_Default_RandomForest

cannot import name 'SequenceNotStr' from 'pandas._typing' (/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/pandas/_typing.py)
Traceback (most recent call last):
  File "/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/supervised/base_automl.py", line 1178, in _fit
    trained = self.train_model(params)
              ^^^^^^^^^^^^^^^^^^^^^^^^
  File "/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/supervised/base_automl.py", line 384, in train_model
    mf.train(results_path, model_subpath)
  File "/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/supervised/model_framework.py", line 249, in train
    learner.fit(
  File "/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/supervised/algorithms/sklearn.py", line 178, in fit
    df_result.to_csv(log_to_file, index=False, header=False)
  File "/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/pandas/util/_decorators.py", line 211, in wrapper
    raise TypeError(msg)
  File "/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/pandas/core/generic.py", line 3720, in to_csv
    from pandas.io.formats.style import Styler
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/pandas/util/_decorators.py", line 211, in wrapper
    raise TypeError(msg)
  File "/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/pandas/io/formats/format.py", line 1162, in to_csv
  File "/Users/yjtseng/Library/R/x86_64/4.1/library/reticulate/python/rpytools/loader.py", line 119, in _find_and_load_hook
    return _run_hook(name, _hook)
           ^^^^^^^^^^^^^^^^^^^^^^
  File "/Users/yjtseng/Library/R/x86_64/4.1/library/reticulate/python/rpytools/loader.py", line 93, in _run_hook
    module = hook()
             ^^^^^^
  File "/Users/yjtseng/Library/R/x86_64/4.1/library/reticulate/python/rpytools/loader.py", line 117, in _hook
    return _find_and_load(name, import_)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/pandas/io/formats/csvs.py", line 24, in <module>
    from pandas._typing import SequenceNotStr
ImportError: cannot import name 'SequenceNotStr' from 'pandas._typing' (/Library/Frameworks/Python.framework/Versions/3.11/lib/python3.11/site-packages/pandas/_typing.py)


Please set a GitHub issue with above error message at: https://github.com/mljar/mljar-supervised/issues/new

