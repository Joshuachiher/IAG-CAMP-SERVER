/*
  Warnings:

  - You are about to drop the column `question_text` on the `Question` table. All the data in the column will be lost.
  - Added the required column `questionTextEn` to the `Question` table without a default value. This is not possible if the table is not empty.
  - Added the required column `questionTextId` to the `Question` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Question" DROP COLUMN "question_text",
ADD COLUMN     "description" TEXT,
ADD COLUMN     "key" TEXT,
ADD COLUMN     "placeholder" TEXT,
ADD COLUMN     "questionTextEn" TEXT NOT NULL,
ADD COLUMN     "questionTextId" TEXT NOT NULL;
