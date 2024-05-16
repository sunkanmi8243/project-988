<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Illuminate\Testing\Fluent\AssertableJson;
use Tests\TestCase;

class PhoneVerificationTest extends TestCase
{
    use RefreshDatabase, WithFaker;

    /** @test */
    public function it_should_send_verification_notification()
    {

        $user = User::factory()->create();

        $response = $this->actingAs($user, 'api')
            ->postJson(route('v1.users.store'), [
                'phone' => '+2349066688990',
            ])->assertOk();

        $response->assertJson(fn (AssertableJson $json) => $json
            ->where('status', true)
            ->where('message', 'success')
            ->where('data.phone_verified_at', false)
            ->etc()
        );
    }

    /** @test */
    public function it_should_send_verification_verify()
    {

        $user = User::factory()->create();

        $response = $this->actingAs($user, 'api')
            ->postJson(route('v1.users.verify'), [
                'code' => '88990',
            ])->assertOk();

        $response->assertJson(fn (AssertableJson $json) => $json
            ->where('status', true)
            ->where('message', 'success')
            ->where('data.phone_verified_at', true)
            ->etc()
        );
    }
}
