import pytest
from main import Json2Tex

def test_validate_schema():
    assert Json2Tex().validate_json() == None

def test_validate_file():
    fake_schema = "path/does/not/exist"
    with pytest.raises(FileNotFoundError, match=f'File {fake_schema} does not exist.') as err:
        raise Json2Tex(resume=fake_schema).validate_file()
    assert err.type is FileNotFoundError

def test_validate_file_ext():
    fake_schema = "resources/test-dir/notfound-schema.ym"
    with pytest.raises(TypeError, match=f"File type '.ym' is not currently supported.") as err:
        raise Json2Tex(resume=fake_schema).validate_file()
    assert err.type is TypeError

def test_read_schema():
    pass

def test_render():
    pass