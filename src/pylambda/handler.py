from __future__ import annotations


def handler(event: dict, context: dict) -> dict:
    """
    Entrypoint
    """
    return {
        "isBase64Encoded": False,
        "statusCode": 200,
        "body": '{"status": "success"}',
    }
