<?php

namespace Espo\Custom\Hooks\Session;

use Espo\Core\Exceptions\BadRequest;
use Espo\ORM\Entity;
use Espo\ORM\EntityManager;

class OverlapCheck
{
    public static int $order = 9;

    private EntityManager $entityManager;

    public function __construct(EntityManager $entityManager)
    {
        $this->entityManager = $entityManager;
    }

    public function beforeSave(Entity $entity, array $options = []): void
    {
        if ($entity->get('status') === 'cancelled') {
            return;
        }

        $specialistId = $entity->get('specialistId');
        $startAt = $entity->get('startAt');
        $endAt = $entity->get('endAt');

        if (!$specialistId || !$startAt || !$endAt) {
            return;
        }

        $startTimestamp = strtotime($startAt);
        $endTimestamp = strtotime($endAt);

        if ($startTimestamp === false || $endTimestamp === false) {
            throw new BadRequest(
                'Некорректная дата или время записи.'
            );
        }

        if ($endTimestamp <= $startTimestamp) {
            throw new BadRequest(
                'Окончание записи должно быть позже начала.'
            );
        }

        $where = [
            'specialistId' => $specialistId,
            'status!=' => 'cancelled',
            'startAt<' => $endAt,
            'endAt>' => $startAt,
        ];

        if ($entity->getId()) {
            $where['id!='] = $entity->getId();
        }

        $overlap = $this->entityManager
            ->getRDBRepository('Session')
            ->where($where)
            ->findOne();

        if ($overlap) {
            throw new BadRequest(
                'У этого исполнителя уже есть запись на выбранное время.'
            );
        }
    }
}