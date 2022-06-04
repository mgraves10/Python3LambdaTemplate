from __future__ import annotations

from pylambda.handler import handler


def test_handler():
    assert handler({}, {}).get("statusCode") == 200, "Handler returns successful status code"
