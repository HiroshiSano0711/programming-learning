import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

import java.io.Reader;
import java.io.StringReader;

class LexerTest {

	@Test
	void testToken() {
		Reader reader = new StringReader("1234 5678");
		Lexer lex = new Lexer(reader);
		while(lex.advance()) {
			assertEquals(lex.token(), TokenType.INT);
		}
	}

	@Test
	void testValue() {
		Reader reader = new StringReader("1234 5678");
		Lexer lex = new Lexer(reader);
		if(lex.advance()) {
			assertEquals(lex.value(), new Integer(1234));
		} else {
			fail();
		}
		if(lex.advance()) {
			assertEquals(lex.value(), new Integer(5678));
		} else {
			fail();
		}
	}

}
