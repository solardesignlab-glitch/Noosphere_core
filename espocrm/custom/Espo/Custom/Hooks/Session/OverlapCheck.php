<?php
namespace Espo\Custom\Hooks\Session;

use Espo\Core\Exceptions\BadRequest;
use Espo\ORM\Entity;
use Espo\ORM\EntityManager;

class OverlapCheck
{
    private EntityManager $entityManager;

    public function __construct(EntityManager $entityManager)
    {
        $this->entityManager = $entityManager;
    }

    public static function getOrder(): int
    {
        return 9;
    }

    public function beforeSave(Entity $entity, array $options = []): void
    {
        $status = $entity->get(status);
        if ($status === cancelled) {
            return;
        }
        $specialistId = $entity->get(specialistId);
        $startAt = $entity->get(startAt);
        $endAt = $entity->get(endAt);
        if (!$specialistId || !$startAt || !$endAt) {
            return;
        }
        if (strtotime($endAt) <= strtotime($startAt)) {
            throw new BadRequest(Окончание