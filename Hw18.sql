CREATE TABLE `pets`
(
    `id`         INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `name`       VARCHAR(100) NOT NULL,
    `breed`      VARCHAR(100) NOT NULL,
    `age`        INT          NOT NULL,
    `type`       VARCHAR(100) NOT NULL,
    `microchip`  CHAR(10) UNIQUE NULL CHECK (LENGTH (`microchip`) = 10),
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted_at` TIMESTAMP DEFAULT NULL
);

CREATE TABLE `owners`
(
    `id`         INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `name`       VARCHAR(100)        NOT NULL,
    `email`      VARCHAR(100) UNIQUE NOT NULL,
    `phone`      CHAR(12)            NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted_at` TIMESTAMP DEFAULT NULL
);

CREATE TABLE `vaccinations`
(
    `id`         INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `name`       VARCHAR(100) NOT NULL,
    `date`       DATE         NOT NULL,
    `pet_id`     INT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted_at` TIMESTAMP DEFAULT NULL,
    FOREIGN KEY (`pet_id`) REFERENCES `pets` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `pets_owners`
(
    `id`         INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `pet_id`     INT UNSIGNED NOT NULL,
    `owner_id`   INT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted_at` TIMESTAMP DEFAULT NULL,
    FOREIGN KEY (`pet_id`) REFERENCES `pets` (`id`) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (`owner_id`) REFERENCES `owners` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
);


INSERT INTO `pets` (`name`, `breed`, `age`, `type`, `microchip`)
VALUES ('Charlie', 'Labrador', 3, 'Dog', '1234567890'),
       ('Bella', 'Siamese', 5, 'Cat', NULL),
       ('Max', 'Beagle', 4, 'Dog', '0987654321'),
       ('Lucy', 'Persian', 2, 'Cat', '1122334455'),
       ('Buddy', 'Sphynx', 1, 'Cat', NULL);

INSERT INTO `owners` (`name`, `email`, `phone`)
VALUES ('Ivan Petrov', 'ivan.petrov@example.com', '380501234567'),
       ('Olena Koval', 'olena.koval@example.com', '380671234567'),
       ('Andriy Melnyk', 'andriy.melnyk@example.com', '380931234567');

INSERT INTO `vaccinations` (`name`, `date`, `pet_id`)
VALUES ('Rabies', '2023-01-10', 1),
       ('Distemper', '2023-02-15', 1),
       ('Rabies', '2023-03-05', 2),
       ('Leukemia', '2023-04-20', 2),
       ('Rabies', '2023-05-25', 3),
       ('Distemper', '2023-06-30', 3),
       ('Leukemia', '2023-07-15', 4),
       ('Rabies', '2023-08-05', 4),
       ('Distemper', '2023-09-10', 5),
       ('Leukemia', '2023-10-15', 5);

INSERT INTO `pets_owners` (`pet_id`, `owner_id`)
VALUES (1, 1),
       (2, 1),
       (3, 2),
       (4, 2),
       (5, 3);

SELECT `name`, `type`
FROM `pets`;

SELECT p.`name` AS pet_name, v.`name` AS vaccination, v.`date`
FROM `pets` p
         JOIN `vaccinations` v ON p.`id` = v.`pet_id`
ORDER BY p.`name`, v.`date`;

SELECT p.`name`, COUNT(v.`id`) AS vaccination_count
FROM `pets` p
         JOIN `vaccinations` v ON p.`id` = v.`pet_id`
GROUP BY p.`name`
ORDER BY vaccination_count DESC;

SELECT o.`name`, COUNT(po.`pet_id`) AS pets_owned
FROM `owners` o
         JOIN `pets_owners` po ON o.`id` = po.`owner_id`
GROUP BY o.`name`
HAVING COUNT(po.`pet_id`) > 1;


UPDATE `pets`
SET `age` = 4
WHERE `name` = 'Buddy';

UPDATE `owners`
SET `phone` = '380951234567'
WHERE `name` = 'Ivan Petrov';


DELETE
FROM `pets`
WHERE `name` = 'Max';