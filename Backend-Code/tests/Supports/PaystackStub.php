<?php

namespace Tests\Supports;

use Illuminate\Support\Facades\Http;

trait PaystackStub
{
    protected $baseUrl = 'https://api.paystack.co';

    protected $reference;

    public function verificationResponse(): \GuzzleHttp\Promise\PromiseInterface
    {
        return Http::Response($this->verificationData());
    }

    public function verificationUrl(int $reference = 142065094): string
    {
        $this->reference = $reference;

        return $this->baseUrl."/transaction/verify/{$reference}";
    }

    protected function verificationData(): object
    {
        return json_decode(json_encode([
            'data' => [
                'id' => 2578850998,
                'domain' => 'test',
                'status' => 'success',
                'reference' => '142065094',
                'amount' => 300000,
                'message' => null,
                'gateway_response' => 'Successful',
                'paid_at' => '2023-02-28T13:54:38.000Z',
                'created_at' => '2023-02-28T13:54:33.000Z',
                'channel' => 'card',
                'currency' => 'NGN',
                'ip_address' => '102.68.109.33',
                'metadata' => [
                    'cart_id' => 1,
                    'referrer' => 'http://localhost:8000/payment',
                ],
                'log' => [
                    'start_time' => 1677592474,
                    'time_spent' => 5,
                    'attempts' => 1,
                    'errors' => 0,
                    'success' => true,
                    'mobile' => false,
                    'input' => [
                    ],
                    'history' => [
                        [
                            'type' => 'action',
                            'message' => 'Attempted to pay with card',
                            'time' => 4,
                        ],
                        [
                            'type' => 'success',
                            'message' => 'Successfully paid with card',
                            'time' => 5,
                        ],
                    ],
                ],
                'fees' => 14500,
                'fees_split' => null,
                'authorization' => [
                    'authorization_code' => 'AUTH_91g1wr32nm',
                    'bin' => '408408',
                    'last4' => '4081',
                    'exp_month' => '12',
                    'exp_year' => '2030',
                    'channel' => 'card',
                    'card_type' => 'visa ',
                    'bank' => 'TEST BANK',
                    'country_code' => 'NG',
                    'brand' => 'visa',
                    'reusable' => true,
                    'signature' => 'SIG_eUi8qCAplXphzoVOgFnz',
                    'account_name' => null,
                    'receiver_bank_account_number' => null,
                    'receiver_bank' => null,
                ],
                'customer' => [
                    'id' => 101868752,
                    'first_name' => '',
                    'last_name' => '',
                    'email' => 'senenerst@gmail.com',
                    'customer_code' => 'CUS_57p7rcukypkyybz',
                    'phone' => '',
                    'metadata' => null,
                    'risk_action' => 'default',
                    'international_format_phone' => null,
                ],
                'plan' => null,
                'split' => [
                ],
                'order_id' => null,
                'paidAt' => '2023-02-28T13:54:38.000Z',
                'createdAt' => '2023-02-28T13:54:33.000Z',
                'requested_amount' => 300000,
                'pos_transaction_data' => null,
                'source' => null,
                'fees_breakdown' => null,
                'transaction_date' => '2023-02-28T13:54:33.000Z',
                'plan_object' => [
                ],
                'subaccount' => [
                ],
            ],
        ]), false);
    }

    public function referenceId()
    {
        return $this->reference;
    }
}
