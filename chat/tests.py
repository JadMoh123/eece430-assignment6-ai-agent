from django.test import TestCase
from django.urls import reverse


class ChatPageTests(TestCase):
    """Smoke tests run by the CI pipeline. They never call the Gemini API."""

    def test_chat_page_loads(self):
        response = self.client.get(reverse("chat"))
        self.assertEqual(response.status_code, 200)

    def test_empty_message_redirects_without_calling_agent(self):
        response = self.client.post(reverse("chat"), {"message": "   "})
        self.assertRedirects(response, reverse("chat"))
