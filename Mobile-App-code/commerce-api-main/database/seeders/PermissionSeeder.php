<?php

namespace Database\Seeders;

use App\Models\Permission;
use App\Models\Role;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

class PermissionSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $permissions = collect(getModels())->map(function ($model) {
            $m = explode('\\', $model)[3];

            return [$m.' Create', $m.' View', $m.' Update', $m.' Delete',
                $m.' Store', $m.' Show', $m.' Index', $m.' Edit'];
        })->flatten()->map(function ($permission) {
            return Permission::factory()->create([
                'name' => Str::slug($permission, '_'),
                'label' => $permission,
            ]);
        });

        collect([
            'customer' => 'The customer or account holder.',
            'teller' => 'Help customer with routine financial transactions.',
            'loan officer' => 'Some common banking careers are investment banker, bank teller, loan officer and banking associate.',
            'investment banker' => 'an investment banker advising their clients on stock options requires knowledge of the viability of the companies they advise.',
            'auditor' => 'The internal auditor offers recommendations for streamlining banking operations and garnering more profits in the long run.',
            'financial analyst' => 'As a financial analyst, you help businesses or individuals make investment decisions.',
            'asset manager' => 'An asset manager\'s job is a combination of selling, advising, consulting and providing customer service.',
            'financial advisor' => 'A financial advisor at a bank helps clients find ways to best manage their money using short-term and long-term investment planning.',
            'branch manager' => 'A branch manager\'s job is to oversee all operations and staff in a single branch.',
            'budget analyst' => 'A budget analyst often generates reports throughout the year to detail how a company spends money, along with cost improvements, efficiency suggestions.',
            'credit analyst' => 'A credit analyst collects financial information on various people and businesses such as debts, payment history, savings and valuable properties.',

            /**
             * C-level Management:
             * At the top of the business hierarchy
             * C-level executives are high-ranking individuals who excel in
             * their respective areas within an organization.
             */
            'chief Operating Officer' => 'The COO focuses on day-to-day operations within the company. Typically, the COO is second-in-command, with an acute focus on implementing the strategies and plans developed by the CEO.',
            'chief financial officer' => 'The CFO manages financial matters for the organization, including budgeting, forecasting, reporting and compliance activities.',
            'chief executive officer' => 'The CEO oversees the entire organization by handling top-level policies and plans.',
            'chief marketing officer' => 'The CMO oversees the marketing department to conduct brand management, marketing strategy, client communications and industry research.',
            'chief information officer' => 'The CIO handles strategic planning for the information technology department.',
            'chief technology officer' => 'The CTO manages technology, research and development for an organization.',
            'chief human resources officer' => 'The CHRO manages the individuals working within the organization and oversees the human resources department.',
            'chief compliance officer' => "This CCO is usually the head of the company's compliance department. This job includes handling the company's compliance with applicable rules, regulations, policies and laws.",
            'chief security officer' => "The CSO works in the company's security department. People in this position create strategies for new programs and policies to protect safety.",
            'chief innovation officer' => 'The CINO generates new ideas and identifies opportunities for innovation and change that can propel the company forward.',

            /**
             * V-level Management:
             * Vice Presidents (VPS) and Senior Vice Presidents (SVPS) who report to
             * C-level Management
             */
            'Director of learning' => 'V-level Management: Vice Presidents (VPS) and Senior Vice Presidents (SVPS) who report to C-level Management.',
            'Director of sales' => 'V-level Management: Vice Presidents (VPS) and Senior Vice Presidents (SVPS) who report to C-level Management.',

            /**
             * B-level Management:
             * Mid-level managers (e.g., Sales Manager) who report to D-level Management
             */
            'Sales Manager' => 'B-level Management: Mid-level managers (e.g., Sales Manager) who report to D-level Management.',
            'Marketing Manager' => 'B-level Management: Mid-level managers (e.g., Sales Manager) who report to D-level Management.',
            'Team Lead' => 'B-level Management: Mid-level managers (e.g., Sales Manager) who report to D-level Management.',

        ])->each(function ($description, $role) use ($permissions) {
            $role = Role::create([
                'name' => Str::slug($role),
                'label' => Str::ucfirst($role),
                'description' => $description,
                'is_system' => 1,
            ]);
            $permissions->each(fn ($permission) => $role->givePermissionTo($permission));
        });
    }
}
