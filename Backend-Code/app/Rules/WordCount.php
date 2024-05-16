<?php

namespace App\Rules;

use Closure;
use Illuminate\Contracts\Validation\ValidationRule;

class WordCount implements ValidationRule
{
    private $attribute;

    private $expected;

    public function __construct(int $expected)
    {
        $this->expected = $expected;
    }

    /**
     * Run the validation rule.
     *
     * @param  \Closure(string): \Illuminate\Translation\PotentiallyTranslatedString  $fail
     */
    public function validate(string $attribute, mixed $value, Closure $fail): void
    {
        $this->attribute = $attribute;
        $trimmed = trim($value);
        $numWords = count(explode(' ', $trimmed));

        if ($numWords < $this->expected) {
            $fail("The :attribute field must have at least {$this->expected} words or firstname and lastname.");
        }
    }

    /**
     * Determine if the validation rule passes.
     *
     * @param  string  $attribute
     * @param  mixed  $value
     */
    public function passes($attribute, $value): bool
    {
        $this->attribute = $attribute;
        $trimmed = trim($value);
        $numWords = count(explode(' ', $trimmed));

        return $numWords === $this->expected;
    }

    /**
     * Get the validation error message.
     */
    public function message(): string
    {
        return 'The '.$this->attribute.' field must have exactly '.$this->expected.'  words';
    }
}
